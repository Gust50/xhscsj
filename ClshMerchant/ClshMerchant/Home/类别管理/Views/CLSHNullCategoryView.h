//
//  CLSHNullCategoryView.h
//
//
//  Created by wutaobo on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^addCategoryBlock)();
@interface CLSHNullCategoryView : UIView

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *describe;
@property (nonatomic, strong)UIButton *addCategory;

@property (nonatomic, copy)addCategoryBlock addCategoryBlock;
@end
