//
//  CLSHMerchantJoinModel.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/4.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHMerchantJoinModel : NSObject

@property (nonatomic, strong)NSArray *industry; ///<一级菜单数组

/**
 *  获取行业列表
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchMerchantJoinData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHMerchantJoinListModel : NSObject

@property (nonatomic, copy)NSString *industryID;    ///<一级菜单ID
@property (nonatomic, copy)NSString *name;          ///<一级菜单名称
@property (nonatomic, strong)NSArray *childen;      ///<二级菜单数组
@end

@interface CLSHMerchantJoinListListModel : NSObject

@property (nonatomic, assign)NSNumber *industryListID;  ///<二级菜单ID
@property (nonatomic, copy)NSString *name;            ///<二级菜单名称

@end


@interface CLSHMerchantJoinWriteInfoModel : NSObject

/**
 *  实名认证
 *
 *  @param 参数
 *  @param completion 返回数据
 */
-(void)fetchMerchantJoinWriteInfoData:(NSDictionary *)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHMerchantJoinInfoModel : NSObject

/**
 *  填写商家入驻资料
 *
 *  @param 参数
 *  @param completion 返回数据
 */
-(void)fetchMerchantJoinInfoData:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

/********************************************获取城市数据********************************************/
@interface CLSHMerchantJoinAddressModel : NSObject

@property (nonatomic, strong)NSArray *rootArea;
@property (nonatomic, copy)NSString * timestamp;             ///<时间戳

/**
 *  从数据库获取省市区数据
 *
 *  @param params     参数
 *  @param completion 返回参数
 */
-(void)fetchMerchantJoinAddressData:(NSDictionary *)params
                             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

