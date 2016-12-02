//
//  CLSHNonOrderView.m
//  ClshMerchant
//
//  Created by arom on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHNonOrderView.h"

@implementation CLSHNonOrderView

#pragma mark --懒加载
- (UIView *)contentView{

    if (!_contentView) {
        _contentView  = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView *)nonOrderImageView{

    if (!_nonOrderImageView) {
        _nonOrderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NullOrderIcon"]];
        
    }
    return _nonOrderImageView;
}

- (UILabel *)nonOrderLabel{

    if (!_nonOrderLabel) {
        _nonOrderLabel = [[UILabel alloc] init];
        _nonOrderLabel.text = @"这里空空如也";
        _nonOrderLabel.textAlignment = NSTextAlignmentCenter;
        _nonOrderLabel.textColor = RGBColor(153, 153, 153);
        _nonOrderLabel.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _nonOrderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.contentView];
    [_contentView addSubview:self.nonOrderImageView];
    [_contentView addSubview:self.nonOrderLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(@(250*AppScale));
        make.width.equalTo(@(SCREENWIDTH));
    }];
    [_nonOrderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView.mas_centerX);
        make.top.equalTo(_contentView.mas_top).with.offset(40*AppScale);
        make.width.equalTo(@(90*AppScale));
        make.height.equalTo(@(90*AppScale));
    }];
    
    [_nonOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_contentView.mas_centerX);
        make.top.equalTo(_nonOrderImageView.mas_bottom).with.offset(15*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(90*AppScale));
    }];
}

@end
