//
//  FetchAppPublicKey.h
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>
#import "CLSHLoginInfoModel.h"
#import <UIKit/UIKit.h>

@interface FetchAppPublicKeyModel : NSObject
@property (nonatomic, assign) CGFloat longitude;              ///<经度
@property (nonatomic, assign) CGFloat latitude;               ///<纬度
@property(nonatomic,strong)NSString *publicKey;               ///< APP公钥
@property(nonatomic,assign)BOOL isLogin;                      ///< 用户是否登录
@property(nonatomic,strong)CLSHLoginInfoModel *infoModel;     ///< 用户登录信息

@property (nonatomic,assign)BOOL isFlat;                      ///<是否绑定折扣
@property (nonatomic,assign)BOOL isPinless;                   ///<不知道是什么鬼
@property (nonatomic,copy)NSString * shopid;                  ///<店铺id



/**
 *  singleton
 */
+(instancetype)shareAppPublicKeyManager;


/**
 *  get publicKey
 *
 *  @param params             params
 *  @param completion         return publicKey
 */
-(void)fetchAppPublicKey:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  get EncryptParams
 *
 *  @return Dictionary
 */
-(NSDictionary *)fetchEncryptParams;
/**
 *  get EncryptParams
 *
 *  @param needEncryptParams
 *
 *  @return Dictionary
 */
-(NSDictionary *)fetchEncryptParams:(NSDictionary *)needEncryptParams;
@end
