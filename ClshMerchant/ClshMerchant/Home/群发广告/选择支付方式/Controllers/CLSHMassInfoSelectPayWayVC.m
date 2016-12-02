//
//  CLSHMassInfoSelectPayWayVC.m
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


#import "CLSHMassInfoSelectPayWayVC.h"
#import "CLSHImmediatelyRechargeVC.h"
#import "CLSHInputCheckCodeVC.h"
#import "CLSHAccountBalanceModel.h"

@interface CLSHMassInfoSelectPayWayVC ()
{
    CLSHAccountBalanceModel *balanceModel;  ///<账户余额数据模型
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *totalWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *totalHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *balanceLabelWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rechargeWidt;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rechargeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineLeft;



@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalMoney;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *balance;
@property (strong, nonatomic) IBOutlet UILabel *noEnough;
@property (strong, nonatomic) IBOutlet UILabel *recharge;
@property (strong, nonatomic) IBOutlet UIButton *pay;
@property (strong, nonatomic) IBOutlet UILabel *bottomLine;

@end

@implementation CLSHMassInfoSelectPayWayVC

- (void)modify
{
    //隐藏充值
    self.noEnough.hidden = YES;
    self.recharge.hidden = YES;
    self.bottomLine.hidden = YES;
    
    self.lineRight.constant = 8*AppScale;
    self.topViewTop.constant = 64+20*AppScale;
    self.topViewHeight.constant = 40*AppScale;
    self.totalWidth.constant = 80*AppScale;
    self.totalHeight.constant = 20*AppScale;
    self.bottomViewTop.constant = 10*AppScale;
    self.bottomViewHeight.constant = 50*AppScale;
    self.iconWidth.constant = 30*AppScale;
    self.iconHeight.constant = 30*AppScale;
    self.balanceLabelWidth.constant = 80*AppScale;
    self.backTop.constant = 10*AppScale;
    self.backWidth.constant = 90*AppScale;
    self.backHeight.constant = 15*AppScale;
    self.rechargeWidt.constant = 45*AppScale;
    self.rechargeHeight.constant = 15*AppScale;
    self.payTop.constant = 30*AppScale;
    self.payHeight.constant = 40*AppScale;
    self.lineLeft.constant = 45*AppScale;
    
    self.totalLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.totalMoney.font = [UIFont systemFontOfSize:14*AppScale];
    self.balanceLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.balance.font = [UIFont systemFontOfSize:12*AppScale];
    self.noEnough.font = [UIFont systemFontOfSize:9*AppScale];
    self.recharge.font = [UIFont systemFontOfSize:9*AppScale];
    self.pay.layer.cornerRadius = 5*AppScale;
    self.pay.layer.masksToBounds = YES;
    self.pay.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(immediatelyRecharge)];
//    [self.backView addGestureRecognizer:gesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    [self.navigationItem setTitle:@"选择支付方式"];
    self.view.backgroundColor = backGroundColor;
    balanceModel = [[CLSHAccountBalanceModel alloc] init];
    NSString *money = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[self.payTotalMoney floatValue]]];
    self.totalMoney.text = money;
    [self loadData];
    
    
}

- (void)loadData
{
    [balanceModel fetchAccountBalanceData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            balanceModel = result;
            NSString *str = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[balanceModel.balance floatValue]]];
            self.balance.text = str;
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//支付
- (IBAction)payMoney:(id)sender {
    
    if ([self.payTotalMoney floatValue] > [balanceModel.balance floatValue]) {
        [MBProgressHUD showError:@"余额不足！"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        
        CLSHInputCheckCodeVC *checkCodeVC = [[CLSHInputCheckCodeVC alloc] init];
        checkCodeVC.name = @"群发广告";
        checkCodeVC.needsParams = self.needsParams;
        [self.navigationController pushViewController:checkCodeVC animated:YES];
    }
}


//立即充值
//- (void)immediatelyRecharge
//{
//    CLSHImmediatelyRechargeVC *immediatelyRechargeVC = [[CLSHImmediatelyRechargeVC alloc] init];
//    immediatelyRechargeVC.name = @"群发广告";
//    [self.navigationController pushViewController:immediatelyRechargeVC animated:YES];
//}

#pragma mark - setter getter
-(void)setPayTotalMoney:(NSString *)payTotalMoney
{
    _payTotalMoney = payTotalMoney;
}

@end
