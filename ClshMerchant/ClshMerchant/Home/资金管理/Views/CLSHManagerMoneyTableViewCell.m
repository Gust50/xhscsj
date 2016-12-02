//
//  CLSHManagerMoneyTableViewCell.m
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


#import "CLSHManagerMoneyTableViewCell.h"

@implementation CLSHManagerMoneyTableViewCell

#pragma  mark -- 懒加载
- (UILabel *)sumTimeLabel{

    if (!_sumTimeLabel) {
        _sumTimeLabel = [[UILabel alloc] init];
        _sumTimeLabel.text = @"累计时间";
        _sumTimeLabel.textColor = RGBColor(102, 102, 102);
        _sumTimeLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _sumMoneyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sumTimeLabel;
}

- (UILabel *)sumMoneyLabel{

    if (!_sumMoneyLabel) {
        _sumMoneyLabel = [[UILabel alloc] init];
        _sumMoneyLabel.text = @"累计金额";
        _sumMoneyLabel.textColor = RGBColor(102, 102, 102);
        _sumMoneyLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _sumMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _sumMoneyLabel;
}

- (UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = RGBColor(51, 51, 51);
        _timeLabel.font = [UIFont systemFontOfSize:16*AppScale];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UILabel *)moneyLabel{

    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = RGBColor(51, 51, 51);
        _moneyLabel.font = [UIFont systemFontOfSize:17*AppScale];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.text = @"￥2544.23";
    }
    return _moneyLabel;
}

- (UIButton *)rewardBtn{

    if (!_rewardBtn) {
        _rewardBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_rewardBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _rewardBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        
    }
    return _rewardBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.timeLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.sumTimeLabel];
    [self addSubview:self.sumMoneyLabel];
    [self addSubview:self.rewardBtn];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_sumTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
    
    [_sumMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(_sumTimeLabel.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
    
    [_rewardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_timeLabel.mas_right).with.offset(10*AppScale);
        make.top.equalTo(_sumTimeLabel.mas_bottom).with.offset(5*AppScale);
        make.height.equalTo(@(18*AppScale));
        make.width.equalTo(@(60*AppScale));
    }];
    
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.top.equalTo(_sumMoneyLabel.mas_bottom).with.offset(10*AppScale);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
