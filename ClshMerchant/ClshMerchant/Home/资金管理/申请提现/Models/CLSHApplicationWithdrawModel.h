//
//  CLSHApplicationWithdrawModel.h
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

@interface CLSHApplicationWithdrawModel : NSObject

/**
 *  申请提现
 *
 *  @param amount            提现金额
 *  @param bankAccountId     银行卡Id
 *  @param completion 返回数据
 */
-(void)fetchApplicationWithdrawData:(NSDictionary *)params
                      callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
