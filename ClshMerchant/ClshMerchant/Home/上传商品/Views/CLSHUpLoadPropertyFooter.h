//
//  CLSHUpLoadPropertyFooter.h
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

@protocol  CLSHUpLoadPropertyFooterDelegate <NSObject>
-(void)addProperty;
@end

@interface CLSHUpLoadPropertyFooter : UITableViewHeaderFooterView
@property (nonatomic, weak) id <CLSHUpLoadPropertyFooterDelegate>delegate;
@end
