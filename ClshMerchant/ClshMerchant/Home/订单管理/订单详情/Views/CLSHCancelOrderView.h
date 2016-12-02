//
//  CLSHCancelOrderView.h
//  ClshMerchant
//
//  Created by arom on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@protocol cancelOrderDelagate <NSObject>

- (void)cancelOrder;

@end

@interface CLSHCancelOrderView : UIView

@property (nonatomic,strong)UIView * maskView;
@property (nonatomic,strong)UIView * contentView;
@property (nonatomic,strong)UITextView * textFieldView;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIButton * sureButton;
@property (nonatomic,strong)UIButton * cancelButton;

@property (nonatomic,weak)id <cancelOrderDelagate> delegate;
@end
