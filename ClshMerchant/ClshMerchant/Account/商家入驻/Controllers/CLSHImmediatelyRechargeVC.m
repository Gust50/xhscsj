//
//  CLSHImmediatelyRechargeVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHImmediatelyRechargeVC.h"
#import "CLSHInputCheckCodeVC.h"

@interface CLSHImmediatelyRechargeVC ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oneLineTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *twoLineTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payImageTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payLabelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *wechatTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payIconTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payIconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payIconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *wehcatIconTop;



@property (strong, nonatomic) IBOutlet UITextField *inputMoney;
@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UILabel *payLabel;
@property (strong, nonatomic) IBOutlet UILabel *payDescribe;
@property (strong, nonatomic) IBOutlet UILabel *wechatLabel;
@property (strong, nonatomic) IBOutlet UILabel *wechatDescribe;
@property (strong, nonatomic) IBOutlet UIButton *confirmRecharge;
@property (strong, nonatomic) IBOutlet UIButton *payIcon;
@property (strong, nonatomic) IBOutlet UIButton *wechatIcon;

@end

@implementation CLSHImmediatelyRechargeVC

- (void)modify
{
    self.topViewTop.constant = 64+15*AppScale;self.topViewHeight.constant = 40*AppScale;
    self.bottomViewTop.constant = 10*AppScale;
    self.bottomViewHeight.constant = 200*AppScale;
    self.oneLineTop.constant = 39*AppScale;
    self.twoLineTop.constant = 79*AppScale;
    self.confirmTop.constant = 40*AppScale;
    self.confirmHeight.constant = 40*AppScale;
    self.payImageTop.constant = 20*AppScale;
    self.payWidth.constant = 40*AppScale;
    self.payHeight.constant = 40*AppScale;
    self.payLabelHeight.constant = 20*AppScale;
    self.wechatTop.constant = 20*AppScale;
    self.payIconTop.constant = 30*AppScale;
    self.payIconWidth.constant = 20*AppScale;
    self.payIconHeight.constant = 20*AppScale;
    self.wehcatIconTop.constant = 30*AppScale;
    self.inputMoney.font = [UIFont systemFontOfSize:13*AppScale];
    self.describe.font = [UIFont systemFontOfSize:13*AppScale];
    self.payLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.payDescribe.font = [UIFont systemFontOfSize:11*AppScale];
    self.wechatLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.wechatDescribe.font = [UIFont systemFontOfSize:11*AppScale];
    self.confirmRecharge.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.confirmRecharge.layer.cornerRadius = 5*AppScale;
    self.confirmRecharge.layer.masksToBounds = YES;
    self.inputMoney.borderStyle = UITextBorderStyleNone;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"充值"];
}

//选择支付类型
- (IBAction)selectPayStyle:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [self.payIcon setImage:[UIImage imageNamed:@"Recharge_select"] forState:UIControlStateNormal];
        [self.wechatIcon setImage:[UIImage imageNamed:@"Recharge_normal"] forState:UIControlStateNormal];
    }else
    {
        [self.wechatIcon setImage:[UIImage imageNamed:@"Recharge_select"] forState:UIControlStateNormal];
        [self.payIcon setImage:[UIImage imageNamed:@"Recharge_normal"] forState:UIControlStateNormal];
    }
}



//确认充值
- (IBAction)confirm:(UIButton *)sender {
    CLSHInputCheckCodeVC *inputCheckCodeVC = [[CLSHInputCheckCodeVC alloc] init];
    
    if ([self.name isEqualToString:@"群发广告"]) {
        inputCheckCodeVC.name = @"群发广告";
    }else
    {
        inputCheckCodeVC.name = @"商家入驻";
    }
    
    [self.navigationController pushViewController:inputCheckCodeVC animated:YES];
}

-(void)setName:(NSString *)name
{
    _name = name;
}

@end
