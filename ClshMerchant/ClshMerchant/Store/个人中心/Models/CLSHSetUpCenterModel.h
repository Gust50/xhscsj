//
//  CLSHSetUpCenterModel.h
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

@interface CLSHSetUpCenterModel : NSObject

@property (nonatomic, copy)NSString *mobile;    ///<手机号
@property (nonatomic, copy)NSString *nickname;  ///<昵称
@property (nonatomic, copy)NSString *avatar;    ///<头像

/**
 *  个人中心
 *
 *  @param 参数
 *  @param completion   返回数据
 */
-(void)fetchStoreSetUpCenterData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHIconUploadModel : NSObject

@property(nonatomic,copy)NSString * fileName;     //图片名字
@property(nonatomic,copy)NSString * url;          //图片url

/**
 *  图片上传
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAccountIconUploadModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHIconChangeModel : NSObject

/**
 *  头像更改
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAccountChangeIconModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
