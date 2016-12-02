//
//  CLSHAccountBalanceModel.h
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

@interface CLSHAccountBalanceModel : NSObject

@property (nonatomic,copy)NSString *balance;    ///<余额
@property (nonatomic, copy)NSString *freezedBalance;    ///<冻结余额

/**
 *  资金管理首页
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountBalanceData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountIncomeModel : NSObject

@property (nonatomic, strong)NSArray *items;
@property (nonatomic, copy)NSString *totalPages;  ///<总页数
@property (nonatomic, copy)NSString *totalInAmount; ///<总收入
@property (nonatomic, copy)NSString *totalOutAmount; ///<总支出
//@property (nonatomic, assign)NSInteger totalPages;  ///<总页数

/**
 *  资金明细
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountIncomeData:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountIncomeListModel : NSObject
@property (nonatomic, copy)NSString *amount;    ///<金额
/** 
 recharge,充值
 adjustment,调整预存款
 payment,付款
 refunds,返现
 withdraw, 提现
 gift, 礼品
 earning,赚钱
 transfer转账
 */
@property (nonatomic, copy)NSString *type;
/**
 credit:收入
 debit:支出
 */
@property (nonatomic, copy)NSString *amountType;
@property (nonatomic, copy)NSString *incomeID;
@property (nonatomic, copy)NSString *memo;  ///<描述
@property (nonatomic, copy)NSString *sn;    ///<流水号
//@property (nonatomic, assign)NSTimeInterval timestamp; ///<时间
@property (nonatomic, copy)NSString *timestamp; ///<时间

@end

@interface CLSHAccountIncomeDetailModel : NSObject

@property (nonatomic, copy)NSString *amountType;    ///<余额操作相关的资金记录
@property (nonatomic, copy)NSString *balance;    ///<余额
@property (nonatomic, assign)NSTimeInterval createDate;    ///<创建时间
@property (nonatomic, copy)NSString *credit;    ///<收入的
@property (nonatomic, copy)NSString *debit;    ///<支出的
@property (nonatomic, copy)NSString *incomeDetailID;
@property (nonatomic, copy)NSString *memo;    ///<留言
@property (nonatomic, copy)NSString *modifyDate;    ///<修改时间
@property (nonatomic, copy)NSString *sn;    ///<流水号
@property (nonatomic, copy)NSString *summary;
/**
 recharge,充值
 adjustment,调整预存款
 payment,付款
 refunds,返现
 withdraw, 提现
 gift, 礼品
 earning,赚钱
 transfer转账
 */
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *version;

/**
 *  收支明详情
 *
 *  @param id     收支记录id
 *  @param completion 返回数据
 */
-(void)fetchAccountIncomeDetailData:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end





@interface CLSHIncomeModel : NSObject

@property (nonatomic,strong)NSArray * items;
@property (nonatomic,assign)NSNumber * pageNumber;
@property (nonatomic,assign)NSNumber * pageSize;
@property (nonatomic,assign)NSNumber * totalPages;
/**
 *  收入明细
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchIncomeData:(NSDictionary *)params
                     callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
//

@interface CLSHIncomeDetailModel : NSObject

@property (nonatomic, copy)NSString *id;  ///ID(接口中无这个参数，收入明细内容需要有)
@property (nonatomic, copy)NSString * createDate; ///创建时间
@property (nonatomic, copy)NSString * effectiveTime;//收益生效时间
@property (nonatomic, copy)NSNumber *inAmount;//入账金额
@property (nonatomic, assign)BOOL isEffectived;//是否收益生效
@property (nonatomic, assign)BOOL isTransferred;//是否已提现
@property (nonatomic, copy)NSString *effectivedDay;//已结算收益天数
@property (nonatomic, copy)NSString *remainEffectiveDay;//剩余可结算收益天数
@property (nonatomic, copy)NSString *sn;//订单号
@property (nonatomic, copy)NSString *name;//订单商品项目名（商品名称）
@property (nonatomic, copy)NSString *orderAmount;//订单金额
@property (nonatomic, copy)NSString *memo;//备注

@end
