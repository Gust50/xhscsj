//
//  CLSHLoginViewController.m
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


#import "CLSHLoginViewController.h"
#import "CLSHLoginView.h"
#import "CLSHRegistViewController.h"
#import "CLSHRemindPasswordVC.h"
#import "KBRegexp.h"
#import "CLSHLoginModel.h"
#import "CLSHTabBarVC.h"
#import "AppDelegate.h"
#import "CLSHMerchantJoinProcessVC.h"
#import "CLSHNavigationVC.h"
#import "CLSHCertificationVC.h"
#import <JPUSHService.h>


#import "CLSHApplicationSubmitSucVC.h"
#import "CLSMerchantJoinSuccessVC.h"

#import "CLSHWriteMerchantJoinInfoVC.h"
#import "CLSHJoinProgressVC.h"

@interface CLSHLoginViewController ()<LoginButtonClickedDelegate>
{
    NSUserDefaults *userDefaults;
}
@property (nonatomic,strong)CLSHLoginView * loginView;   //视图
@end

@implementation CLSHLoginViewController

#pragma mark --懒加载
- (CLSHLoginView *)loginView{

    if (!_loginView) {
        _loginView = [[CLSHLoginView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _loginView.delegate = self;
    }
    return _loginView;
}

#pragma mark --life cycle
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
    [self.view addSubview:self.loginView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    userDefaults=[NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"info"]) {
        
        self.loginView.accountTextField.text = [[userDefaults objectForKey:@"info"] objectForKey:@"username"];
        self.loginView.passwordTextField.text = [[userDefaults objectForKey:@"info"] objectForKey:@"password"];
    }
    
    WS(weakSelf);
    _loginView.regist = ^(){
        //跳转注册界面
        NSLog(@"注册");
        CLSHRegistViewController * registVC = [[CLSHRegistViewController alloc] init];
        [weakSelf presentViewController:registVC animated:YES completion:nil];
    };
    
    _loginView.forget = ^(){
        //跳转忘记密码界面
        CLSHRemindPasswordVC * remindVC = [[CLSHRemindPasswordVC alloc] init];
        [weakSelf presentViewController:remindVC animated:YES completion:nil];
    };
    
    _loginView.dismissblock = ^(){
    
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

#pragma mark logindelegate
- (void)login{
    if ([self validate]) {
        __block CLSHLoginModel * model = [[CLSHLoginModel alloc] init];
        NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
        __block CLSHCertificationModel * certificationModel = [[CLSHCertificationModel alloc] init];
        needParams[@"username"]=self.loginView.accountTextField.text;
        needParams[@"password"]= self.loginView.passwordTextField.text;
        needParams[@"loginRole"]= @"shop";
//        [MBProgressHUD showMessage:@"登录中..." toView:self.view];
        
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.color=[UIColor colorWithWhite:1 alpha:0.6];
        hud.backgroundColor=[UIColor colorWithWhite:1 alpha:0.6];
        hud.activityIndicatorColor=systemColor;
        
        
        [model postAppLoginData:needParams callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                
                [hud hide:YES];
                model = result;
                if (model.isShop) {
                    [userDefaults setObject:needParams forKey:@"info"];
                    [userDefaults setBool:YES forKey:@"isLogined"];
                    [userDefaults synchronize];
                }else{
                
                    needParams[@"password"] = nil;
                    [userDefaults setObject:needParams forKey:@"info"];
                    [userDefaults setBool:NO forKey:@"isLogined"];
                    [userDefaults synchronize];
                }
                
                NSString * userId = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
                [JPUSHService setTags:nil alias:userId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    NSLog(@"-----rescode: %d, \n-----tags: %@, \n-----alias: %@\n", iResCode, iTags, iAlias);
                }];

                certificationModel = model.authentication;
                [[NSUserDefaults standardUserDefaults] setObject:certificationModel.status forKey:@"certification"];
                
                [FetchAppPublicKeyModel shareAppPublicKeyManager].isFlat = model.flat;
                [FetchAppPublicKeyModel shareAppPublicKeyManager].isPinless = model.pinless;
                [FetchAppPublicKeyModel shareAppPublicKeyManager].shopid = certificationModel.shopID;
                
                [self dealLoginLogic:certificationModel withLoginModel:model];
            
//                else{
//
//                     CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHMerchantJoinProcessVC new]];
//                    ShareApp.window.rootViewController = mnavigation;
//                }
//                
//                
//                self.tabBarController.selectedIndex = 0;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }else{
            
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                sleep(1);
                [hud hide:YES];
                [MBProgressHUD showError:result];
                
            }
        }];
    }
}


-(void)dealLoginLogic:(CLSHCertificationModel *)model withLoginModel:(CLSHLoginModel *)LoginModel{
    
    
    if (LoginModel.isShop) {
        
        if ([LoginModel.shopStatus isEqualToString:@"success"] || [LoginModel.shopStatus isEqualToString:@"paid"]) {
            if ([model.status isEqualToString:@"failed"]) {
                //实名审核失败
                CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
                cLSMerchantJoinSuccessVC.isFailCertification = YES;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
                ShareApp.window.rootViewController=mnavigation;
                
            }else if ([model.status isEqualToString:@"reviewing"]){
            
                //跳转正在审核
                CLSHApplicationSubmitSucVC * submitSucVC = [CLSHApplicationSubmitSucVC new];
                submitSucVC.fromLogin = YES;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:submitSucVC];
                ShareApp.window.rootViewController=mnavigation;
                
            }else{
                //跳转首页
                ShareApp.window.rootViewController=[CLSHTabBarVC new];
            }
            
        }else if ([LoginModel.shopStatus isEqualToString:@"reviewing"]){
        
            if (LoginModel.authentication == nil) {
                //没有进行实名认证
                CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
                cLSMerchantJoinSuccessVC.nonCertification = YES;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
                ShareApp.window.rootViewController=mnavigation;
            }else if ([LoginModel.authentication.status isEqualToString:@"failed"]){
            
                //实名认证失败
                CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
                cLSMerchantJoinSuccessVC.isFailCertification = YES;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
                ShareApp.window.rootViewController=mnavigation;
                
            }else{
                
                //没有进行入驻
                CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
                cLSMerchantJoinSuccessVC.isFailJoin = YES;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
                ShareApp.window.rootViewController=mnavigation;

//                //入驻正在审核
//                CLSHApplicationSubmitSucVC * submitSucVC = [CLSHApplicationSubmitSucVC new];
//                submitSucVC.fromLogin = YES;
//                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:submitSucVC];
//                ShareApp.window.rootViewController=mnavigation;
            }
        }else if ([LoginModel.shopStatus isEqualToString:@"failed"]){
    
            if ([model.status isEqualToString:@"failed"]) {
                //提示实名认证 入驻同时失败
                CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
                cLSMerchantJoinSuccessVC.isFailCerAndJoin = YES;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
                ShareApp.window.rootViewController=mnavigation;
            }else if ([model.status isEqualToString:@"reviewing"]){
            
                //实名认证正在审核
                CLSHApplicationSubmitSucVC * submitSucVC = [CLSHApplicationSubmitSucVC new];
                submitSucVC.fromLogin = YES;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:submitSucVC];
                ShareApp.window.rootViewController=mnavigation;
                
            }else{
            
                //入驻
                CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
                cLSMerchantJoinSuccessVC.isFailJoin = YES;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
                ShareApp.window.rootViewController=mnavigation;

                
            }
        }
    }else{
    
        if (LoginModel.authentication == nil) {
            
            //先实名后入驻
            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHMerchantJoinProcessVC new]];
            ShareApp.window.rootViewController = mnavigation;
            return;
            
        }else if ([model.status isEqualToString:@"failed"]){
        
            //实名认证，入驻。
            CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
            cLSMerchantJoinSuccessVC.isFailCerAndJoin = YES;
            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
            ShareApp.window.rootViewController=mnavigation;
            return;
            
        }else{
        
            //跳入驻
            CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
            cLSMerchantJoinSuccessVC.isFailJoin = YES;
            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
            ShareApp.window.rootViewController=mnavigation;
            return;

        }
//        //入驻
//        CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
//        cLSMerchantJoinSuccessVC.isFailJoin = YES;
//        CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
//        ShareApp.window.rootViewController=mnavigation;
    }
    
    
 
//    if (LoginModel.isShop) {
//        
//        if ([model.status isEqualToString:@"reviewing"]) {
//            //等待审核
//            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHApplicationSubmitSucVC new]];
//            ShareApp.window.rootViewController=mnavigation;
//        }else if ([model.status isEqualToString:@"failed"]){
//            //审核失败
//            CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
//            cLSMerchantJoinSuccessVC.isSucess=NO;
//            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
//            ShareApp.window.rootViewController=mnavigation;
//        }else if ([model.status isEqualToString:@"success"]){
//            //审核成功
//            CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
//            cLSMerchantJoinSuccessVC.isSucess=YES;
//            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
//            ShareApp.window.rootViewController=mnavigation;
//        }else if ([model.status isEqualToString:@"paid"]){
//            //已支付手续费
//            NSDictionary *infoDict=@{@"fetchInfo":@(YES)};
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"FetchInfo" object:nil userInfo:infoDict];
//            ShareApp.window.rootViewController=[CLSHTabBarVC new];
//        }else if ([model.status isEqualToString:@"expired"]){
//            //已过期
//            //  }
//            
//        }
//        else{
//            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHMerchantJoinProcessVC new]];
//            ShareApp.window.rootViewController = mnavigation;
//        }
//
//    }
    
}
/*
//        }else if ([model.shopStatus isEqualToString:@"paid"]){
//            //已支付手续费
//            NSDictionary *infoDict=@{@"fetchInfo":@(YES)};
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"FetchInfo" object:nil userInfo:infoDict];
//            ShareApp.window.rootViewController=[CLSHTabBarVC new];
//        }else if ([model.shopStatus isEqualToString:@"expired"]){
//            //已过期
//        }
//        
//    }else{
//        CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHMerchantJoinProcessVC new]];
//        ShareApp.window.rootViewController = mnavigation;
//    }
//*/

//表单验证
- (BOOL)validate{
    
    
    if (self.loginView.accountTextField.text == nil || [self.loginView.accountTextField.text isEqualToString:@""] || ![KBRegexp checkPhoneNumInput:self.loginView.accountTextField.text]) {
        [MBProgressHUD showError:@"账号输入有误！"];
        return NO;
    }else if (self.loginView.passwordTextField.text == nil || [self.loginView.passwordTextField.text isEqualToString:@""] || self.loginView.passwordTextField.text.length<5) {
        
        [MBProgressHUD showError:@"密码输入有误！"];
        return NO;
    }else{
        
        return YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
