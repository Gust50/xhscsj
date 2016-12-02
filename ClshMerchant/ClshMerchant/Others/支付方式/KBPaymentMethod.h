//
//  KBPaymentMethod.h
//  ClshUser
//
//  Created by kobe on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface KBPaymentMethod : NSObject
/**
 *  Alipay
 *
 *  @param params 订单数组
 */
+(void)AlipayMethod:(NSDictionary *)params;
/**
 *  WechatPay
 *
 *  @param params 订单数组
 */
+(void)WechatMethod:(NSDictionary *)params;
/**
 *  BalancePay
 *
 *  @param params 订单数组
 */
+(void)BalanceMethod:(NSDictionary *)params;

@end




@interface KBAlipayModel : NSObject

/**
 *  Alipay
 *
 *  @param params     params
 *  @param completion return
 */
-(void)fetchAlipayData:(NSDictionary *)params
                    callBack:(void(^)(BOOL isSuccess,id result))completion;
@end




@interface KBWechatPayModel : NSObject

/**
 *  WechatPay
 *
 *  @param params     params
 *  @param completion return
 */
-(void)fetchWechatPayData:(NSDictionary *)params
              callBack:(void(^)(BOOL isSuccess,id result))completion;
@end




@interface KBBalancePayModel : NSObject

/**
 *  BalancePay
 *
 *  @param params     params
 *  @param completion return
 */
-(void)fetchBalancePayData:(NSDictionary *)params
                 callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

