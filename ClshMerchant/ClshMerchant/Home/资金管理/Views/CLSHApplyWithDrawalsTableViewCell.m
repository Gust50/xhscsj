//
//  CLSHApplyWithDrawalsTableViewCell.m
//  ClshMerchant
//
//  Created by arom on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHApplyWithDrawalsTableViewCell.h"

@implementation CLSHApplyWithDrawalsTableViewCell

#pragma mark -- 懒加载
- (UILabel *)normalLabel{

    if (!_normalLabel) {
        _normalLabel = [[UILabel alloc] init];
        _normalLabel.text=@"余额账户";
        _normalLabel.textColor = [UIColor whiteColor];
        _normalLabel.font = [UIFont systemFontOfSize:15*AppScale];
    }
    return _normalLabel;
}

- (UIButton *)moneyDetailBtn{

    if (!_moneyDetailBtn) {
        _moneyDetailBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_moneyDetailBtn setTitle:@"资金明细>>" forState:(UIControlStateNormal)];
        [_moneyDetailBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _moneyDetailBtn.titleLabel.font = [UIFont systemFontOfSize:15*AppScale];
        [_moneyDetailBtn addTarget:self action:@selector(moneyDetail) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _moneyDetailBtn;
}

- (UILabel *)activeMoneyLabel{

    if (!_activeMoneyLabel) {
        _activeMoneyLabel = [[UILabel alloc] init];
        _activeMoneyLabel.text = @"￥88888.22";
        _activeMoneyLabel.textColor = [UIColor whiteColor];
        _activeMoneyLabel.font = [UIFont boldSystemFontOfSize:18*AppScale];
    }
    return _activeMoneyLabel;
}

- (UILabel *)unActiveMoneyLabel{

    if (!_unActiveMoneyLabel) {
        _unActiveMoneyLabel = [[UILabel alloc] init];
        _unActiveMoneyLabel.text = @"冻结金额:￥500.00";
        _unActiveMoneyLabel.textColor = [UIColor whiteColor];
        _unActiveMoneyLabel.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _unActiveMoneyLabel;
}

- (UIButton *)applyDrawalsBtn{

    if (!_applyDrawalsBtn) {
        _applyDrawalsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_applyDrawalsBtn setTitle:@"申请提现" forState:(UIControlStateNormal)];
        _applyDrawalsBtn.titleLabel.font =[UIFont systemFontOfSize:14*AppScale];
        [_applyDrawalsBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _applyDrawalsBtn.layer.masksToBounds = YES;
        _applyDrawalsBtn.layer.cornerRadius = 5;
        _applyDrawalsBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _applyDrawalsBtn.layer.borderWidth = 1;
        [_applyDrawalsBtn addTarget:self action:@selector(applyDrawals:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _applyDrawalsBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = RGBColor(42, 167, 84);
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.normalLabel];
    [self addSubview:self.moneyDetailBtn];
    [self addSubview:self.activeMoneyLabel];
    [self addSubview:self.unActiveMoneyLabel];
    [self addSubview:self.applyDrawalsBtn];
    
    [self updateConstraints];
}

- (void)applyDrawals:(UIButton *)sender{

    if (self.applyDrawalsblock) {
        self.applyDrawalsblock();
    }
}

- (void)moneyDetail{

    if (self.moneyDetailblock) {
        self.moneyDetailblock();
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_normalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(15*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
        
    }];
    
    [_moneyDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(15*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
    
    [_activeMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.equalTo(@(20*AppScale));
        make.top.equalTo(_normalLabel.mas_bottom).with.offset(15* AppScale);
    }];
    
    [_unActiveMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_activeMoneyLabel.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
    
    [_applyDrawalsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(25*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-25*AppScale);
        make.top.equalTo(_unActiveMoneyLabel.mas_bottom).with.offset(20*AppScale);
        make.height.equalTo(@(40*AppScale));
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
