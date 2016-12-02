//
//  CLSHSingleIncomeController.h
//  ClshMerchant
//
//  Created by kobe on 16/9/13.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHIncomeDetailModel;
@interface CLSHSingleIncomeController : UITableViewController
@property (nonatomic, copy) NSString *typeID;

@property (nonatomic,strong)CLSHIncomeDetailModel * AccountincomeDetailModel;
@end
