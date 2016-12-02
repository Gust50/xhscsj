//
//  CLSHImmediatelySettleHeadView.m
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


#import "CLSHImmediatelySettleHeadView.h"

@implementation CLSHImmediatelySettleHeadView

#pragma mark -- 懒加载
- (UILabel *)selectLabel{

    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.text = @"选择";
        _selectLabel.textColor = RGBColor(51, 51, 51);
        _selectLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _selectLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _selectLabel;
}

- (UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"日期  ";
        _timeLabel.textColor = RGBColor(51, 51, 51);
        _timeLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UILabel *)sortLabel{

    if (!_sortLabel) {
        _sortLabel = [[UILabel alloc] init];
         _sortLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _sortLabel.text = @"累计";
        _sortLabel.textColor = RGBColor(51, 51, 51);
        _sortLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sortLabel;
}

- (UILabel *)sumMoneyLabel{

    if (!_sumMoneyLabel) {
        
        _sumMoneyLabel = [[UILabel alloc] init];
         _sumMoneyLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _sumMoneyLabel.text = @"金额(元)";
        _sumMoneyLabel.textColor = RGBColor(51, 51, 51);
        _sumMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sumMoneyLabel;
}

- (UILabel *)predictMoneyLabel{

    if (!_predictMoneyLabel) {
        _predictMoneyLabel = [[UILabel alloc] init];
        _predictMoneyLabel.text = @"预算结算(元)";
        _predictMoneyLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _predictMoneyLabel.textColor = RGBColor(51, 51, 51);
        _predictMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _predictMoneyLabel;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.selectLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.sortLabel];
    [self addSubview:self.sumMoneyLabel];
    [self addSubview:self.predictMoneyLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(30*AppScale));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectLabel.mas_right).with.offset(0*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(80*AppScale));
    }];
    
    [_sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_right).with.offset(0*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(30*AppScale));
    }];
    
    [_sumMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sortLabel.mas_right).with.offset(0*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(70*AppScale));
    }];
    
    [_predictMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sumMoneyLabel.mas_right).with.offset(0*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(100*AppScale));
    }];

}

@end
