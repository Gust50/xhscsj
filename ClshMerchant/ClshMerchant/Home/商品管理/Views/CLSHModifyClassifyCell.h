//
//  CLSHModifyClassifyCell.h
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

@class CLSHCategoryListModel;
@interface CLSHModifyClassifyCell : UITableViewCell
//@property (strong, nonatomic) IBOutlet UIButton *select;

@property (nonatomic,strong)CLSHCategoryListModel * model;
@end
