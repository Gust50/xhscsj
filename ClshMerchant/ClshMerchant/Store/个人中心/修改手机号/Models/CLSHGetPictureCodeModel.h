//
//  CLSHGetPictureCodeModel.h
//  ClshUser
//
//  Created by wutaobo on 16/8/17.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHGetPictureCodeModel : NSObject

/**
 *  获取图片验证码
 *
 *  @param params       参数
 *  @param completion  返回数据
 */
-(void)fetchAccountGetPictureCodeModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHVerifyPictureCodeModel : NSObject

@property (nonatomic, assign)BOOL isValid;  ///<true 正确 false 错误

/**
 *  验证图片验证码
 *
 *  @param params       参数
 *  @param completion  返回数据
 */
-(void)fetchAccountVerifyPictureCodeModel:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
