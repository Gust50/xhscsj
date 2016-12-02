//
//  CLSHDiscountView.h
//  ClshMerchant
//
//  Created by arom on 16/9/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^showDiscountBlock)();
@interface CLSHDiscountView : UIView

@property (nonatomic,copy)showDiscountBlock showDiscountblock;


@end
