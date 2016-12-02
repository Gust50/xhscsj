//
//  CLSHDeliveryBottomView.m
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


#import "CLSHDeliveryBottomView.h"

@implementation CLSHDeliveryBottomView

#pragma mark -- 懒加载
- (UIButton *)leftButton{
    
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_leftButton setTitle:@"审核" forState:(UIControlStateNormal)];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_leftButton setBackgroundColor:systemColor];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_leftButton addTarget:self action:@selector(applyFeedBack:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _leftButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.leftButton];
    
    [self updateConstraints];
}

- (void)applyFeedBack:(UIButton *)sender{

    if (self.applyFeedBackblock) {
        self.applyFeedBackblock();
    }
}

- (void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.width.equalTo(@(SCREENWIDTH));
        make.height.equalTo(@(40*AppScale));
    }];
   
}


@end
