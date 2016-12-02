//
//  BaseModel.h
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

typedef NS_ENUM(NSInteger, ResponseCode){
    
    ResponseSuccess=0,               //!<成功
    ResponseWarmMessage=4,           //!<警告信息
    ResponseOperaError=8,            //!<操作错误
    ResponseUnLogin=12,              //!<用户未登录
    ResponseSystemError=16,           //!<系统错误
    ResponseUpdateKey=20             ///<更新公钥
    
};

@interface BaseModel : NSObject

@property(nonatomic,assign)ResponseCode code;               ///<状态码
@property(nonatomic,copy)NSString *message;                 ///<返回信息
@property(nonatomic,strong)NSDictionary *content;           ///<返回内容


-(void)postAppDebug:(NSDictionary *)params
           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
