//
//  CLSMerchantJoinSuccessVC.m
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


#import "CLSMerchantJoinSuccessVC.h"
#import "CLSHMerchantJoinProcessVC.h"
#import "CLSHHomeVC.h"
#import "AppDelegate.h"
#import "CLSHTabBarVC.h"
#import "CLSHJoinProgressVC.h"
#import "CLSHCertificationVC.h"

@interface CLSMerchantJoinSuccessVC ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *smallTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *smallHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *payHeight;


@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UILabel *smallDescribe;
@property (strong, nonatomic) IBOutlet UIButton *pay;
@property (strong, nonatomic) IBOutlet UIImageView *stateIcon;

@end

@implementation CLSMerchantJoinSuccessVC

- (void)modify
{
    self.backViewHeight.constant = 280*AppScale;
    self.describeTop.constant = 10*AppScale;
    self.describeHeight.constant = 21*AppScale;
    self.smallHeight.constant = 21*AppScale;
    self.smallTop.constant = 5*AppScale;
    self.payTop.constant = 30*AppScale;
    self.iconWidth.constant = 40*AppScale;
    self.iconHeight.constant = 40*AppScale;
    self.payWidth.constant = 120*AppScale;
    self.payHeight.constant = 40*AppScale;
    self.describe.font = [UIFont systemFontOfSize:15*AppScale];
    self.smallDescribe.font = [UIFont systemFontOfSize:10*AppScale];
    self.pay.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.pay.layer.cornerRadius = 5*AppScale;
    self.pay.layer.masksToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_isSucess) {
        [self.navigationItem setTitle:@"入驻成功"];
        //进入管理中心
        self.describe.text = @"恭喜您！审核已通过，成功入驻！";
        self.smallDescribe.hidden = NO;
        self.smallDescribe.text = @"感谢您的大力支持，嗅虎商城将竭诚为您服务！";
        self.stateIcon.image = [UIImage imageNamed:@"MerchantJoinSuccess"];
        [self.pay setTitle:@"进入商家平台" forState:UIControlStateNormal];
    
        
    }else{
        [self.navigationItem setTitle:@"入驻失败"];
        //入驻失败跳转重新入驻
        
        self.describe.text = @"对不起，您的入驻申请未通过审核！";
        self.smallDescribe.hidden = NO;
        self.smallDescribe.text = @"您提交的信息不符合条件，入驻失败！";
        self.stateIcon.image = [UIImage imageNamed:@"NoPassAudit"];
        [self.pay setTitle:@"重新申请" forState:UIControlStateNormal];
        
    }
    
    if (_nonCertification) {
        self.navigationItem.title = @"申请实名认证";
        
        self.describe.text = @"您还没有进行实名认证!";
        self.smallDescribe.hidden = NO;
        self.smallDescribe.text = @"请进行实名认证";
        self.stateIcon.image = [UIImage imageNamed:@"NoPassAudit"];
        [self.pay setTitle:@"申请实名认证" forState:(UIControlStateNormal)];
    }
    if (_isFailCertification) {
        self.navigationItem.title = @"实名认证失败";
        
        self.describe.text = @"对不起，您的实名认证未通过审核！";
        self.smallDescribe.hidden = NO;
        self.smallDescribe.text = @"您提交的信息不符合条件,实名认证失败!";
        self.stateIcon.image = [UIImage imageNamed:@"NoPassAudit"];
        
        [self.pay setTitle:@"重新实名认证" forState:(UIControlStateNormal)];
    }
    
    if (_isFailCerAndJoin) {
        self.navigationItem.title = @"实名认证、入驻失败";
        
        self.describe.text = @"对不起，您的实名认证和入驻信息未通过审核!";
        self.smallDescribe.hidden = NO;
        self.smallDescribe.text =@"您提交的信息不符合条件,实名认证和入驻失败！";
        self.stateIcon.image = [UIImage imageNamed:@"NoPassAudit"];
        [self.pay setTitle:@"重新实名认证" forState:(UIControlStateNormal)];
    }
    
    if (_isFailJoin) {
        self.describe.text = @"您还没有入驻或者入驻审核失败!";
        self.smallDescribe.hidden = NO;
        self.smallDescribe.text = @"请进行入驻申请";
        self.stateIcon.image = [UIImage imageNamed:@"NoPassAudit"];
        [self.pay setTitle:@"去入驻" forState:(UIControlStateNormal)];
    }
    
    
    
    
//    if ([self.name isEqualToString:@"入驻金额支付成功"]) {
//        //进入管理中心
//        self.describe.text = @"恭喜您！入住费用支付成功！";
//        self.smallDescribe.hidden = YES;
//        [self.pay setTitle:@"进入管理中心" forState:UIControlStateNormal];
//    }else
//    {
//        //支付入驻金额
//        self.describe.text = @"恭喜您！审核已通过，成功入驻";
//        self.smallDescribe.hidden = NO;
//        self.smallDescribe.text = @"感谢您的大力支持，嗅虎商城将为竭诚你服务";
//        [self.pay setTitle:@"支付入驻金额" forState:UIControlStateNormal];
//    }
}

//支付入驻金额
- (IBAction)payJoinMoney:(UIButton *)sender {
//    [self.name isEqualToString:@"入驻金额支付成功"]
    if (_isSucess) {
        //进入管理中心
        ShareApp.window.rootViewController = [[CLSHTabBarVC alloc] init];
        return;
    }else
    {
        //重新进入选择行业界面
        CLSHJoinProgressVC * joinProgressVC = [[CLSHJoinProgressVC alloc] init];
        joinProgressVC.shopId = [FetchAppPublicKeyModel shareAppPublicKeyManager].shopid;
        [self.navigationController pushViewController:joinProgressVC animated:YES];
        /*CLSHMerchantJoinProcessVC *joinProcessVC = [[CLSHMerchantJoinProcessVC alloc] init];
        [self.navigationController pushViewController:joinProcessVC animated:YES];*/
        return;
    }
    
    if (_nonCertification) {
        CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
        certificationVC.isFirstCertification = YES;
        [self.navigationController pushViewController:certificationVC animated:YES];
        return;
    }
    
    if (_isFailCertification) {
        CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
        certificationVC.isFaildCertification = YES;
        [self.navigationController pushViewController:certificationVC animated:YES];
        return;
    }
    
    if (_isFailCerAndJoin) {
        CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
        certificationVC.isFaildCerAndFaildJoin = YES;
        certificationVC.shopId = [FetchAppPublicKeyModel shareAppPublicKeyManager].shopid;
        [self.navigationController pushViewController:certificationVC animated:YES];
        return;
    }
    
    if (_isFailJoin) {
        CLSHJoinProgressVC * joinProcessVC = [CLSHJoinProgressVC new];
        joinProcessVC.tempAppendNumber = 300;
        [self.navigationController pushViewController:joinProcessVC animated:YES];
        return;
    }
}

-(void)setName:(NSString *)name
{
    _name = name;
}

-(void)setIsSucess:(BOOL)isSucess{
    _isSucess=isSucess;
}

@end
