//
//  CLSHSetupMassInformationVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSetupMassInformationVC.h"
#import "CLSHMassInfoFooterView.h"
#import "CLSHMassInfoPersonCountCell.h"
#import "CLSHMassInfoSelectSexCell.h"
#import "CLSHMassInfoWalletCell.h"
#import "CLSHMassInfoCouponCell.h"
#import "CLSHMassInfoMininumConsumpCell.h"
#import "CLSHMassInfoEndDateCell.h"
#import "CLSHMassInfoSelectPayWayVC.h"
#import "KBDatePicker.h"
#import "CLSHSetupInfoModel.h"
#import "CLSHAdManagerModel.h"

@interface CLSHSetupMassInformationVC ()<UITableViewDelegate, UITableViewDataSource, CLSHMassInfoEndDateCellDelegate, KBDatePickerDelegate>
{
    NSString *showDatePickerTime;       ///<选择时间
    CLSHSetupInfoModel *setupInfoModel; ///<设置群发信息数据模型
    NSMutableDictionary *params;        ///<传入的参数
    MBProgressHUD *hud;
    NSInteger tag;
    
    NSString *wallet;
    NSString *lastMoney;
    NSString *couponMoney;
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)CLSHMassInfoFooterView *footerView;

@property (nonatomic,assign)BOOL isSelectNull;
@end

@implementation CLSHSetupMassInformationVC
static NSString *const personCountID = @"CLSHMassInfoPersonCountCell";
static NSString *const selectSexID = @"CLSHMassInfoSelectSexCell";
static NSString *const walletID = @"CLSHMassInfoWalletCell";
static NSString *const couponID = @"CLSHMassInfoCouponCell";
static NSString *const consumpID = @"CLSHMassInfoMininumConsumpCell";
static NSString *const endDateID = @"CLSHMassInfoEndDateCell";
static NSString *const cellID = @"Cell";

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-40*AppScale) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

-(CLSHMassInfoFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[CLSHMassInfoFooterView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-40*AppScale, SCREENWIDTH, 40*AppScale)];
        
    }
    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];

    params = [NSMutableDictionary dictionary];
    
    showDatePickerTime=[NSString string];
    //底部
    WS(weakSelf);
    self.footerView.payBlock = ^(){
        
        if ([weakSelf isValidateSuccess]) {
            [weakSelf loadData];
        }
        
    };
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"设置群发信息"];
    
    //注册cell
    [self.tableView registerClass:[CLSHMassInfoPersonCountCell class] forCellReuseIdentifier:personCountID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHMassInfoSelectSexCell" bundle:nil] forCellReuseIdentifier:selectSexID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHMassInfoWalletCell" bundle:nil] forCellReuseIdentifier:walletID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHMassInfoCouponCell" bundle:nil] forCellReuseIdentifier:couponID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHMassInfoMininumConsumpCell" bundle:nil] forCellReuseIdentifier:consumpID];
    [self.tableView registerClass:[CLSHMassInfoEndDateCell class] forCellReuseIdentifier:endDateID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self notification];
    self.isSelectNull = NO;
    params[@"couponType"] = @"fullVolumeReduction";
    params[@"boRandom"] = @"true";
}

//通知
- (void)notification
{
    //选择性别
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectSex:) name:@"selectSex" object:nil];
    //输入红包金额
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(walletAmount:) name:@"inputWalletAmount" object:nil];
    //选择优惠券
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCoupon:) name:@"selectCoupon" object:nil];
    //设置优惠金额
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(couponAmount:) name:@"couponAmount" object:nil];
}

//选择性别
- (void)selectSex:(NSNotification *)noti
{
    NSDictionary *sexDic = noti.userInfo;
    params[@"genderType"] = sexDic[@"genderType"];
    params[@"text"] = sexDic[@"text"];
}

//输入红包金额
- (void)walletAmount:(NSNotification *)noti
{
    NSDictionary *walletDic = noti.userInfo;
    wallet = walletDic[@"luckyDrawAmount"];
    params[@"boRandom"] = walletDic[@"boRandom"];
    //合计金额
    self.footerView.totalAmount = wallet;
    NSIndexPath *index = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationTop];
    
}

//选择优惠券
- (void)selectCoupon:(NSNotification *)noti
{
    
    NSDictionary *couponDic = noti.userInfo;
    params[@"couponType"] = couponDic[@"couponType"];
    if ([couponDic[@"isSelectNull"] isEqualToString:@"NoFirst"] &&[couponDic[@"couponType"] isEqualToString:@"fullVolumeReduction"]) {
        _isSelectNull = NO;
        tag = 1;
        
    }else if ([couponDic[@"couponType"] isEqualToString:@"other"]) {
        tag = 2;
        _isSelectNull = NO;
    }else{
        tag = 3;
        _isSelectNull = YES;
    }
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
}

//设置优惠金额
- (void)couponAmount:(NSNotification *)noti
{
    NSDictionary *amountDic = noti.userInfo;
    lastMoney = amountDic[@"couponMinAmount"];
    couponMoney = amountDic[@"couponAmount"];
    
}

#pragma mark - loadData
- (void)loadData
{
    
    CLSHMassInfoSelectPayWayVC *selectPayVC  =[[CLSHMassInfoSelectPayWayVC alloc] init];
    selectPayVC.payTotalMoney = self.footerView.totalAmount;
    selectPayVC.needsParams = params;
    [self.navigationController pushViewController:selectPayVC animated:YES];
}


-(BOOL)isValidateSuccess{
    
    setupInfoModel = [[CLSHSetupInfoModel alloc] init];
    params[@"images"] = self.needParams[@"iamges"];
    params[@"title"] = self.needParams[@"title"];
    params[@"endDate"] = self.needParams[@"endDate"];
    params[@"content"] = self.needParams[@"content"];
    params[@"value"] = self.userParams[@"values"];
    params[@"distance"] = self.userParams[@"distance"];
    params[@"selectedType"] = self.userParams[@"type"];
    params[@"luckyDrawAmount"] = wallet;
    params[@"couponMinAmount"] = lastMoney;
    params[@"couponAmount"] = couponMoney;
    
    if (!self.isSelectNull) {
        
        if ([params[@"luckyDrawAmount"] length] == 0) {
            [MBProgressHUD showError:@"请输入红包总金额"];
            return NO;
        }else if ([params[@"couponMinAmount"] length] == 0) {
            
            [MBProgressHUD showError:@"请输入最低消费"];
            return NO;
        }else if([params[@"couponAmount"] length] == 0 ) {
            [MBProgressHUD showError:@"请输入优惠金额"];
            return NO;
        }else if (showDatePickerTime.length==0){
            [MBProgressHUD showError:@"请选择截止日期"];
            return NO;
        }
    }else
    {
        if ([params[@"luckyDrawAmount"] length] == 0) {
            [MBProgressHUD showError:@"请输入红包总金额"];
            return NO;
        }else
        {
            [params removeObjectsForKeys:@[@"couponType",@"couponTime", @"couponMinAmount", @"couponAmount"]];
            return YES;
        }
        
    }
    return YES;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 4;
    }else
    {
        if (self.isSelectNull) {
            return 2;
        }else
        {
            return 4;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CLSHMassInfoPersonCountCell *personCountCell = [tableView dequeueReusableCellWithIdentifier:personCountID];
    CLSHMassInfoSelectSexCell *selectSexCell = [tableView dequeueReusableCellWithIdentifier:selectSexID];
    CLSHMassInfoWalletCell *walletCell = [tableView dequeueReusableCellWithIdentifier:walletID];
    CLSHMassInfoCouponCell *couponCell = [tableView dequeueReusableCellWithIdentifier:couponID];
    CLSHMassInfoMininumConsumpCell *consumpCell = [tableView dequeueReusableCellWithIdentifier:consumpID];
    CLSHMassInfoEndDateCell *endDateCell = [tableView dequeueReusableCellWithIdentifier:endDateID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!personCountCell) {
        personCountCell = [[CLSHMassInfoPersonCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personCountID];
    }
    if (!selectSexCell) {
        selectSexCell = [[CLSHMassInfoSelectSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectSexID];
    }
    if (!walletCell) {
        walletCell = [[CLSHMassInfoWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletID];
    }
    if (!couponCell) {
        couponCell = [[CLSHMassInfoCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:couponID];
    }
 
    if (!consumpCell) {
        consumpCell = [[CLSHMassInfoMininumConsumpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:consumpID];
    }
    if (!endDateCell) {
        endDateCell = [[CLSHMassInfoEndDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:endDateID];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.font = [UIFont systemFontOfSize:10*AppScale];
    cell.backgroundColor = backGroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    endDateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    consumpCell.selectionStyle = UITableViewCellSelectionStyleNone;
    couponCell.selectionStyle = UITableViewCellSelectionStyleNone;
    walletCell.selectionStyle = UITableViewCellSelectionStyleNone;
    selectSexCell.selectionStyle = UITableViewCellSelectionStyleNone;
    personCountCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            personCountCell.selectUsersModel = self.selectUsersModel;
            return personCountCell;
        }else if (indexPath.row == 1)
        {
            return selectSexCell;
        }else if(indexPath.row == 2)
        {
            walletCell.count = wallet;
            return walletCell;
        }else
        {
            if ([params[@"boRandom"] isEqualToString:@"else"]) {
                if (!([params[@"luckyDrawAmount"] length] == 0) && [params[@"luckyDrawAmount"] floatValue]/self.selectUsersModel.totalCount < 0.01 ) {
                    
                    cell.textLabel.text = @"*用户可领取的单个红包面值不得低于0.01元";
                }else
                {
                    cell.textLabel.text = @"*用户可领取的单个红包面值系统平均分配";
                }
            }else
            {
                if (!([params[@"luckyDrawAmount"] length] == 0) && [params[@"luckyDrawAmount"] floatValue] < 0.01) {
                    cell.textLabel.text = @"*用户可领取的单个红包面值不得低于0.01元";
                }else
                {
                    cell.textLabel.text = @"*用户可领取的单个红包面值系统随机分配";
                }
            }
            return cell;
        }
    }else
    {
        if (self.isSelectNull) {
            if (indexPath.row == 0) {
                if (tag == 2) {
                    couponCell.fullCutCoupons.selected = NO;
                    couponCell.rebate.selected = YES;
                    couponCell.noCoupon.selected = NO;
                    
                }else if (tag == 3)
                {
                    couponCell.fullCutCoupons.selected = NO;
                    couponCell.rebate.selected = NO;
                    couponCell.noCoupon.selected = YES;
                    
                }else
                {
                    couponCell.fullCutCoupons.selected = YES;
                    couponCell.rebate.selected = NO;
                    couponCell.noCoupon.selected = NO;
                }
                return couponCell;
            }else{
                
                cell.textLabel.text = @"*红包十天内无人领取，系统将会自动返回余额账户";
                
                return cell;
            }
        }else
        {
            if (indexPath.row == 0) {
                if (tag == 2) {
                    couponCell.fullCutCoupons.selected = NO;
                    couponCell.rebate.selected = YES;
                    couponCell.noCoupon.selected = NO;
                    
                }else if (tag == 3)
                {
                    couponCell.fullCutCoupons.selected = NO;
                    couponCell.rebate.selected = NO;
                    couponCell.noCoupon.selected = YES;
                    
                }else
                {
                    couponCell.fullCutCoupons.selected = YES;
                    couponCell.rebate.selected = NO;
                    couponCell.noCoupon.selected = NO;
                }
                return couponCell;
            }else if (indexPath.row == 1)
            {
                consumpCell.min = lastMoney;
                consumpCell.coupon = couponMoney;
                return consumpCell;
            }else if(indexPath.row == 2)
            {
                endDateCell.delegate = self;
                endDateCell.showDatePickerTime = showDatePickerTime;
                
                return endDateCell;
            }else
            {
                cell.textLabel.text = @"*红包十天内无人领取，系统将会自动返回余额账户";
                
                return cell;
            }
        }
       
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 162*AppScale;
        }else if (indexPath.row == 3)
        {
            return 40*AppScale;
        }else
        {
            return 50*AppScale;
        }
    }else
    {
        if (self.isSelectNull) {
            if (indexPath.row == 0) {
                return 50*AppScale;
            }else
            {
                return 40*AppScale;
            }
        }else
        {
            if (indexPath.row == 3) {
                return 40*AppScale;
            }else
            {
                return 50*AppScale;
            }
        }
        
    }
    return 0;
}

#pragma mark <CLSHMassInfoEndDateCellDelegate>
-(void)datePicker{
    [self.view endEditing:YES];
    KBDatePicker *datePicker=[KBDatePicker new];
    datePicker.currentDate=[NSDate date];
    datePicker.delegate=self;
    datePicker.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [datePicker showDatePicker];
}

#pragma mark <KBDatePickerDelegate>
-(void)showDataPicker:(NSString *)string timeString:(NSString *)timeString{
    params[@"couponTime"]=timeString;
    showDatePickerTime=string;
    if (!self.isSelectNull) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
   
}

#pragma mark - setter getter
-(void)setSelectUsersModel:(CLSHAddAdSelectUsersModel *)selectUsersModel
{
    _selectUsersModel = selectUsersModel;
}

-(void)setNeedParams:(NSDictionary *)needParams
{
    _needParams = needParams;
}

-(void)setUserParams:(NSDictionary *)userParams
{
    _userParams = userParams;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
