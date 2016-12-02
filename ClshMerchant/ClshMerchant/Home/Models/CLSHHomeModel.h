//
//  CLSHHomeModel.h
//  ClshMerchant
//
//  Created by kobe on 16/8/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface CLSHHomeModel : NSObject

@property (nonatomic, copy)NSString *balance;           ///<余额
@property (nonatomic, copy)NSString *merchantID;        ///<商家Id
@property (nonatomic, copy)NSString *memberId;          ///<用户Id
@property (nonatomic, copy)NSString *todayVisitCount;   ///<今日访客量
@property (nonatomic, copy)NSString *totalIncomeAmount; ///<总收入金额
@property (nonatomic, copy)NSString *totalSalesCount;   ///<总销售量


/**
 *  fetch home data
 *
 *  @param params     params
 *  @param completion result
 */
-(void)fetchHomeData:(NSDictionary *)params
            callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHDiscountdataModel : NSObject

@property (nonatomic,strong)NSArray * modelMapList;        ///<折扣数组

/**
 *  折扣列表
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchDiscountData:(id)params callBack:(void (^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHDiscountListModel : NSObject

@property (nonatomic,copy)NSString * discountID;           ///<折扣id
@property (nonatomic,copy)NSString * discount;            ///<折扣

@end



@interface CLSHApplyDiscountDataModel : NSObject

- (void)fetchApplyDiscountData:(id)params callBack:(void (^)(BOOL isSuccess,id result))completion;

@end

NS_ASSUME_NONNULL_END
