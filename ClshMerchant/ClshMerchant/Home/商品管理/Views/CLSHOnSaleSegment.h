//
//  CLSHOnSaleSegment.h
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

@protocol  CLSHOnSaleSegmentDelegate<NSObject>
-(void)clickSegment:(BOOL)isOnsale;
@end

@interface CLSHOnSaleSegment : UIView
@property (nonatomic, copy) NSString *onSaleText;
@property (nonatomic, copy) NSString *saleOutText;
@property (nonatomic, weak) id<CLSHOnSaleSegmentDelegate>delegate;
@end
