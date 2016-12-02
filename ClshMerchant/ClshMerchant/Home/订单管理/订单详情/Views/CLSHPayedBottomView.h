//
//  CLSHPayedBottomView.h
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

typedef void(^deliveryBlock)();
typedef void(^cancelOrderBlock)();

@interface CLSHPayedBottomView : UIView

@property (nonatomic,strong)UIButton * leftButton;
@property (nonatomic,strong)UIButton * rightButton;

@property (nonatomic,copy)deliveryBlock deliveryblock;     ///<配送block
@property (nonatomic,copy)cancelOrderBlock cancelOrderblock; ///<取消订单block

@end
