//
//  CLSMerchantJoinSuccessVC.h
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSMerchantJoinSuccessVC : UIViewController

@property (nonatomic, copy)NSString *name;

@property (nonatomic, assign) BOOL isSucess;
@property (nonatomic, assign) BOOL nonCertification;   ///<没有实名认证
@property (nonatomic, assign) BOOL isFailCertification;///<实名认证失败
@property (nonatomic, assign) BOOL isFailJoin;         ///<入驻失败
@property (nonatomic, assign) BOOL isFailCerAndJoin;   ///<实名认证和入驻失败
@property (nonatomic, assign) BOOL nonJoin;            ///<没有入驻

@end
