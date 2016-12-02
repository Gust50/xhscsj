//
//  CLSHBankCartDropMenuVC.h
//  ClshUser
//
//  Created by wutaobo on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>
@class CLSHAccountCardBankCategoryModel;

@interface CLSHBankCartDropMenuVC : UITableViewController

@property (nonatomic, strong) CLSHAccountCardBankCategoryModel *accountCardBankCategoryModel;     ///<银行卡类型数据模型
@property (nonatomic, strong)NSArray *userArray;    ///<传入用户名数组

@property (nonatomic, assign)NSInteger tag;         ///<判断是选择哪个类型

@end
