//
//  CLSHLoginModel.h
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

@class CLSHCertificationModel;
@interface CLSHLoginModel : NSObject
@property (nonatomic,assign)BOOL isShop;                              ///<是否为商家
@property (nonatomic,assign)BOOL isCommon;                            ///<是否为普通用户
@property (nonatomic,assign)BOOL flat;            ///<是否绑定折扣
@property (nonatomic,assign)BOOL pinless;         ///<不知道是什么鬼

@property (nonatomic, copy) NSString *shopStatus;  
@property(nonatomic,strong)CLSHCertificationModel * authentication;   //@2///返回的实名认证的参数名
                                     
/**
 *  登录
 *
 *  @param params     参数
 *  @param completion 返回登录信息
 */
-(void)postAppLoginData:(NSDictionary *)params
               callBack:(void(^)(BOOL isSuccess,id result))completion;


@end

@interface CLSHCertificationModel : NSObject

@property (nonatomic,copy)NSString * status;
@property (nonatomic,copy)NSString * type;       ///<用户类型
@property (nonatomic,copy)NSString * lawPeopleName; ///<法人姓名
@property (nonatomic,copy)NSString * realname;      ///<真实姓名
@property (nonatomic,copy)NSString * shopID;        ///<商家id

@end
