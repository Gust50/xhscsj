//
//  CLSHModifyPasswordModel.h
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

@interface CLSHModifyPasswordModel : NSObject

/**
 *  修改密码
 *
 *  @param params    smsToken                  ///<手机验证码
 *  @param params    oldPassword               ///<旧密码
 *  @param params    newPassword               ///<新密码
 *  @param completion  返回数据
 */
-(void)fetchAccountModifyPasswordModel:(NSDictionary *)params
                              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
