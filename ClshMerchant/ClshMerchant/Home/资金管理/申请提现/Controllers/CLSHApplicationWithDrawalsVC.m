//
//  CLSHApplicationWithDrawalsVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHApplicationWithDrawalsVC.h"
#import "CLSHWithdrawalsAccountCell.h"
#import "CLSHWithdrawalsBankCell.h"
#import "CLSHArriveAccountTimeCell.h"
#import "CLGSApplicationFooterView.h"
#import "CLSHInputCheckCodeVC.h"
#import "CLSHApplicationWithdrawModel.h"
#import "CLSHAccountCardBankModel.h"
#import "CLSHAddBankCartVC.h"
#import "CLSHMyBankCartVC.h"
#import "CLSHWithdrawalsRecordVC.h"

@interface CLSHApplicationWithDrawalsVC ()
{
    CLGSApplicationFooterView *footerView;      ///<尾部视图
    CLSHApplicationWithdrawModel *applicationWithdrawModel;    ///<申请提现数据模型
    CLSHAccountCardBankModel *cartBankModel;    ///<银行卡列表
    
    NSString *bankCardID;       ///<银行卡ID
    NSString *bankCategory;     ///<银行卡名称
    NSString *bankCartNum;      ///<银行卡卡号
    NSString *bankCartImg;      ///<银行卡图标
    NSString *money;            ///<提现金额
    
}

@end

@implementation CLSHApplicationWithDrawalsVC

static NSString *const ID = @"cell";
static NSString *const withdrawalsID = @"withdrawalsAccountCell";
static NSString *const bankID = @"withdrawalsBankCell";
static NSString *const arriveTimeID = @"CLSHArriveAccountTimeCell";

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = backGroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationItem setTitle:@"申请提现"];
    applicationWithdrawModel = [[CLSHApplicationWithdrawModel alloc] init];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHWithdrawalsAccountCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:withdrawalsID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHWithdrawalsBankCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bankID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHArriveAccountTimeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:arriveTimeID];
    
    //加载脚部视图
    footerView=[[[NSBundle mainBundle]loadNibNamed:@"CLGSApplicationFooter" owner:self options:nil]lastObject];
    
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150*AppScale)];
    footerView.frame=CGRectMake(0, 0, SCREENWIDTH, 150*AppScale);
    //block
    WS(weakSelf);
    footerView.withdrawalsBlock=^(){
        [weakSelf push];
    };
    
    footerView.recordApplyDrawalsblock = ^(){
    
        CLSHWithdrawalsRecordVC *recordVC = [[CLSHWithdrawalsRecordVC alloc] init];
        [weakSelf.navigationController pushViewController:recordVC animated:YES];
    };
    self.tableView.tableFooterView = footerView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMoney:) name:@"CLGSGetMoney" object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bankCart:) name:@"bankCartID" object:nil];
    [self loadData];
}

//选择的银行卡号
- (void)bankCart:(NSNotification *)noti
{
    NSDictionary *params = noti.userInfo;
    bankCardID = params[@"bankCartID"];
    bankCategory = params[@"bankCategory"];
    bankCartImg = params[@"bankAccountImg"];
    bankCartNum = params[@"bankAccountNumber"];
}

//提现金额
-(void)getMoney:(NSNotification *)notification{
    
    NSDictionary *params = notification.userInfo;
    money = params[@"money"];
}

#pragma mark <loadData>
- (void)loadData
{
    cartBankModel = [[CLSHAccountCardBankModel alloc] init];
    [cartBankModel fetchAccountCardBankModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            cartBankModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHWithdrawalsAccountCell *withdrawalsCell = [tableView dequeueReusableCellWithIdentifier:withdrawalsID];
    
    CLSHWithdrawalsBankCell *bankCell = [tableView dequeueReusableCellWithIdentifier:bankID];
   
    CLSHArriveAccountTimeCell *arriveTimeCell = [tableView dequeueReusableCellWithIdentifier:arriveTimeID];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (!withdrawalsCell) {
        withdrawalsCell = [[CLSHWithdrawalsAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:withdrawalsID];
    }
    if (!bankCell) {
        bankCell = [[CLSHWithdrawalsBankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bankID];
    }
    if (!arriveTimeCell) {
        arriveTimeCell = [[CLSHArriveAccountTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arriveTimeID];
    }
    withdrawalsCell.selectionStyle = UITableViewCellSelectionStyleNone;
    bankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    arriveTimeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (bankCardID == nil) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"选择银行卡";
            cell.textLabel.textColor = RGBColor(50, 50, 50);
            cell.textLabel.font = [UIFont systemFontOfSize:13*AppScale];
            return cell;
        }else
        {
            bankCell.bankName.text = bankCategory;
            [bankCell.bankCartIcon sd_setImageWithURL:[NSURL URLWithString:bankCartImg] placeholderImage:nil];
            bankCell.bankCartTailNumber.text = [NSString stringWithFormat:@"尾号（%@）", [bankCartNum substringFromIndex:bankCartNum.length - 4]];

            return bankCell;
        }
        
    }else if (indexPath.section == 1)
    {
        return arriveTimeCell;
    }
    else if (indexPath.section == 2)
    {
        cell.backgroundColor = backGroundColor;
        NSString *moneyLab = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:self.balance]];
        cell.textLabel.text = [NSString stringWithFormat:@"可提出金额%@", moneyLab];
        
        cell.textLabel.textColor = RGBColor(153, 153, 153);
        cell.textLabel.font = [UIFont systemFontOfSize:12*AppScale];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [NSString labelString:cell.textLabel font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(5, moneyLab.length) color:[UIColor redColor]];
        
        return cell;
    }else if (indexPath.section == 3)
    {
        withdrawalsCell.leftLabel.text = @"提现金额";
        withdrawalsCell.rightTextfield.placeholder = @"请输入提现金额";
        withdrawalsCell.leftLabel.font = [UIFont systemFontOfSize:13*AppScale];
        withdrawalsCell.rightTextfield.font = [UIFont systemFontOfSize:13*AppScale];
        return withdrawalsCell;
    }
    return nil;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 30*AppScale;
    }
    return 50*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 0;
    }
    return 10*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10*AppScale)];
    view.backgroundColor = backGroundColor;
    return view;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (!cartBankModel.bankAccountList.count)
        {
            CLSHAddBankCartVC *addbankCartVC = [[CLSHAddBankCartVC alloc] init];
            [self.navigationController pushViewController:addbankCartVC animated:YES];
            
        }else
        {
            CLSHMyBankCartVC *bankCartVC = [[CLSHMyBankCartVC alloc] init];
            bankCartVC.name = @"申请提现";
            [self.navigationController pushViewController:bankCartVC animated:YES];
            CLSHWithdrawalsBankCell *cell=(CLSHWithdrawalsBankCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.selected=YES;
            
        }
    }
}

#pragma mark <otherResponse>
//确认提现
- (void)push
{
    if (bankCardID == nil) {
         [MBProgressHUD showError:@"还没有添加银行卡！"];
         return;
    }
    if ([money floatValue] > self.balance ) {
        [MBProgressHUD showError:@"余额不足！"];
        return;
    }else if ([money floatValue] < 50){
    
        [MBProgressHUD showError:@"提现金额不能少于50元"];
        return;
    }
    
    if (money.length != 0) {
        if ([KBRegexp validateMoney:money]) {
    
            CLSHInputCheckCodeVC *inputCheckCodeVC = [[CLSHInputCheckCodeVC alloc] init];
            inputCheckCodeVC.name = @"申请提现";
            inputCheckCodeVC.money = money;
            inputCheckCodeVC.bankAcountID = bankCardID;
            inputCheckCodeVC.notHomePage = self.notHomePage;
            [self.navigationController pushViewController:inputCheckCodeVC animated:YES];
            
        }else{
            [MBProgressHUD showError:@"请输入提现的金额!"];
        }
    }
}
//移除观察者
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setter getter

- (void)setBalance:(CGFloat)balance{

      _balance = balance;
}

- (void)setNotHomePage:(BOOL)notHomePage{

    _notHomePage = notHomePage;
}
@end
