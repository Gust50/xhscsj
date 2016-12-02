//
//  CLSHManagerMoneyFooterView.m
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


#import "CLSHManagerMoneyFooterView.h"

@implementation CLSHManagerMoneyFooterView

#pragma mark -- 懒加载
- (UILabel *)describeLabel{

    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.text = @"*累计时间超过30天将自动结算并转入余额账户";
        _describeLabel.textColor = RGBColor(102, 102, 102);
        _describeLabel.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _describeLabel;
}

- (UIButton *)immediatelyBalanceBtn{

    if (!_immediatelyBalanceBtn) {
        _immediatelyBalanceBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_immediatelyBalanceBtn setTitle:@"立即结算" forState:(UIControlStateNormal)];
        [_immediatelyBalanceBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _immediatelyBalanceBtn.titleLabel.font = [UIFont systemFontOfSize:15*AppScale];
        [_immediatelyBalanceBtn setBackgroundColor:systemColor];
        _immediatelyBalanceBtn.layer.masksToBounds = YES;
        _immediatelyBalanceBtn.layer.cornerRadius = 5*AppScale;
        [_immediatelyBalanceBtn addTarget:self action:@selector(Clicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _immediatelyBalanceBtn;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.describeLabel];
    [self addSubview:self.immediatelyBalanceBtn];
    
    [self updateConstraints];
}

- (void)Clicked{

    if (self.goImmediatelySettleVCblock) {
        self.goImmediatelySettleVCblock();
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.equalTo(@(20*AppScale));
        make.bottom.equalTo(_immediatelyBalanceBtn.mas_top).with.offset(-10*AppScale);
    }];
    
    [_immediatelyBalanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.equalTo(@(40*AppScale));
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-20*AppScale);
    }];
}



@end
