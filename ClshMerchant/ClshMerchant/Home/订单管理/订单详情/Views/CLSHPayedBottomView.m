//
//  CLSHPayedBottomView.m
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


#import "CLSHPayedBottomView.h"

@implementation CLSHPayedBottomView
#pragma mark -- 懒加载
- (UIButton *)leftButton{

    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_leftButton setTitle:@"配送" forState:(UIControlStateNormal)];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_leftButton setBackgroundColor:systemColor];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_leftButton addTarget:self action:@selector(delivery:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _leftButton;
}
- (UIButton *)rightButton{

    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_rightButton setTitle:@"取消订单" forState:(UIControlStateNormal)];
        [_rightButton setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_rightButton setBackgroundColor:[UIColor whiteColor]];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_rightButton addTarget:self action:@selector(cancelOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _rightButton;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    
    [self updateConstraints];
}

//配送
- (void)delivery:(UIButton *)sender{

    if (self.deliveryblock) {
        self.deliveryblock();
    }
}

//取消订单
- (void)cancelOrder:(UIButton *)sender{

    if (self.cancelOrderblock) {
        self.cancelOrderblock();
    }
}


- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.width.equalTo(@(SCREENWIDTH/2));
        make.height.equalTo(@(40*AppScale));
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_leftButton.mas_right).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.height.equalTo(@(40*AppScale));
        
    }];
}

@end
