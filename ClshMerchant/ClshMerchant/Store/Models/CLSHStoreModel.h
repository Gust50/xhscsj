//
//  CLSHStoreModel.h
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

@class CLSHStoreMapModel;
@interface CLSHStoreModel : NSObject

@property (nonatomic, strong)CLSHStoreMapModel *modelMap;

/**
 *  店铺管理首页
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchStoreData:(NSDictionary *)params
            callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHStoreMapModel : NSObject

@property (nonatomic, copy)NSString *adMessage;         ///<商家广告语
@property (nonatomic, copy)NSString *address;           ///<地址
@property (nonatomic, copy)NSString *address1;          ///<店铺地址
@property (nonatomic, copy)NSString *avatar;            ///<商家头像
@property (nonatomic, assign)NSInteger bankAccounts;    ///<银行卡数量
@property (nonatomic, copy)NSString *dailyClosedTime;   ///<店铺关门时间
@property (nonatomic, copy)NSString *dailyOpenTime;     ///<开始营业时间
@property (nonatomic, copy)NSString *deliveryFee;       ///<配送费
@property (nonatomic, copy)NSString *shopId;            ///<店铺id
@property (nonatomic, copy)NSString *introduction;      ///<店铺简介
@property (nonatomic, copy)NSString *isJoinPromotion;   ///<是否参加打折
@property (nonatomic, assign)bool isOpen;            ///<店铺是否营业
@property (nonatomic, assign)bool isSupportDelivery; ///<是否支持配送
@property (nonatomic, assign)bool isSupportSelfPickUp;///<是否支持到店自取
@property (nonatomic, copy)NSString *name;               ///<店铺名
@property (nonatomic, copy)NSString *phone;              ///<我的手机
@property (nonatomic, copy)NSString *phoneNumber;        ///<联系电话
@end



@interface CLSHAccountLogoutModel : NSObject

/**
 *  用户注销
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)postAppLogoutData:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;
@end
