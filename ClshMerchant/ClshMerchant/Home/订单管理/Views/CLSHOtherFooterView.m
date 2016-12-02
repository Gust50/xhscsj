//
//  CLSHOtherFooterView.m
//  ClshMerchant
//
//  Created by arom on 16/8/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHOtherFooterView.h"
#import "CLSHOrderManageModel.h"


@implementation CLSHOtherFooterView

#pragma mark --懒加载
- (UILabel *)sortMoneyLabel{
    
    if (!_sortMoneyLabel) {
        _sortMoneyLabel = [[UILabel alloc] init];
        _sortMoneyLabel.text = @"总金额：";
        _sortMoneyLabel.textColor = RGBColor(51, 51, 51);
        _sortMoneyLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _sortMoneyLabel;
}

- (UILabel *)moneyLabel{
    
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = @"￥864.00";
        _moneyLabel.textColor = RGBColor(241, 72, 36);
        _moneyLabel.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _moneyLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -- initUI
- (void)initUI{
    
    [self addSubview:self.sortMoneyLabel];
    [self addSubview:self.moneyLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    
    [_sortMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(8*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20));
        make.width.equalTo(@(55*AppScale));
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_sortMoneyLabel.mas_right).with.offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@(100*AppScale));
    }];
}

- (void)setModel:(CLSHOderListModel *)model{
    
    _model = model;
    _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f",model.orderAmount];
}

@end
