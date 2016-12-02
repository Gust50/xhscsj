//
//  CLSHDeleteCategoryView.h
//  ;
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

typedef void(^deleteCategoryBlock)();
typedef void(^noDeleteCategoryBlock)();
@interface CLSHDeleteCategoryView : UIView

@property (nonatomic, copy)deleteCategoryBlock deleteCategoryBlock;
@property (nonatomic, copy)noDeleteCategoryBlock noDeleteCategoryBlock;

@end
