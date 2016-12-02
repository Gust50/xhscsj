//
//  AppDelegate.m
//  ClshMerchant
//
//  Created by kobe on 16/7/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */

//
//                                  _oo8oo_
//                                 o8888888o
//                                 88" . "88
//                                 (| -_- |)
//                                 0\  =  /0
//                               ___/'==='\___
//                             .' \\|     |// '.
//                            / \\|||  :  |||// \
//                           / _||||| -:- |||||_ \
//                          |   | \\\  -  /// |   |
//                          | \_|  ''\---/''  |_/ |
//                          \  .-\__  '-'  __/-.  /
//                        ___'. .'  /--.--\  '. .'___
//                     ."" '<  '.___\_<|>_/___.'  >' "".
//                    | | :  `- \`.:`\ _ /`:.`/ -`  : | |
//                    \  \ `-.   \_ __\ /__ _/   .-` /  /
//                =====`-.____`.___ \_____/ ___.`____.-`=====
//                                  `=---=`
//
//
//       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//              佛祖保佑                                代码无Bug
//



#import "AppDelegate.h"
#import "CLSHTabBarVC.h"
#import "IQKeyboardManager.h"
#import "CLSHLoginModel.h"
#import "CLSHLoginViewController.h"
#import "KBCatchAppCrashLog.h"
#import "CLSHMerchantJoinModel.h"
#import "CLSHNavigationVC.h"
#import "CLSHMerchantJoinProcessVC.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WeiboSDK.h>
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
#import <JPUSHService.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "LRGuidePageViewController.h"
#import <QuartzCore/QuartzCore.h>


#import "CLSHApplicationSubmitSucVC.h"
#import "CLSMerchantJoinSuccessVC.h"


#import "CLSHWriteMerchantJoinInfoVC.h"//@2
#import "CLSHHomeVC.h"//@2

@interface AppDelegate ()<WXApiDelegate,AMapLocationManagerDelegate>
{
    AMapLocationManager *aMapLocationManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
     [AMapServices sharedServices].apiKey=@"15154c53d668dc3eb72c289c184b7982";
     [WXApi registerApp:@"wx9a3035af80ac5230" withDescription:@"02ff7a49e746751fe0bc15450d6e599c"];
    
    
//    [self configLocationManager];
    
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //fetch app crash log
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
//    [NSThread sleepForTimeInterval:3.0];//设置启动页面时间
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
//    //跳到申请入驻编写地图页面
////    CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
////    cLSMerchantJoinSuccessVC.isSucess=NO;
//    CLSHWriteMerchantJoinInfoVC *writeMerchantJoinInfoVC = [[CLSHWriteMerchantJoinInfoVC alloc] init];
//    CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:writeMerchantJoinInfoVC];
//    self.window.rootViewController=mnavigation;
//   [self.window makeKeyAndVisible];

    [ShareSDK registerApp:@"13ef2ad4b3eb8"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeChat:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class]delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         default:
                             break;
                     }
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     switch (platformType) {
                         case SSDKPlatformTypeSinaWeibo:
                             [appInfo SSDKSetupSinaWeiboByAppKey:@"3547552813"
                                                       appSecret:@"f023922105e116887b47dd95d6301524"
                                                     redirectUri:@"http://www.culsh.cn"
                                                        authType:SSDKAuthTypeBoth];
                             
                             break;
                         case SSDKPlatformTypeWechat:
                             [appInfo SSDKSetupWeChatByAppId:@"wx9a3035af80ac5230"
                                                   appSecret:@"02ff7a49e746751fe0bc15450d6e599c"];
                             break;
                         case SSDKPlatformTypeQQ:
                             [appInfo SSDKSetupQQByAppId:@"1105383342"
                                                  appKey:@"Oogxrftj60QWFYAY"
                                                authType:SSDKAuthTypeBoth];
                             break;
                         default:
                             break;
                     }
                 }];

    
    
    
    UIViewController *launchVC=[UIViewController new];
    launchVC.view.backgroundColor=backGroundColor;
    launchVC.view.layer.contents=(__bridge id _Nullable)([UIImage imageNamed:@"launchImg"].CGImage);
    
    self.window.rootViewController=launchVC;
    [self.window makeKeyAndVisible];

    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:launchVC.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    
    //获取公钥
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self getPublicKey];
    });
    
    [self initJpushData:launchOptions];
    return YES;
}


#pragma mark <initJpushData>
-(void)initJpushData:(NSDictionary *)launchOptions{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert) categories:nil];
    }else{
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge|
                                                          UIUserNotificationTypeSound|
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"e95137666368f944148ae0af" channel:@"App Store" apsForProduction:NO advertisingIdentifier:nil];
}



- (void)getAddressData{
    
    CLSHMerchantJoinAddressModel * model = [[CLSHMerchantJoinAddressModel alloc] init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"timestamp"] = @"";
    [model fetchMerchantJoinAddressData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
            NSString * docpath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString * filePath = [docpath stringByAppendingPathComponent:@"area.plist"];
            CLSHMerchantJoinAddressModel * model = result;
            NSArray * AddressArr = model.rootArea;
            [AddressArr writeToFile:filePath atomically:YES];
            
            NSUserDefaults * timeDefault = [NSUserDefaults standardUserDefaults];
            model.timestamp = [timeDefault objectForKey:@"timestamp"];
        }else{
            
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark <fetch publicKey>
-(void)getPublicKey{
    __weak AppDelegate *weakSelf = self;
    TICK;
    [[FetchAppPublicKeyModel shareAppPublicKeyManager]fetchAppPublicKey:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
            [FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey=result;
            DLog(@"publicKey----->%@",result);
            //if is login
            
//            if([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogined"]){
//               __block CLSHLoginModel * model = [[CLSHLoginModel alloc] init];
//                __block CLSHCertificationModel * cerModel = [[CLSHCertificationModel alloc] init];
//                NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"info"]];
//                
//                if ([params[@"username"] length] != 0 && [params[@"password"] length] != 0) {
//                    
//                    [model postAppLoginData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
//                        if (isSuccess) {
//                             TOCK;
//                            model=result;
//                            cerModel = model.authentication;
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [self dealLoginLogic:model withCerModel:cerModel];
//                            });
//                            [FetchAppPublicKeyModel shareAppPublicKeyManager].isFlat = model.flat;
//                            [FetchAppPublicKeyModel shareAppPublicKeyManager].isPinless = model.pinless;
//                        }
//                    }];
//                }
//            }else{
                
                if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTimeLoad"]) {
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstTimeLoad"];
                    LRGuidePageViewController * guidePageVC = [[LRGuidePageViewController alloc] init];
                    guidePageVC.dataArray =(NSMutableArray *)@[@"1免费入驻-640-1136.jpg",@"2购物狂送-640-1136.jpg",@"3折扣优惠-640-1136.jpg",@"4-开放性购物平台-640-1136.jpg"];
                    guidePageVC.viewController = [[CLSHLoginViewController alloc] init];
                    self.window.rootViewController = guidePageVC;
                    [self getAddressData];

                }else{
                    self.window.rootViewController=[CLSHLoginViewController new];
                    
                    }
//            }
        }else{
            [weakSelf getPublicKey];
        }
    }];
}

//已废弃
-(void)dealLoginLogic:(CLSHLoginModel *)model withCerModel:(CLSHCertificationModel *)cerModel{
    if (model.isShop) {
        
        if ([model.shopStatus isEqualToString:@"success"] || [model.shopStatus isEqualToString:@"paid"]) {
            if ([cerModel.status isEqualToString:@"failed"]) {
                //跳转审核失败
                CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
                cLSMerchantJoinSuccessVC.isSucess=NO;
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
                self.window.rootViewController=mnavigation;
                
            }else if ([cerModel.status isEqualToString:@"reviewing"]){
                
                //跳转正在审核
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHApplicationSubmitSucVC new]];
                self.window.rootViewController=mnavigation;
                
            }else{
                
                //跳转首页
                ShareApp.window.rootViewController=[CLSHTabBarVC new];
            }
            
        }else if ([model.shopStatus isEqualToString:@"reviewing"]){
            
            if (model.authentication == nil) {
                //实名认证
                
            }else if ([model.authentication.status isEqualToString:@"failed"]){
                
                //实名认证
            }else{
                
                //入驻正在审核
            }
        }else if ([model.shopStatus isEqualToString:@"failed"]){
            
            if ([cerModel.status isEqualToString:@"failed"]) {
                //提示实名认证 入驻同时失败
                
            }else{
                
                //入驻
                CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHMerchantJoinProcessVC new]];
                ShareApp.window.rootViewController = mnavigation;
            }
        }
    }else{
        
        if (model.authentication == nil) {
            
            //nil
            
        }else if ([cerModel.status isEqualToString:@"failed"]){
            
            //实名认证，入驻。
            
        }else{
            
            //入驻
            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHMerchantJoinProcessVC new]];
            ShareApp.window.rootViewController = mnavigation;
        }
        
    }

}

    
//    if (model.isShop) {
//        
//        if ([cerModel.status isEqualToString:@"reviewing"]) {
//            //等待审核
//            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHApplicationSubmitSucVC new]];
//            self.window.rootViewController=mnavigation;
//        }else if ([cerModel.status isEqualToString:@"failed"]){
//            //审核失败
//            CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
//            cLSMerchantJoinSuccessVC.isSucess=NO;
//            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
//            self.window.rootViewController=mnavigation;
//        }else if ([cerModel.status isEqualToString:@"success"]){
//            //审核成功
//            CLSMerchantJoinSuccessVC *cLSMerchantJoinSuccessVC=[CLSMerchantJoinSuccessVC new];
//            cLSMerchantJoinSuccessVC.isSucess=YES;
//            CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:cLSMerchantJoinSuccessVC];
//            self.window.rootViewController=mnavigation;
//        }else if ([cerModel.status isEqualToString:@"paid"]){
//            //已支付手续费
//            self.window.rootViewController=[CLSHTabBarVC new];
//            
//        }else if ([cerModel.status isEqualToString:@"expired"]){
//            //已过期
//        }
//        
//    }else{
//        CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:[CLSHMerchantJoinProcessVC new]];
//        ShareApp.window.rootViewController = mnavigation;
//    }
//    [self.window makeKeyAndVisible];

#pragma  mark <openURL>
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
        
        [[AlipaySDK defaultService]processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
    }else if ([url.scheme isEqualToString:@"wx9a3035af80ac5230"]){
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}

-(void)onReq:(BaseReq *)req{
    
}

-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response=(PayResp *)resp;
        NSMutableDictionary *wechatPayInfo=[NSMutableDictionary dictionary];
        switch (response.errCode) {
            case WXSuccess:
                [MBProgressHUD showSuccess:@"支付成功"];
                wechatPayInfo[@"Success"]=@(YES);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WechatPay" object:nil userInfo:wechatPayInfo];
                break;
                
            default:
                [MBProgressHUD showError:@"支付失败"];
                wechatPayInfo[@"Success"]=@(NO);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"WechatPay" object:nil userInfo:wechatPayInfo];
                break;
        }
    }
}


#pragma mark <Jpush>
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [JPUSHService registerDeviceToken:deviceToken];
    DLog(@"-----deviceToken-----%@",deviceToken);
}

#pragma mark <iOS7>
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [JPUSHService handleRemoteNotification:userInfo];
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService setBadge:0];
    [JPUSHService resetBadge];
}


#pragma mark <iOS8>
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if ([UIApplication sharedApplication].applicationState==UIApplicationStateActive) {
        UILocalNotification *locationNotification=[UILocalNotification new];
        locationNotification.userInfo=userInfo;
        locationNotification.soundName=UILocalNotificationDefaultSoundName;
        locationNotification.alertBody=[[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
        locationNotification.fireDate=[NSDate date];
        [JPUSHService showLocalNotificationAtFront:locationNotification identifierKey:nil];
    }
}

#pragma mark <iOS8以后>
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    if ([UIApplication sharedApplication].applicationState==UIApplicationStateActive) {
        //程序在前台运行的时候
        UILocalNotification *locationNotification=[UILocalNotification new];
        locationNotification.userInfo=userInfo;
        locationNotification.soundName=UILocalNotificationDefaultSoundName;
        locationNotification.alertBody=[[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
        locationNotification.fireDate=[NSDate date];
        [JPUSHService showLocalNotificationAtFront:locationNotification identifierKey:nil];
    }else if ([UIApplication sharedApplication].applicationState==UIApplicationStateInactive){
        //待激活状态
        [self JpushAction:userInfo];
        
    }else if ([UIApplication sharedApplication].applicationState==UIApplicationStateBackground){
        //后台
        [self JpushAction:userInfo];
        
    }
}

#pragma mark <locationNotification>
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    if (application.applicationState==UIApplicationStateActive) {
        return;
    }else if (application.applicationState==UIApplicationStateInactive){
        [self JpushAction:notification.userInfo];
    }else if (application.applicationState==UIApplicationStateBackground){
        [self JpushAction:notification.userInfo];
    }
}


#pragma mark <public function>
-(void)againLogin{
    [[MBProgressHUD showMessage:@"账号已经在另外一台设备登录"]hide:YES afterDelay:1.8];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)2.0*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController=[[CLSHLoginViewController alloc]init];
        [self.window makeKeyAndVisible];
        [self getPublicKey];
    });
}

-(void)updatePublicKey{
    [self getPublicKey];
}

#pragma mark <location>
-(void)configLocationManager{
    aMapLocationManager=[AMapLocationManager new];
    aMapLocationManager.delegate=self;
    aMapLocationManager.pausesLocationUpdatesAutomatically=NO;
    //iOS9.0后
//    aMapLocationManager.allowsBackgroundLocationUpdates=YES;
    [self startLocation];
}

#pragma mark -- jpush action
- (void)JpushAction:(NSDictionary *)userInfo{

    NSString * Type = [userInfo valueForKey:@"code"];
    
    if ([Type isEqualToString:@""]) {
        //跳转订单详情
        [[NSNotificationCenter defaultCenter]postNotificationName:@"toOrderDetail" object:nil userInfo:userInfo];
    }else if ([Type isEqualToString:@"shopEnter"]){
    
        //入驻成功
        CLSMerchantJoinSuccessVC * joinSuccessVC = [CLSMerchantJoinSuccessVC new];
        joinSuccessVC.isSucess = YES;
        CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:joinSuccessVC];
        ShareApp.window.rootViewController = mnavigation;

    }
}

-(void)startLocation{
    [aMapLocationManager startUpdatingLocation];
}

-(void)stopLocation{
    [aMapLocationManager stopUpdatingLocation];
}

-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    
}

-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    
    [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude=location.coordinate.latitude;
    [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude=location.coordinate.longitude;
    
    [self stopLocation];
}
@end
