//
//  CLSHStoreDescribeCell.h
//  ClshMerchant
//
//  Created by kobe on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSHStoreDescribeCell : UITableViewCell
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *titleContent;
@property (nonatomic, copy) NSString *describeContent;
@property (nonatomic, strong) UIImageView *arrow;
@end
