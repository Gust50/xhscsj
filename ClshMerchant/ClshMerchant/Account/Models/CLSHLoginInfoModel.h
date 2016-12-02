//
//  CLSHLoginInfoModel.h
//  ClshUser
//
//  Created by kobe on 16/6/7.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHLoginInfoModel : NSObject

@property(nonatomic,copy)NSString *timestamp;                     ///<时间戳
@property(nonatomic,copy)NSString *token;                         ///<token
@property(nonatomic,copy)NSString *userId;                        ///<用户ID
@property(nonatomic,copy)NSString *username;                      ///<用户名

@end
