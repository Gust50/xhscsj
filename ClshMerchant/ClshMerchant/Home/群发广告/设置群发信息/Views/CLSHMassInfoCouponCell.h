//
//  CLSHMassInfoCouponCell.h
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
typedef void(^nullBlock)();
@interface CLSHMassInfoCouponCell : UITableViewCell
@property(nonatomic,copy)nullBlock nullblock;//点击无隐藏下面的输入框
@property (strong, nonatomic) IBOutlet UIButton *fullCutCoupons;
@property (strong, nonatomic) IBOutlet UIButton *rebate;
@property (strong, nonatomic) IBOutlet UIButton *noCoupon;

@end
