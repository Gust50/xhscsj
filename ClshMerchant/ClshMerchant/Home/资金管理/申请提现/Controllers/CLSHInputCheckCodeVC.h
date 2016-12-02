//
//  CLSHInputCheckCodeVC.h
//  ClshMerchant
//
//  Created by wutaobo on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSHInputCheckCodeVC : UIViewController
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *money; ///<传入提现金额
@property (nonatomic, copy)NSString *bankAcountID; ///<传入银行卡id
@property (nonatomic, assign)BOOL notHomePage;
@property (nonatomic, strong)NSMutableDictionary * needsParams;
@end
