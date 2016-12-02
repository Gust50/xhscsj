//
//  CLSHRemindPasswordVC.m
//  ClshMerchant
//
//  Created by arom on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHRemindPasswordVC.h"
#import "CLSHRemindView.h"
#import "CLSHRemindPasswordModel.h"
#import "KBRegexp.h"

@interface CLSHRemindPasswordVC ()<ResetPasswordDelegate>{

    CLSHRemindPasswordModel * remindPasswordModel;
}

@property (nonatomic,strong)CLSHRemindView * remindView;

@end
@implementation CLSHRemindPasswordVC

#pragma mark --懒加载
- (CLSHRemindView *)remindView{

    if (!_remindView) {
        _remindView = [[CLSHRemindView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _remindView.delegate = self;
    }
    return _remindView;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.remindView];
    
    remindPasswordModel = [[CLSHRemindPasswordModel alloc] init];
    
    WS(weakSelf);
    weakSelf.remindView.verificationblock = ^(){
        NSLog(@"验证码");
        [remindPasswordModel postAppPhoneData:self.remindView.accountTextField.text callBack:^(BOOL isSuccess, id result) {
            [MBProgressHUD showSuccess:@"验证码已发送，请注意查收"];
        }];
    };
    weakSelf.remindView.dismissblock = ^(){
    
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

#pragma mark ResetPassword delegate
- (void)resetPassword{

    NSLog(@"重置");
    if ([self ValidateIsSuccess]) {
        
        NSMutableDictionary * needspramas = [NSMutableDictionary dictionary];
        needspramas[@"phone"] = self.remindView.accountTextField.text;
        needspramas[@"newPassword"] = self.remindView.passwordTextField.text;
        needspramas[@"smsToken"] = self.remindView.verificatioCode.text;
        
        [remindPasswordModel postAppForgetPasswordData:needspramas callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"修改成功!"];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
            
                [MBProgressHUD showError:@"修改失败!"];
            }
            
        }];
    }
}

//表单验证
- (BOOL)ValidateIsSuccess{
    
    if(self.remindView.accountTextField.text == nil || [self.remindView.accountTextField.text isEqualToString:@""] || ![KBRegexp checkPhoneNumInput:self.remindView.accountTextField.text]){
        [MBProgressHUD showError:@"号码输入有误!"];
        return NO;
    }else if(self.remindView.passwordTextField.text.length <5){
        [MBProgressHUD showError:@"您的密码太短或为空!"];
        return NO;
    }else if(![self.remindView.passwordTextField.text isEqualToString:self.remindView.SurePasswordTextField.text]){
        [MBProgressHUD showError:@"两次密码输入不一样!"];
        return NO;
    }else if([self.remindView.verificatioCode.text isEqualToString:@""]){
        
        [MBProgressHUD showError:@"验证码不能为空!"];
        return NO;
    }else{
        
        return YES;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
