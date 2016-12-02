//
//  CLSHRegistModel.h
//  ClshMerchant
//
//  Created by arom on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CLSHRegistModel : NSObject
/**
 *  注册
 *
 *  @param params     参数
 *  @param completion 返回
 */
-(void)postAppRegisterData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  获取语音验证码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)postAppPhoneData:(id)params
               callBack:(void(^)(BOOL isSuccess,id result))completion;


/**
 *  获取语音验证码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)postAppPhoneVoiceData:(id)params
               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHtelephoneVerifyModel : NSObject

@property (nonatomic,assign)BOOL isOccupy;    //号码是否存在

/**
 *  验证手机号码是否注册过
 *
 *  @param params     参数
 *  @param completion 返回信息
 */

- (void)FetchTelePhoneIsregistedData:(id)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;


@end

NS_ASSUME_NONNULL_END
