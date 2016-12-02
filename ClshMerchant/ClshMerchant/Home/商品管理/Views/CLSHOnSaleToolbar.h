//
//  CLSHOnSaleToolbar.h
//  ClshMerchant
//
//  Created by kobe on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@protocol  CLSHOnSaleToolbarDelegate<NSObject>
-(void)addShops;
-(void)managerShops;
@end

@interface CLSHOnSaleToolbar : UIView
@property (nonatomic, weak) id<CLSHOnSaleToolbarDelegate>delegate;
@end
