//
//  CLSHMoneyManagerViewController.m
//  ClshMerchant
//
//  Created by arom on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMoneyManagerViewController.h"
#import "CLSHApplyWithDrawalsTableViewCell.h"
#import "CLSHManagerMoneyHeadViewCell.h"
#import "CLSHManagerMoneyFooterView.h"
#import "CLSHManagerMoneyTableViewCell.h"
#import "CLSHImmediatelySettleViewController.h"
#import "CLSHMoneyManagerModel.h"
#import "CLSHCertificationVC.h"
#import "CLSHApplicationWithDrawalsVC.h"
#import "CLGSBalancePaymentsViewController.h"

//@2
#import "CLGSBalanceIncomeVC.h"
@interface CLSHMoneyManagerViewController ()<UITableViewDelegate,UITableViewDataSource>{

    CLSHMoneyManagerModel * moneyManagerModel;
}

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation CLSHMoneyManagerViewController

static NSString * const ApplyWithDrawalsID = @"ApplyWithDrawalsID";
static NSString * const managerMoneyHeadViewID = @"managerMoneyHeadViewID";
static NSString * const managerMoineyFooterViewID = @"managerMoineyFooterViewID";
static NSString * const managerMoneyCellID = @"managerMoneyCellID";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
       
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark -- initUI
- (void)initUI{

    self.navigationItem.title = @"资金管理";
    self.view.backgroundColor = backGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerClass:[CLSHApplyWithDrawalsTableViewCell class] forCellReuseIdentifier:ApplyWithDrawalsID];
    [self.tableView registerClass:[CLSHManagerMoneyTableViewCell class] forCellReuseIdentifier:managerMoneyCellID];
    [self.tableView registerClass:[CLSHManagerMoneyHeadViewCell class] forHeaderFooterViewReuseIdentifier:managerMoneyHeadViewID];
    [self.tableView registerClass:[CLSHManagerMoneyFooterView class] forHeaderFooterViewReuseIdentifier:managerMoineyFooterViewID];
    
    [self.view addSubview:self.tableView];
}

#pragma mark -- load data
- (void)loadData{

    moneyManagerModel = [[CLSHMoneyManagerModel alloc] init];
    
    [moneyManagerModel fetchAccountBalanceData:nil callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            moneyManagerModel = result;
            [_tableView reloadData];
        }
    }];
}

#pragma mark -- UItableView delegate datasorce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else{
    
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 180*AppScale;
    }else{
    
        return 90*AppScale;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 10*AppScale;
    }else{
    
        return 40*AppScale;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return 0.01;
    }else{
    
        return 100*AppScale;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        CLSHManagerMoneyHeadViewCell * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:managerMoneyHeadViewID];
        if (!headView) {
            headView = [[CLSHManagerMoneyHeadViewCell alloc] initWithReuseIdentifier:managerMoneyHeadViewID];
        }
        headView.detailIncomeblock = ^(){
        //@2跳到收支明细页面
            CLGSBalanceIncomeVC *IncomeVC = [[CLGSBalanceIncomeVC alloc] init];
            IncomeVC.title = @"收入明细";
            [self.navigationController pushViewController:IncomeVC animated:YES];
            
        };
        return headView;
        
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (section == 1) {
        CLSHManagerMoneyFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:managerMoineyFooterViewID];
        if (!footerView) {
            footerView = [[CLSHManagerMoneyFooterView alloc] initWithReuseIdentifier:managerMoineyFooterViewID];
        }
        footerView.goImmediatelySettleVCblock = ^(){
        
            CLSHImmediatelySettleViewController * immediatelySettleVC = [CLSHImmediatelySettleViewController new];
            [self.navigationController pushViewController:immediatelySettleVC animated:YES];
        };
        return footerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHApplyWithDrawalsTableViewCell * moneyCell =[tableView dequeueReusableCellWithIdentifier:ApplyWithDrawalsID];
    if (!moneyCell) {
        moneyCell = [[CLSHApplyWithDrawalsTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ApplyWithDrawalsID];
    }
    
    CLSHManagerMoneyTableViewCell * rulesCell = [tableView dequeueReusableCellWithIdentifier:managerMoneyCellID];
    if (!rulesCell) {
        rulesCell = [[CLSHManagerMoneyTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:managerMoneyCellID];
    }
    moneyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    rulesCell.selectionStyle = UITableViewCellSelectionStyleNone;
    moneyCell.activeMoneyLabel.text = [NSString stringWithFormat:@"￥%.2lf",moneyManagerModel.balance];
    moneyCell.unActiveMoneyLabel.text = [NSString stringWithFormat:@"提现中金额:￥%.2lf",moneyManagerModel.freezedBlance];
    //申请提现
    moneyCell.applyDrawalsblock = ^(){
        
        NSString * status = [[NSUserDefaults standardUserDefaults] objectForKey:@"certification"];
        if ([status isEqualToString:@"success"]) {
            
            CLSHApplicationWithDrawalsVC *cLSHApplicationWithDrawalsVC=[CLSHApplicationWithDrawalsVC new];
            cLSHApplicationWithDrawalsVC.balance =moneyManagerModel.balance;
            
            [self.navigationController pushViewController:
             cLSHApplicationWithDrawalsVC animated:YES];
        }else{
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您的身份尚未验证，请先实名认证" message: @"是否修改或编辑实名认证" preferredStyle:1];
            UIAlertAction *viewCancle = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *viewSure =  [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
                CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
                [self.navigationController pushViewController:certificationVC animated:YES];
            }];
            
            [alert addAction:viewCancle];
            [alert addAction:viewSure];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    };
    //资金明细
    moneyCell.moneyDetailblock = ^(){
    
        CLGSBalancePaymentsViewController *incomePayment = [[CLGSBalancePaymentsViewController alloc] init];
        incomePayment.title = @"资金明细";
        [self.navigationController pushViewController:incomePayment animated:YES];
    };

    if (indexPath.section == 0) {
        return moneyCell;
    }else{
    
        if (indexPath.row == 0) {
            rulesCell.timeLabel.text = @"01-15天";
            [rulesCell.rewardBtn setBackgroundImage:[UIImage imageNamed:@"reward_green"] forState:(UIControlStateNormal)];
            rulesCell.moneyLabel.text = [NSString stringWithFormat:@"￥%.2lf",moneyManagerModel.one2fifteen];
        }else if(indexPath.row == 1){
        
            rulesCell.timeLabel.text = @"15-30天";
            [rulesCell.rewardBtn setBackgroundImage:[UIImage imageNamed:@"reward_red"] forState:(UIControlStateNormal)];
            rulesCell.moneyLabel.text = [NSString stringWithFormat:@"￥%.2lf",moneyManagerModel.fifteen2thirty];
            rulesCell.moneyLabel.textColor = [UIColor redColor];
        }
        return rulesCell;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
