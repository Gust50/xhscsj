//
//  CLSHMassInfoFooterView.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^payBlock)();
@interface CLSHMassInfoFooterView : UIView
@property (nonatomic, copy)payBlock payBlock;

@property (nonatomic, copy)NSString *totalAmount;   ///<传入合计支付金额
@end
