//
//  CLSHStoreUpdateModel.h
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

@interface CLSHStoreUpdateModel : NSObject

/**
 *  修改店铺名称
 *
 *  @param shopName   店铺新名称
 *  @param shopId     店铺Id
 *  @param completion 返回数据
 */
-(void)fetchStoreUpdateNameData:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHStoreUpdateAddressModel : NSObject

/**
 *  修改店铺地址
 *
 *  @param address1
 *  @param shopAddress   详细地址
 *  @param shopId        店铺Id
 *  @param completion    返回数据
 */
-(void)fetchStoreUpdateAddressData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHStoreUpdatePhoneModel : NSObject

/**
 *  修改联系电话
 *
 *  @param phone   新手机号码/联系电话
 *  @param shopId  店铺Id
 *  @param completion 返回数据
 */
-(void)fetchStoreUpdatePhoneData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHStoreUpdateCloseStateModel : NSObject

/**
 *  修改歇业状态
 *
 *  @param isClose          ///<  true：歇业    false：开业
 *  @param shopId           ///<店铺Id
 *  @param completion 返回数据
 */
-(void)fetchStoreUpdateCloseStateData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHStoreUpdateIntroductionModel : NSObject

/**
 *  修改店铺简介
 *
 *  @param introduction   简介内容
 *  @param shopId         店铺Id
 *  @param completion     返回数据
 */
-(void)fetchStoreUpdateIntroductionData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHStoreAdLanguageModel : NSObject

/**
 *  添加广告语
 *
 *  @param adLanguage   新广告语
 *  @param shopId       店铺Id
 *  @param completion   返回数据
 */
-(void)fetchStoreAdLanguageData:(NSDictionary *)params
                               callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAcountUpdateNickNameModel : NSObject

/**
 *  修改昵称
 *
 *  @param nickname     昵称
 *  @param completion   返回数据
 */
-(void)fetchAcountUpdateNickNameData:(NSDictionary *)params
                       callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHAcountupdateSupportDeliveryModel : NSObject

/**
 *  修改配送方式
 *
 *  @param isSupportDelivery     是否支持配送
 *  @param isSupportSelfPickUp   是否支持自取
 *  @param completion   返回数据
 */
-(void)fetchAcountUpdateSupportDeliveryData:(NSDictionary *)params
                            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAcountUpdateIsJoinPromotionModel : NSObject

/**
 *  商家是否参加折扣活动
 *
 *  @param isJoinPromotion     true：参加   false：不参加
 *  @param shopId              店铺Id
 *  @param completion          返回数据
 */
-(void)fetchAcountUpdateIsJoinPromotionData:(NSDictionary *)params
                                   callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
