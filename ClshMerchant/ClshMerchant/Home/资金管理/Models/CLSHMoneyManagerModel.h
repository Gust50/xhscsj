//
//  CLSHMoneyManagerModel.h
//  ClshMerchant
//
//  Created by arom on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHMoneyManagerModel : NSObject

@property (nonatomic,copy)NSString * shopId;            ///<店铺id
@property (nonatomic,assign)CGFloat one2fifteen;        ///<1-15天资金
@property (nonatomic,assign)CGFloat fifteen2thirty;     ///<15-30天
@property (nonatomic,assign)CGFloat balance;            ///<可用余额
@property (nonatomic,assign)CGFloat freezedBlance;      ///<冻结金额

/**
 *  资金管理首页
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountBalanceData:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHSettleImmediatelyModel : NSObject

@property (nonatomic ,strong)NSArray * items;

- (void)fetchSettleBalanceImmediately:(NSDictionary *)params
                             callBack:(void (^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHSettleBalanceListModel : NSObject

@property (nonatomic,copy)NSString * date;           ///<日期
@property (nonatomic,copy)NSString * daycount;       ///<累计天数
@property (nonatomic,assign)CGFloat amount;          ///<金额
@property (nonatomic,assign)CGFloat calAmount;       ///<预算与结算

@end


@interface CLSHSubmitSettleModel : NSObject

- (void)fetchSubmitSettle:(id)params
                 callBack:(void (^)(BOOL isSuccess,id result))completion;

@end
