//
//  CLSHDeliveryBottomView.h
//  ClshMerchant
//
//  Created by arom on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^applyFeedBackBlock)();

@interface CLSHDeliveryBottomView : UIView

@property (nonatomic,strong)UIButton * leftButton;

@property (nonatomic,copy)applyFeedBackBlock applyFeedBackblock;    ///<申请退款block

@end
