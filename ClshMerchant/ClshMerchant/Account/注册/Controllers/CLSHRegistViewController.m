//
//  CLSHRegistViewController.m
//  ClshMerchant
//
//  Created by arom on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHRegistViewController.h"
#import "CLSHRegistView.h"
#import "KBRegexp.h"
#import "CLSHRegistModel.h"
//@2
#import "WebViewController.h"

@interface CLSHRegistViewController ()<RegistButtonClickedDelegate>

@property (nonatomic,strong)CLSHRegistView * registView;
@property (nonatomic,strong)CLSHRegistModel * model;

@end

@implementation CLSHRegistViewController

#pragma mark --懒加载
- (CLSHRegistView *)registView{
    
    if (!_registView) {
        _registView = [[CLSHRegistView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _registView.delegate = self;
    }
    return _registView;
}
- (CLSHRegistModel *)model{

    if (!_model) {
        _model = [[CLSHRegistModel alloc] init];
    }
    return _model;
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
    
    [self.view addSubview:self.registView];
    
    WS(weakSelf);
    _registView.dismissblock = ^(){
    
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    _registView.verificationblock = ^(){
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"mobile"] = weakSelf.registView.accountTextField.text;
        NSLog(@"获取语音验证码");
        [weakSelf .model postAppPhoneVoiceData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"语音验证码已发送，请您留意..."];
            }else{
                [MBProgressHUD showError:@"语音验证获取失败"];
            }
        }];
//        [weakSelf.model postAppPhoneData:weakSelf.registView.accountTextField.text callBack:^(BOOL isSuccess, id  _Nonnull result) {
//            if (isSuccess) {
//                
//            }else{
//            
//            }
//        }];
    };
    _registView.goDelegateVCblock = ^(){
    
        //@2
       
        WebViewController *web = [[WebViewController alloc] init];
        [weakSelf presentViewController:web animated:YES completion:nil];
        
    };
    
}

#pragma mark Regist View delegate
- (void)regist{

    if ([self ValidateIsSuccess]) {
        NSLog(@"注册");
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"username"] = self.registView.accountTextField.text;
        params[@"enPassword"] = [KBRSA encryptString:self.registView.passwordTextField.text publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
        params[@"mobile"] = self.registView.accountTextField.text;
        params[@"smsToken"] = self.registView.verificatioCode.text;
//        params[@"email"] = @"0000@clgs.com";
        
        
        [self.model postAppRegisterData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
           
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"注册成功"];
                
                NSDictionary * dict = @{@"username":self.registView.accountTextField.text,@"enPassword":self.registView.passwordTextField.text};
                if (self.loginblock) {
                    self.loginblock(dict);
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1.0*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
                
            }else{
            
                [MBProgressHUD showError:result];
            }
        }];
    }
    
}
//表单验证
- (BOOL)ValidateIsSuccess{
    
    if(![KBRegexp checkPhoneNumInput:self.registView.accountTextField.text]){
        [MBProgressHUD showError:@"号码输入有误!"];
        return NO;
    }else if(self.registView.passwordTextField.text.length <5){
        [MBProgressHUD showError:@"您的密码太短或为空!"];
        return NO;
    }else if(![self.registView.passwordTextField.text isEqualToString:self.registView.SurePasswordTextField.text]){
        [MBProgressHUD showError:@"两次密码输入不一样!"];
        return NO;
    }else if([self.registView.verificatioCode.text isEqualToString:@""]){
        
        [MBProgressHUD showError:@"验证码不能为空!"];
        return NO;
    }else if(self.registView.accountTextField.text.length == 11){
        
        return YES;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
