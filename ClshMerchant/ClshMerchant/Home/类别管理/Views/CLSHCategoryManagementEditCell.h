//
//  CLSHCategoryManagementEditCell.h
//  ClshMerchant
//
//  Created by wutaobo on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHCategoryListModel;
typedef void(^editCategoryBlock)();
@interface CLSHCategoryManagementEditCell : UITableViewCell
@property (nonatomic, copy)editCategoryBlock editCategoryBlock;

@property (nonatomic,strong)CLSHCategoryListModel * model;

@end
