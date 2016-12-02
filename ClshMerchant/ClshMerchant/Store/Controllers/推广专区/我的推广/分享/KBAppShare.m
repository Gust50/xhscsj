//
//  KBAppShare.m
//  ClshUser
//
//  Created by kobe on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "KBAppShare.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
// 弹出分享菜单需要导入的头文件
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

@implementation KBAppShare



+(void)share:(KBAppShare *)shareModel{
    NSMutableDictionary *shareParams=[NSMutableDictionary dictionary];
    NSArray *imageArray=@[shareModel.thumbImage];
    
    [shareParams SSDKSetupShareParamsByText:shareModel.detail
                                     images:imageArray
                                        url:[NSURL URLWithString:shareModel.imageurl]
                                      title:shareModel.title
                                       type:SSDKContentTypeAuto];
    
    SSUIShareActionSheetController *sheet=[ShareSDK showShareActionSheet:nil
                                                                   items:nil
                                                             shareParams:shareParams
                                                     onShareStateChanged:^(SSDKResponseState state,
                                                                           SSDKPlatformType platformType,
                                                                           NSDictionary *userData,
                                                                           SSDKContentEntity *contentEntity,
                                                                           NSError *error,
                                                                           BOOL end) {
                                                         switch (state) {
                                                             case SSDKResponseStateSuccess:
                                                                 [MBProgressHUD showSuccess:@"分享成功"];
                                                                 break;
                                                             case SSDKResponseStateFail:
                                                                 [MBProgressHUD showError:@"分享失败"];
                                                             default:
                                                                 break;
                                                         }
                                                     }];
    
    
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
}


+(void)shareGoodsUrl:(KBAppShare *)shareModel{
    NSMutableDictionary *shareParams=[NSMutableDictionary dictionary];
    NSArray *imageArray=shareModel.thumbImageUrl;
    
    [shareParams SSDKSetupShareParamsByText:@"#粗粮生活# 给你不一样的生活...（分享自@粗粮生活APP）为吃货谋口福,为胃而生 戳链接↖(^ω^)↗ http://m.culsh.cn/appDownload.html"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://m.culsh.cn/appDownload.html"]
                                      title:shareModel.title
                                       type:SSDKContentTypeAuto];
    
    SSUIShareActionSheetController *sheet=[ShareSDK showShareActionSheet:nil
                                                                   items:nil
                                                             shareParams:shareParams
                                                     onShareStateChanged:^(SSDKResponseState state,
                                                                           SSDKPlatformType platformType,
                                                                           NSDictionary *userData,
                                                                           SSDKContentEntity *contentEntity,
                                                                           NSError *error,
                                                                           BOOL end) {
                                                         switch (state) {
                                                             case SSDKResponseStateSuccess:
                                                                 [MBProgressHUD showSuccess:@"分享成功"];
                                                                 break;
                                                             case SSDKResponseStateFail:
                                                                 [MBProgressHUD showError:@"分享失败"];
                                                             default:
                                                                 break;
                                                         }
                                                     }];
    
    
//    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    //自定义编辑界面的UI
     [SSUIEditorViewStyle setiPhoneNavigationBarBackgroundColor:systemColor];
     [SSUIEditorViewStyle setTitleColor:[UIColor whiteColor]];
    [SSUIEditorViewStyle setCancelButtonLabelColor:[UIColor whiteColor]];
    [SSUIEditorViewStyle setShareButtonLabelColor:[UIColor whiteColor]];
    //设置分享编辑界面状态栏风格
    [SSUIEditorViewStyle setStatusBarStyle:UIStatusBarStyleDefault];
    
}

+(void)share{
    NSMutableDictionary *shareParams=[NSMutableDictionary dictionary];
    NSArray *imageArray=@[@"http://p1.qhimg.com/t01103b594a0cecf215.jpg"];
    
    [shareParams SSDKSetupShareParamsByText:@"宠物狗"
                                     images:imageArray
                                        url:nil
                                      title:@"宠物"
                                       type:SSDKContentTypeAuto];
    
    SSUIShareActionSheetController *sheet=[ShareSDK showShareActionSheet:nil
                                                                   items:nil
                                                             shareParams:shareParams
                                                     onShareStateChanged:^(SSDKResponseState state,
                                                                           SSDKPlatformType platformType,
                                                                           NSDictionary *userData,
                                                                           SSDKContentEntity *contentEntity,
                                                                           NSError *error,
                                                                           BOOL end) {
                                                         switch (state) {
                                                             case SSDKResponseStateSuccess:
                                                                 [MBProgressHUD showSuccess:@"分享成功"];
                                                                 break;
                                                            case SSDKResponseStateFail:
                                                                 [MBProgressHUD showError:@"分享失败"];
                                                             default:
                                                                 break;
                                                         }
                                                     }];
    
    
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    
}

+(void)loginWithQQ{
    
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        
        //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
        //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
        associateHandler (user.uid, user, user);
        NSLog(@"dd%@",user.rawData);
        NSLog(@"dd%@",user.credential);

    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        
        switch (state) {
            case SSDKResponseStateSuccess:
                [MBProgressHUD showSuccess:@"登录成功"];
                break;
                case SSDKResponseStateFail:
                [MBProgressHUD showError:@"登录失败"];
            default:
                break;
        }
    }];
}

+(void)loginWithWechat{
    
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
                [MBProgressHUD showSuccess:@"登录成功"];
                break;
            case SSDKResponseStateFail:
                [MBProgressHUD showError:@"登录失败"];
            default:
                break;
        }
    }];
}

+(void)loginWithWeibo{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
                [MBProgressHUD showSuccess:@"登录成功"];
                break;
            case SSDKResponseStateCancel:
                [MBProgressHUD showError:@"登录失败"];
            default:
                break;
        }
    }];
}
@end
