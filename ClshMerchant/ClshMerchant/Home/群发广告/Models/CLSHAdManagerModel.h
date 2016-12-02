//
//  CLSHAdManagerModel.h
//  ClshMerchant
//
//  Created by arom on 16/8/10.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHAdManagerModel : NSObject

@property (nonatomic,strong)NSArray * sliderAd;               ///<adListModel

/**
 *  广告详情基model
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAdManagerData:(NSMutableDictionary *)params
               callBack:(void (^)(BOOL isSuccess, id result))completion;

@end


@interface CLSHAdListModel : NSObject

@property (nonatomic,copy)NSString * title;                        ///<标题
@property (nonatomic,copy)NSString * adId;                         ///<广告id
@property (nonatomic,assign)BOOL isExpired;                        ///<是否过期
@property (nonatomic,assign)NSInteger browseCount;                 ///<浏览人数
@property (nonatomic,assign)NSInteger luckyDrawCatchedCount;       ///<领取的红包数
@property (nonatomic,assign)NSInteger couponCatchedCount;          ///<领取的优惠券
@property (nonatomic,copy)NSString * createDate;                   ///<广告开始日期
@property (nonatomic,assign)NSInteger totalUserCount;

@end


@interface CLSHAdDetailManagerModel : NSObject

@property (nonatomic,copy)NSString * title;                       ///<标题
@property (nonatomic,copy)NSString * shopName;                    ///<店铺名称
@property (nonatomic,copy)NSString * shopAvater;                  ///<店铺头像
@property (nonatomic,copy)NSString * adDetailID;                        ///<广告id
@property (nonatomic,copy)NSString * expiredDate;                 ///<广告截止日期
@property (nonatomic,copy)NSString * introduction;                ///<广告介绍
@property (nonatomic,strong)NSArray * images;                      ///<广告图片
@property (nonatomic,assign)NSInteger browseCount;                ///<浏览人数
@property (nonatomic,assign)NSInteger luckyDrawCatchedCount;      ///<领取的红包
@property (nonatomic,assign)NSInteger notReceiveLuckyDrawCount;   ///<未领取的红宝书
@property (nonatomic,assign)NSInteger couponCatchedCount;         ///<领取的优惠券数
@property (nonatomic,assign)NSInteger notReceiveCouponCount;      ///<未领取的优惠券数

/**
 *  广告详情
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAdDetailManagerData:(NSMutableDictionary *)params
               callBack:(void (^) (BOOL isSuccess, id result))completion;

@end

@interface CLSHAddAdModel : NSObject

/**
 *  添加广告
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAddAdData:(NSDictionary *)params
              callBack:(void (^) (BOOL isSuccess, id result))completion;

@end

@interface CLSHMerchantGetAdvertiseWalletModel : NSObject

@property (nonatomic, assign) BOOL coupon;  ///<获得优惠劵
@property (nonatomic, assign) BOOL luckyDraw;  ///<获得红包


/**
 *  广告预览领取奖励
 *
 *  @param params     luckyDrawADId ///<广告红包任务id
 *  @param completion 返回数据
 */

-(void)fetchAccountMerchantGetAdvertiseWalletModel:(NSDictionary *)params
                                          callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAddAdSelectUsersModel : NSObject
@property (nonatomic, assign)NSInteger female;              ///<女生人数
@property (nonatomic, assign)NSInteger male;                ///<男生人数
@property (nonatomic, assign)NSInteger notMaleNotFemale;    ///<其他人数
@property (nonatomic, strong)NSArray *items;                ///<
@property (nonatomic, assign)NSInteger totalCount;          ///<总人数

/**
 *  Select Users
 *
 *  @param type       筛选
 *  @param value      值
 *  @param completion result
 */
-(void)fetchSelectUsersData:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAddAdSelectUsersListModel : NSObject

@property (nonatomic, copy)NSString *gender;             ///<性别
@property (nonatomic, copy)NSString *userName;           ///<用户名
@property (nonatomic, assign)CGFloat consumptionAmount;  ///<消费金额
@property (nonatomic, assign)NSInteger consumptionCount;   ///<消费次数
@property (nonatomic, assign)CGFloat distance;           ///<距离多少米
@property (nonatomic, copy)NSString *avatar;             ///<头像

@end
