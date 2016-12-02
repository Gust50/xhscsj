//
//  CLSHApplicationForRefundModel.h
//  ClshMerchant
//
//  Created by wutaobo on 16/9/28.
//  Copyright © 2016年 50. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSHApplicationForRefundModel : NSObject


/**
 *  退款申请审核
 *
 *  @param isPass     true、false
 *  @param reason     审核不通过后的录入原因
 *  @param sn         订单sn号
 *  @param userid     用户ID
 *  @param completion 返回数据
 */
- (void)fetchCLSHApplicationForRefundModel:(id)params
                callBack:(void (^)(BOOL isSuccess, id result))completion;

@end
