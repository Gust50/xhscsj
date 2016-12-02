//
//  CLSHOrderDetailHeadView.m
//  ClshUser
//
//  Created by arom on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHOrderDetailHeadView.h"

@implementation CLSHOrderDetailHeadView

- (UIImageView *)icon{

    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"专卖店"];
    }
    return _icon;
}

- (UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text =@"订单详情";
        _nameLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.icon];
    [self addSubview: self.nameLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(15*AppScale));
        
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(20*AppScale));
    }];
}


@end
