//
//  CLSHOrderDetailViewController.h
//  ClshMerchant
//
//  Created by arom on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSHOrderDetailViewController : UIViewController

@property (nonatomic,assign)BOOL isPayed;
@property (nonatomic,assign)BOOL isCancelOrder;

@property (nonatomic,copy)NSString * sn;
@property (nonatomic,copy)NSString * orderId;

@end
