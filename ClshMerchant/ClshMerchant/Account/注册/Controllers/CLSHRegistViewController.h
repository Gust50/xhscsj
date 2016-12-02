//
//  CLSHRegistViewController.h
//  ClshMerchant
//
//  Created by arom on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^LoginBlock)(NSDictionary * dict);

@interface CLSHRegistViewController : UIViewController

@property (nonatomic,copy)LoginBlock loginblock;//登录传值Block

@end
