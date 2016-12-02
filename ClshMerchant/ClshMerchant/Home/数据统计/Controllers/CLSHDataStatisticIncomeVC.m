//
//  CLSHDataStatisticIncomeVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHDataStatisticIncomeVC.h"
#import "CLSHDataStatisticHeadView.h"
#import "CLSHDataWalletCell.h"
#import "CLSHDataSalesCell.h"
#import "CLSHDataStaticModel.h"

@interface CLSHDataStatisticIncomeVC ()<UITableViewDelegate, UITableViewDataSource>{

    CLSHIncomeStaticDataModel * incomModel;//收入model
    CLSHLuckyDrawStaticDataModel *luckyDrawModel;//红包model
    CLSHConpousStaticDataModel * conpousModel;//优惠券model
    CLSHSalesStaticDataModel * salesModel;//销量model
    MBProgressHUD *hud;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)CLSHDataStatisticHeadView *headView;
@property (nonatomic, strong)NSArray *incomeArray;
@property (nonatomic, strong)NSArray *walletArray;
@property (nonatomic, strong)NSArray *couponArray;
@property (nonatomic, strong)NSArray *saleArray;
@end

static NSString *const walletID = @"CLSHDataWalletCell";
static NSString *const saleID = @"CLSHDataSalesCell";
@implementation CLSHDataStatisticIncomeVC
#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 210*AppScale+64, SCREENWIDTH, SCREENHEIGHT-210*AppScale) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(CLSHDataStatisticHeadView *)headView
{
    if (!_headView) {
        _headView = [[CLSHDataStatisticHeadView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 210*AppScale)];
    }
    return _headView;
}

-(NSArray *)incomeArray
{
    if (!_incomeArray) {
        _incomeArray = [NSArray arrayWithObjects:@"今日交易额", @"7天交易额", @"30天交易额", nil];
    }
    return _incomeArray;
}

-(NSArray *)walletArray
{
    if (!_walletArray) {
        _walletArray = [NSArray arrayWithObjects:@"超时退还", @"超时退还金额", @"实际发出总金额", nil];
    }
    return _walletArray;
}

-(NSArray *)couponArray
{
    if (!_couponArray) {
        _couponArray = [NSArray arrayWithObjects:@"成功使用", @"未使用/超时退回", @"抵扣总金额", nil];
    }
    return _couponArray;
}

-(NSArray *)saleArray
{
    if (!_saleArray) {
        _saleArray = [NSArray arrayWithObjects:@"今日订单数", @"7天订单数", @"30天订单数", nil];
    }
    return _saleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:self.name];
    
    //加载数据
    [self loadData];
    //注册cell
    [self.tableView registerClass:[CLSHDataWalletCell class] forCellReuseIdentifier:walletID];
    [self.tableView registerClass:[CLSHDataSalesCell class] forCellReuseIdentifier:saleID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    //判断是哪个界面跳转过来
    if ([self.name isEqualToString:@"收入统计"]) {
        self.headView.backView.backgroundColor = RGBColor(248, 103, 118);
        self.headView.icon.image = [UIImage imageNamed:@"DataBigIncomeIcon"];
        self.headView.total.text = @"累计收入";
        self.headView.total.textColor = RGBColor(252, 191, 196);
        
    }else if ([self.name isEqualToString:@"红包统计"])
    {
        self.headView.backView.backgroundColor = RGBColor(238, 96, 143);
        self.headView.icon.image = [UIImage imageNamed:@"DataBigWalletIcon"];
        self.headView.total.text = @"累计发出";
        self.headView.total.textColor = RGBColor(247, 194, 211);
    }else if ([self.name isEqualToString:@"优惠券统计"])
    {
        self.headView.backView.backgroundColor = RGBColor(154, 161, 255);
        self.headView.icon.image = [UIImage imageNamed:@"DataBigCouponIcon"];
        self.headView.total.text = @"累计发放";
        self.headView.total.textColor = RGBColor(216, 219, 255);
    }else if ([self.name isEqualToString:@"销量统计"])
    {
        self.headView.backView.backgroundColor = RGBColor(255, 142, 93);
        self.headView.icon.image = [UIImage imageNamed:@"DataBigSaleIcon"];
        self.headView.total.text = @"累计交易成功";
        self.headView.total.textColor = RGBColor(255, 214, 198);
    }
    
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color=[UIColor clearColor];
    hud.backgroundColor=backGroundColor;
    hud.activityIndicatorColor=systemColor;
}

- (void)loadData{

    if ([self.name isEqualToString:@"收入统计"]) {
        incomModel = [[CLSHIncomeStaticDataModel alloc] init];
        [incomModel fetchIncomeStaticData:nil callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
            
                incomModel = result;
                [hud hide:YES];
                
                [_tableView reloadData];
            }else{
            
                [MBProgressHUD showError:result];
            }
        }];
    }else if ([self.name isEqualToString:@"红包统计"]){
    
        luckyDrawModel = [[CLSHLuckyDrawStaticDataModel alloc] init];
        [luckyDrawModel fetchLuckyDrawStaticData:nil callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                luckyDrawModel = result;
                [hud hide:YES];
                [_tableView reloadData];
            }else{
            
                [MBProgressHUD showError:result];
            }
        }];
    }else if ([self.name isEqualToString:@"优惠券统计"]){
    
        conpousModel = [[CLSHConpousStaticDataModel alloc] init];
        [conpousModel fetchConpousStaticData:nil callBack:^(BOOL isSuccess, id result) {
           
            if (isSuccess) {
                conpousModel = result;
                [hud hide:YES];
                [_tableView reloadData];
            }else{
            
                [MBProgressHUD showError:result];
            }
        }];
        
    }else if ([self.name isEqualToString:@"销量统计"]){
    
        salesModel = [[CLSHSalesStaticDataModel alloc] init];
        [salesModel fetchSalesStaticData:nil callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                salesModel = result;
                [hud hide:YES];
                [_tableView reloadData];
            }else{
            
                [MBProgressHUD showError:result];
            }
        }];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //RGBColor(0, 149, 68)
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(255, 255, 255) colorWithAlphaComponent:1]];
    [self hideNavBlackLine];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:RGBColor(51, 51, 51),NSFontAttributeName:[UIFont systemFontOfSize:15*AppScale]};
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem normalTitle:@"返回" selectTitle:@"返回" normalColor:systemColor selectColor:systemColor normalImage:@"arrow" selectImage:@"arrow" target:self action:@selector(back) size:CGSizeMake(50*AppScale, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[systemColor colorWithAlphaComponent:1]];
    [self hideNavBlackLine];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15*AppScale]};
    
}

-(void)dealloc{
    [hud hide:YES];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)hideBar{
    
    //给导航条设置一个空的背景图 使其透明化
    [self.navigationController .navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

/**
 *  隐藏黑线
 */
-(void)hideNavBlackLine{
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id object in list) {
            if ([object isKindOfClass:[UIImageView class]]) {
                UIImageView *imageViews=(UIImageView *)object;
                imageViews.hidden=YES;
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHDataWalletCell *dataWalletCell = [tableView dequeueReusableCellWithIdentifier:walletID];
    CLSHDataSalesCell *saleCell = [tableView dequeueReusableCellWithIdentifier:saleID];
    if (!saleCell) {
        saleCell = [[CLSHDataSalesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:saleID];
    }
    if (!dataWalletCell) {
        dataWalletCell = [[CLSHDataWalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:walletID];
    }
    saleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    dataWalletCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.name isEqualToString:@"销量统计"]) {
        saleCell.name.text = self.saleArray[indexPath.row];
        _headView.count.text = [NSString stringWithFormat:@"%ld单",salesModel.total];
        [NSString labelString:_headView.count font:[UIFont systemFontOfSize:30*AppScale] range:NSMakeRange(0, _headView.count.text.length-1) color:[UIColor whiteColor]];
        switch (indexPath.row) {
            case 0:
                saleCell.count.text = [NSString stringWithFormat:@"%ld单",salesModel.today];
                break;
            case 1:
                saleCell.count.text = [NSString stringWithFormat:@"%ld单",salesModel.sevenDays];
                break;
            case 2:
                saleCell.count.text = [NSString stringWithFormat:@"%ld单",salesModel.thirtyDays];
                break;
            default:
                break;
        }

        [NSString labelString:saleCell.count font:[UIFont systemFontOfSize:18*AppScale] range:NSMakeRange(0, saleCell.count.text.length-1) color:[UIColor redColor]];
        return saleCell;
    }else
    {
        if ([self.name isEqualToString:@"收入统计"]) {
            dataWalletCell.name.text = self.incomeArray[indexPath.row];
            _headView.count.text = [NSString stringWithFormat:@"%.2f元",incomModel.total];
            [NSString labelString:_headView.count font:[UIFont systemFontOfSize:30*AppScale] range:NSMakeRange(0, _headView.count.text.length-1) color:[UIColor whiteColor]];
            switch (indexPath.row) {
                case 0:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%.2f元",incomModel.today];
                    break;
                case 1:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%.2f元",incomModel.sevenDays];
                    break;
                case 2:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%.2f元",incomModel.thirtyDays];
                    break;
                default:
                    break;
            }
            [NSString labelString:dataWalletCell.count font:[UIFont systemFontOfSize:18*AppScale] range:NSMakeRange(0, dataWalletCell.count.text.length-1) color:[UIColor redColor]];
        }else if ([self.name isEqualToString:@"红包统计"])
        {
            dataWalletCell.name.text = self.walletArray[indexPath.row];
            _headView.count.text = [NSString stringWithFormat:@"%ld个",luckyDrawModel.total];
            [NSString labelString:_headView.count font:[UIFont systemFontOfSize:30*AppScale] range:NSMakeRange(0, _headView.count.text.length-1) color:[UIColor whiteColor]];
            switch (indexPath.row) {
                case 0:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%ld个",luckyDrawModel.returnCount];
                    break;
                case 1:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%ld元",luckyDrawModel.returnAmount];
                    break;
                case 2:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%ld元",luckyDrawModel.sendAmount];
                default:
                    break;
            }
            [NSString labelString:dataWalletCell.count font:[UIFont systemFontOfSize:18*AppScale] range:NSMakeRange(0, dataWalletCell.count.text.length-1) color:[UIColor redColor]];
        }else if ([self.name isEqualToString:@"优惠券统计"])
        {
            dataWalletCell.name.text = self.couponArray[indexPath.row];
            _headView.count.text = [NSString stringWithFormat:@"%ld张",conpousModel.total];
            [NSString labelString:_headView.count font:[UIFont systemFontOfSize:30*AppScale] range:NSMakeRange(0, _headView.count.text.length-1) color:[UIColor whiteColor]];
            switch (indexPath.row) {
                case 0:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%ld张",conpousModel.used];
                    break;
                case 1:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%ld张",conpousModel.unUsed];
                    break;
                case 2:
                    dataWalletCell.count.text = [NSString stringWithFormat:@"%ld张",conpousModel.deductionAmount];
                    break;
                default:
                    break;
            }
            [NSString labelString:dataWalletCell.count font:[UIFont systemFontOfSize:18*AppScale] range:NSMakeRange(0, dataWalletCell.count.text.length-1) color:[UIColor redColor]];
        }
        
        return dataWalletCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.name isEqualToString:@"销量统计"]) {
        return 75*AppScale;
    }
    return 60*AppScale;
}

#pragma mark - setter getter
-(void)setName:(NSString *)name
{
    _name = name;
}

@end
