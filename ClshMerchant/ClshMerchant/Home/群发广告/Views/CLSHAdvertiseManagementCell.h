//
//  CLSHAdvertiseManagementCell.h
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

@class CLSHAdListModel;
typedef void(^lookAdvertiseDetailBlock)();
@interface CLSHAdvertiseManagementCell : UITableViewCell

@property (nonatomic, copy)lookAdvertiseDetailBlock lookAdvertiseDetailBlock;
@property (nonatomic, strong)CLSHAdListModel * model;
@end
