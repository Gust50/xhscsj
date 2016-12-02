//
//  CLSHHomeBottomViewCell.m
//  ClshMerchant
//
//  Created by kobe on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHHomeBottomViewCell.h"

@interface CLSHHomeBottomViewCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@end

@implementation CLSHHomeBottomViewCell

-(UILabel *)name{
    if (!_name) {
        _name=[UILabel new];
        _name.font=[UIFont systemFontOfSize:12*AppScale];
        _name.textAlignment=NSTextAlignmentCenter;
    }
    return _name;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
    }
    return _icon;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake(50*AppScale, 40*AppScale));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_icon.mas_bottom).with.offset(10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
    }];
    
}

-(void)setIconText:(NSString *)iconText{
    _iconText=iconText;
    _icon.image=[UIImage imageNamed:iconText];
}

-(void)setNameText:(NSString *)nameText{
    _nameText=nameText;
    _name.text=nameText;
}
@end
