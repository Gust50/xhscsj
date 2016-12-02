//
//  KBAppShare.h
//  ClshUser
//
//  Created by kobe on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KBAppShare;
@interface KBAppShare : NSObject
@property (nonatomic,strong) UIImage * thumbImage;    ///<分享缩略图
@property (nonatomic,copy) NSString *title;           ///<分享标题
@property (nonatomic,copy) NSString *detail;          ///<分享内容
@property (nonatomic,copy) NSString *redirectUrl;     ///<回调
@property (nonatomic,copy) NSString *imageurl;         ///<分享连接
@property (nonatomic, strong) NSArray *thumbImageUrl;    ///<图片连接地址
/**
 *  分享
 */
+(void)share:(KBAppShare *)shareModel;
+(void)shareGoodsUrl:(KBAppShare *)shareModel;

/**
 *  QQ登录
 */
+(void)loginWithQQ;
/**
 *  Wechat登录
 */
+(void)loginWithWechat;
/**
 *  Weibo登录
 */
+(void)loginWithWeibo;

@end
