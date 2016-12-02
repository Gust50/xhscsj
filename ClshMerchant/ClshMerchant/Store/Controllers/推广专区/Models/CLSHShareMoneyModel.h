//
//  CLSHShareMoneyModel.h
//  ClshUser
//
//  Created by wutaobo on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHShareMoneyModel : NSObject

@property (nonatomic, copy) NSString *code;     ///<邀请码
@property (nonatomic, copy) NSString *image;    ///<头像、图片
@property (nonatomic, copy) NSString *logoUrl;  ///<log
@property (nonatomic, copy) NSString *name;  ///<用户名称
@property (nonatomic, copy) NSString *shareLink;  ///<链接
@property (nonatomic, copy) NSString *shareDesc;  ///<描述
@property (nonatomic, copy) NSString *shareTitle;  ///<标题


/**
 *  分享赚钱
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountShareMoneyModel:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
