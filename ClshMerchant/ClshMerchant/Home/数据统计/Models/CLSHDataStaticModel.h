//
//  CLSHDataStaticModel.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHDataStaticModel : NSObject

@property (nonatomic,assign)NSInteger visitorCount;                  ///<访客
@property (nonatomic,assign)CGFloat income;                          ///<收入
@property (nonatomic,assign)NSInteger sales;                         ///<累计销售
@property (nonatomic,assign)NSInteger luckyDraw;                     ///<发放红包量
@property (nonatomic,assign)NSInteger coupon;                        ///<发放优惠券量

/**
 *  数据统计首页
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchDataStaticData:(NSDictionary *)params
             callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHVisitorStaticModel : NSObject

@property (nonatomic,assign)NSInteger visitorCount;                 ///<累计访客量
//@property (nonatomic,assign)NSInteger todayUV;                      ///<当天UV
//@property (nonatomic,assign)NSInteger todayPV;                      ///<当天PV
//@property (nonatomic,assign)NSInteger sevenDaysUV;                  ///<7天UV
//@property (nonatomic,assign)NSInteger sevenDaysPV;                  ///<7天PV
//@property (nonatomic,assign)NSInteger thirtyDaysUV;                 ///<30天UV
//@property (nonatomic,assign)NSInteger thirtyDaysPV;                 ///<30天PV
@property (nonatomic,assign)NSInteger today;                          ///<今天访客
@property (nonatomic,assign)NSInteger sevenDays;                      ///<7天访客
@property (nonatomic,assign)NSInteger thirtyDays;                     ///<30天访客


- (void)fetchVisitorStaticData:(NSDictionary *)params
                      callBack:(void (^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHIncomeStaticDataModel : NSObject

@property (nonatomic,assign)CGFloat total;                         ///<总收入
@property (nonatomic,assign)CGFloat today;                         ///<今天收入
@property (nonatomic,assign)CGFloat sevenDays;                     ///<7天收入
@property (nonatomic,assign)CGFloat thirtyDays;                    ///<30天收入

- (void)fetchIncomeStaticData:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHLuckyDrawStaticDataModel : NSObject

@property (nonatomic,assign)NSInteger total;                       ///<发出总数量
@property (nonatomic,assign)NSInteger returnCount;                 ///<退还数量
@property (nonatomic,assign)NSInteger returnAmount;                ///<退还金额
@property (nonatomic,assign)NSInteger sendAmount;                  ///<总发出金额

- (void)fetchLuckyDrawStaticData:(NSDictionary *)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHSalesStaticDataModel : NSObject

@property (nonatomic,assign)NSInteger total;                      ///<总量
@property (nonatomic,assign)NSInteger today;                      ///<当天单量
@property (nonatomic,assign)NSInteger sevenDays;                  ///<7天单量
@property (nonatomic,assign)NSInteger thirtyDays;                 ///<30天单量

- (void)fetchSalesStaticData:(NSDictionary *)params
                    callBack:(void (^)(BOOL isSuccess, id result))completion;

@end


@interface CLSHConpousStaticDataModel : NSObject

@property (nonatomic,assign)NSInteger total;                      ///<总量
@property (nonatomic,assign)NSInteger used;                       ///<用量
@property (nonatomic,assign)NSInteger unUsed;                     ///<未使用量
@property (nonatomic,assign)NSInteger deductionAmount;            ///<抵扣金额

- (void)fetchConpousStaticData:(NSDictionary *)params
                    callBack:(void (^)(BOOL isSuccess, id result))completion;

@end

