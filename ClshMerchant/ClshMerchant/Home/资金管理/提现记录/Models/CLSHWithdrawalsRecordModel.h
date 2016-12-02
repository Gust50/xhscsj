//
//  CLSHWithdrawalsRecordModel.h
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

@interface CLSHWithdrawalsRecordModel : NSObject

@property (nonatomic, strong)NSArray *withdrawLogs;
@property (nonatomic, assign)NSInteger totalPages;

/**
 *  提现记录
 *
 *  @param pageNumber     参数
 *  @param pageSize       参数
 *  @param completion 返回数据
 */
-(void)fetchWithdrawalsRecordData:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHWithdrawalsRecordListModel : NSObject

@property(nonatomic,copy)NSString *sn;                  ///<流水号
@property(nonatomic,copy)NSString *itemID;              ///<提现ID
@property(nonatomic,assign)CGFloat balance;             ///<余额
@property(nonatomic,assign)CGFloat withDrawAmount;      ///<提现金额
@property(nonatomic,copy)NSString *withDrawCreateDate;  ///<时间戳
/**  
 processing 处理中，
 transferred 已经到账，
 rejected 申请失败
 */
@property(nonatomic,copy)NSString *withDrawStatus;      ///<提现状态

@end

@interface CLSHWithdrawalsRecordDetailModel : NSObject

@property (nonatomic, copy)NSString *sn;                    ///<流水号
@property (nonatomic, copy)NSString *startDate;             ///<开始时间
@property (nonatomic, copy)NSString *amount;                ///<提现金额
@property (nonatomic, copy)NSString *balance;               ///<余额
@property (nonatomic, copy)NSString *bankAccountName;       ///<银行名称
@property (nonatomic, copy)NSString *userName;              ///<提现用户
@property (nonatomic, copy)NSString *bankAccountNumber;     ///<提现到账的银行卡号
@property (nonatomic, copy)NSString *memo;                  ///<提现留言
@property (nonatomic, copy)NSString *planTransferringDate;  ///<预计到账时间
@property (nonatomic, copy)NSString *transferredDate;       ///<实际到账时间
@property (nonatomic, copy)NSString *status;                ///<状态：processing 处理中，transferred 已经到账，rejected 申请失败

/**
 *  提现记录详情
 *
 *  @param withDrawLogId     提现记录id
 *  @param completion 返回数据
 */
-(void)fetchWithdrawalsRecordDetailData:(NSDictionary *)params
                         callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
