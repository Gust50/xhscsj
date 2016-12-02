//
//  CLSHPayMerchantJoinMoneyVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHPayMerchantJoinMoneyVC.h"
#import "CLSHImmediatelyRechargeVC.h"
#import "CLSHInputCheckCodeVC.h"
#import "CLSMerchantJoinSuccessVC.h"

@interface CLSHPayMerchantJoinMoneyVC ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleLineTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomBackViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomBackViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *freeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *freeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *freeCountHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rechartViewTop;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rechartViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rechartViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;


@property (strong, nonatomic) IBOutlet UIView *rechangeView;
@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UILabel *free;
@property (strong, nonatomic) IBOutlet UILabel *freeMonthCount;
@property (strong, nonatomic) IBOutlet UILabel *fee;
@property (strong, nonatomic) IBOutlet UILabel *feeMonthCount;
@property (strong, nonatomic) IBOutlet UIView *freeBackView;
@property (strong, nonatomic) IBOutlet UIView *feeBackView;
@property (strong, nonatomic) IBOutlet UILabel *countBalanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *balance;
@property (strong, nonatomic) IBOutlet UILabel *notEnough;
@property (strong, nonatomic) IBOutlet UILabel *recharge;
@property (strong, nonatomic) IBOutlet UIButton *pay;


@end

@implementation CLSHPayMerchantJoinMoneyVC

- (void)modify
{
    self.rechartViewTop.constant = 10*AppScale;
    self.rechartViewWidth.constant = 105*AppScale;
    self.rechartViewHeight.constant = 15*AppScale;
    self.freeTop.constant = 10*AppScale;
    self.freeHeight.constant = 25*AppScale;
    self.freeCountHeight.constant = 15*AppScale;
    self.backViewTop.constant = 64+20*AppScale;
    self.backViewHeight.constant = 120*AppScale;
    self.middleLineTop.constant = 39*AppScale;
    self.bottomBackViewTop.constant = 10*AppScale;
    self.bottomBackViewHeight.constant = 50*AppScale;
    self.payTop.constant = 30*AppScale;
    self.payHeight.constant = 40*AppScale;
    self.lineWidth.constant = 45*AppScale;
    self.lineRight.constant = 10*AppScale;
    self.iconWidth.constant = 20*AppScale;
    self.iconHeight.constant = 20*AppScale;
    
    self.describe.font = [UIFont systemFontOfSize:13*AppScale];
    self.free.font = [UIFont systemFontOfSize:16*AppScale];
    self.freeMonthCount.font = [UIFont systemFontOfSize:11*AppScale];
    self.fee.font = [UIFont systemFontOfSize:16*AppScale];
    self.feeMonthCount.font = [UIFont systemFontOfSize:11*AppScale];
    self.feeBackView.layer.cornerRadius = 10*AppScale;
    self.feeBackView.layer.masksToBounds = YES;
    self.feeBackView.layer.borderWidth = 1;
    self.feeBackView.layer.borderColor = systemColor.CGColor;
    self.freeBackView.layer.cornerRadius = 10*AppScale;
    self.freeBackView.layer.masksToBounds = YES;
    self.freeBackView.backgroundColor = systemColor;
    self.freeMonthCount.textColor = [UIColor whiteColor];
    self.free.textColor = [UIColor whiteColor];
    self.countBalanceLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.balance.font = [UIFont systemFontOfSize:13*AppScale];
    self.notEnough.font = [UIFont systemFontOfSize:10*AppScale];
    self.recharge.font = [UIFont systemFontOfSize:10*AppScale];
    self.pay.layer.cornerRadius = 5*AppScale;
    self.pay.layer.masksToBounds = YES;
    self.pay.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(immediatelyRecharge)];
    [self.rechangeView addGestureRecognizer:gesture];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"入驻金额支付"];
}

//选择入驻金额
- (IBAction)selectMerchantJoinMoney:(UIButton *)sender {
    
    if (sender.tag == 1) {
        //试用三个月
        self.feeBackView.layer.cornerRadius = 10*AppScale;
        self.feeBackView.layer.masksToBounds = YES;
        self.feeBackView.layer.borderWidth = 1;
        self.feeBackView.layer.borderColor = systemColor.CGColor;
        self.feeBackView.backgroundColor = [UIColor whiteColor];
        self.freeBackView.layer.cornerRadius = 10*AppScale;
        self.freeBackView.layer.masksToBounds = YES;
        self.freeBackView.backgroundColor = systemColor;
        self.freeMonthCount.textColor = [UIColor whiteColor];
        self.free.textColor = [UIColor whiteColor];
        self.feeMonthCount.textColor = systemColor;
        self.fee.textColor = systemColor;
        
    }else
    {
        //使用一年
        self.freeBackView.layer.cornerRadius = 10*AppScale;
        self.freeBackView.layer.masksToBounds = YES;
        self.freeBackView.layer.borderWidth = 1;
        self.freeBackView.layer.borderColor = systemColor.CGColor;
        self.freeBackView.backgroundColor = [UIColor whiteColor];
        self.feeBackView.layer.cornerRadius = 10*AppScale;
        self.feeBackView.layer.masksToBounds = YES;
        self.feeBackView.backgroundColor = systemColor;
        self.feeMonthCount.textColor = [UIColor whiteColor];
        self.fee.textColor = [UIColor whiteColor];
        self.freeMonthCount.textColor = systemColor;
        self.free.textColor = systemColor;
    }
}

//立即充值
- (void)immediatelyRecharge
{
    CLSHImmediatelyRechargeVC *immediatelyRechargeVC = [[CLSHImmediatelyRechargeVC alloc] init];
    [self.navigationController pushViewController:immediatelyRechargeVC animated:YES];
}

//支付
- (IBAction)payMerchantJoinMoney:(UIButton *)sender {
    CLSMerchantJoinSuccessVC *merchantJoinSuccessVC = [[CLSMerchantJoinSuccessVC alloc] init];
    merchantJoinSuccessVC.name = @"入驻金额支付成功";
    [self.navigationController pushViewController:merchantJoinSuccessVC animated:YES];}


@end
