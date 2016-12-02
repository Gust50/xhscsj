//
//  CLSHModifyPhoneNumModel.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHModifyPhoneNumModel : NSObject

/**
 *  修改手机号
 *
 *  @param params    mobile            ///<新手机号码
 *  @param completion  返回数据
 */
-(void)fetchAccountModifyPhoneModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@property (nonatomic, copy) NSString *mobile;         ///<绑定的手机号码


@end

@interface CLSHPhoneNumModel : NSObject

@property (nonatomic, copy) NSString *mobile;         ///<绑定的手机号码

/**
 *  获取手机验证码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountValidateCodeModel:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;
/**
 *  获取绑定手机号
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountPhoneNumModel:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountCheckTokenModel : NSObject

/**
 *  验证验证码
 *
 *  @param params    smsToken               ///<手机验证码
 *  @param completion  返回数据
 */
-(void)fetchAccountCheckTokenModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHNewPhoneNumModel : NSObject

/**
 *  修改手机号获取手机验证码
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchModifyPhoneNumValidateCodeModel:(id)params
                                   callBack:(void (^)(BOOL isSuccess,id result))completion;

@end
