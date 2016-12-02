//
//  CLSHMyBankFooterView.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMyBankFooterView.h"

@implementation CLSHMyBankFooterView

-(UIButton *)addBankCart
{
    if (!_addBankCart) {
        _addBankCart = [[UIButton alloc] init];
        _addBankCart.backgroundColor = systemColor;
        _addBankCart.layer.cornerRadius = 5*AppScale;
        _addBankCart.layer.masksToBounds = YES;
        _addBankCart.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_addBankCart setTitle:@"添加" forState:UIControlStateNormal];
        [_addBankCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addBankCart addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBankCart;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        [self initUI];
        
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.addBankCart];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_addBankCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(30*AppScale);
        make.height.mas_equalTo(40*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
    }];
}

- (void)add
{
    if (self.addBankCartBlock) {
        self.addBankCartBlock();
    }
}

@end
