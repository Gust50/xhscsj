//
//  CLSHAddressTableViewCell.m
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


#import "CLSHAddressTableViewCell.h"

@implementation CLSHAddressTableViewCell

#pragma mark -- 懒加载
- (UILabel *)recieveName{

    if (!_recieveName) {
        _recieveName = [[UILabel alloc] init];
        _recieveName.text = @"马云";
        _recieveName.textColor = RGBColor(51, 51, 51);
        _recieveName.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _recieveName;
}

- (UILabel *)phoneNum{

    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc] init];
        _phoneNum.text = @"13422335889";
        _phoneNum.textColor = RGBColor(51, 51, 51);
        _phoneNum.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _phoneNum;
}

- (UILabel *)address{

    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.text = @"广东省深圳市龙岗区天安数码城3栋B座1406";
        _address.textColor = RGBColor(153, 153, 153);
        _address.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _address;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.recieveName];
    [self addSubview:self.phoneNum];
    [self addSubview:self.address];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_recieveName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(35*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(60*AppScale));
    }];
    
    [_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recieveName.mas_right).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(35*AppScale);
        make.top.equalTo(_recieveName.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.right.equalTo(weakSelf.mas_right).with.offset(-8*AppScale);
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
