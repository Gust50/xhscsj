//
//  CLSHSelectDiscountCell.m
//  ClshMerchant
//
//  Created by arom on 16/9/13.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSelectDiscountCell.h"

@interface CLSHSelectDiscountCell() {

}

@end

@implementation CLSHSelectDiscountCell

#pragma mark -- 懒加载
- (UILabel *)leftLabel{

    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"绑定折扣:";
        _leftLabel.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _leftLabel;
}

- (UIButton *)selectBtn{

    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectBtn setTitle:@"选择折扣" forState:(UIControlStateNormal)];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
        _selectBtn.layer.masksToBounds = YES;
        _selectBtn.layer.cornerRadius = 0;
        _selectBtn.layer.borderColor = RGBColor(153, 153, 153).CGColor;
        [_selectBtn setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
        _selectBtn.layer.borderWidth = 1;
        _selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [_selectBtn addTarget:self action:@selector(selectDiscount) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _selectBtn;
}

- (UIImageView *)arrowIcon{

    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc] init];
        _arrowIcon.image = [UIImage imageNamed:@"arrow_t"];
    }
    return _arrowIcon;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.leftLabel];
    [self addSubview:self.selectBtn];
    [_selectBtn addSubview:self.arrowIcon];
    
    [self updateConstraints];
}

- (void)selectDiscount{

    if (self.Discountblock) {
        self.Discountblock();
    }
    
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 20*AppScale));
    }];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right).with.offset(0*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(20*AppScale));
        make.width.equalTo(@(150*AppScale));
    }];
    
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_selectBtn.mas_top).with.offset(5*AppScale);
        make.bottom.equalTo(_selectBtn.mas_bottom).with.offset(-5*AppScale);
        make.right.equalTo(_selectBtn.mas_right).with.offset(-3*AppScale);
        make.width.equalTo(@(16*AppScale));
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
