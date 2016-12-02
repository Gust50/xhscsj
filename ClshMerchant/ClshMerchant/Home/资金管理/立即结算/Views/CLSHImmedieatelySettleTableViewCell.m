//
//  CLSHImmedieatelySettleTableViewCell.m
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


#import "CLSHImmedieatelySettleTableViewCell.h"
#import "CLSHMoneyManagerModel.h"

@implementation CLSHImmedieatelySettleTableViewCell

#pragma mark -- 懒加载
- (UIImageView *)selectIcon{

    if (!_selectIcon) {
        _selectIcon = [[UIImageView alloc] init];
        [_selectIcon setImage:[UIImage imageNamed:@"sele_normal"]];
        [_selectIcon setHighlightedImage:[UIImage imageNamed:@"sele_sel"]];
    }
    return _selectIcon;
}

- (UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2016-08-26";
        _timeLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _timeLabel.textColor = RGBColor(51, 51, 51);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UILabel *)sortLabel{

    if (!_sortLabel) {
        _sortLabel = [[UILabel alloc] init];
        _sortLabel.text = @"1天";
        _sortLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _sortLabel.textColor = RGBColor(51, 51, 51);
        _sortLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sortLabel;
}

- (UILabel *)sumMoneyLabel{

    if (!_sumMoneyLabel) {
        _sumMoneyLabel = [[UILabel alloc] init];
        _sumMoneyLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _sumMoneyLabel.text = @"2453.00";
        _sumMoneyLabel.textColor = RGBColor(51, 51, 51);
        _sumMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sumMoneyLabel;
}

- (UILabel *)predictLabel{

    if (!_predictLabel) {
        _predictLabel = [[UILabel alloc] init];
        _predictLabel.text = @"32542.00";
        _predictLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _predictLabel.textColor = RGBColor(51, 51, 51);
        _predictLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _predictLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.selectIcon];
    [self addSubview:self.timeLabel];
    [self addSubview:self.sortLabel];
    [self addSubview:self.sumMoneyLabel];
    [self addSubview:self.predictLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(15*AppScale));
        make.width.equalTo(@(15*AppScale));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectIcon.mas_right).with.offset(0*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(90*AppScale));
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
        make.width.equalTo(@(80*AppScale));
    }];
    
    [_predictLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sumMoneyLabel.mas_right).with.offset(0*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(100*AppScale));
    }];
}

- (void)setModel:(CLSHSettleBalanceListModel *)model{

    _model = model;
    self.timeLabel.text = model.date;
    self.sortLabel.text = model.daycount;
    self.sumMoneyLabel.text =[NSString stringWithFormat:@"%.2f",model.amount];
    self.predictLabel.text = [NSString stringWithFormat:@"%.2f",model.calAmount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _selectIcon.highlighted = selected;
}

@end
