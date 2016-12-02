//
//  CLSHManagerMoneyHeadViewCell.m
//  ClshMerchant
//
//  Created by arom on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHManagerMoneyHeadViewCell.h"

@implementation CLSHManagerMoneyHeadViewCell

#pragma mark -- 懒加载
- (UILabel *)unCaculatorMoneyLabel{

    if (!_unCaculatorMoneyLabel) {
        _unCaculatorMoneyLabel  = [[UILabel alloc] init];
        _unCaculatorMoneyLabel.text = @"未结算金额";
        _unCaculatorMoneyLabel.textColor = RGBColor(51, 51, 51);
        _unCaculatorMoneyLabel.font = [UIFont systemFontOfSize:15*AppScale];
        _unCaculatorMoneyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _unCaculatorMoneyLabel;
}

- (UIButton *)detailIncomeBtn{

    if (!_detailIncomeBtn) {
        _detailIncomeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_detailIncomeBtn setTitle:@"收入明细>>" forState:(UIControlStateNormal)];
        [_detailIncomeBtn setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
        _detailIncomeBtn.titleLabel.font = [UIFont systemFontOfSize:15*AppScale];
        [_detailIncomeBtn addTarget:self action:@selector(detailIncomeAndPay) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _detailIncomeBtn;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.unCaculatorMoneyLabel];
    [self addSubview:self.detailIncomeBtn];
    
    [self updateConstraints];
}

- (void)detailIncomeAndPay{

    if (self.detailIncomeblock) {
        self.detailIncomeblock();
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_unCaculatorMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(25*AppScale));
    }];
    
    [_detailIncomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(100*AppScale));
    }];
}

@end
