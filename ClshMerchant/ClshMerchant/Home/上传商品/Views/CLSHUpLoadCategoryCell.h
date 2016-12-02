//
//  CLSHUpLoadCategoryCell.h
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@protocol CLSHUpLoadCategoryCellDelegate <NSObject>
-(void)chooseCategory:(BOOL)isExpand;
-(void)addCategory;
@end

@interface CLSHUpLoadCategoryCell : UITableViewCell
@property (nonatomic, weak) id <CLSHUpLoadCategoryCellDelegate>delegate;
@property (nonatomic, assign)BOOL isCanRotate;      ///<判断是否可以旋转
@property (nonatomic,copy)NSString * categoryName;
@end
