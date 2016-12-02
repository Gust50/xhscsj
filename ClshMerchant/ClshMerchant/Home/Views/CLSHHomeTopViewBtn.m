//
//  CLSHHomeTopViewBtn.m
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


#import "CLSHHomeTopViewBtn.h"

@interface CLSHHomeTopViewBtn()
@property (nonatomic, strong) UILabel        *title;        ///<标题
@property (nonatomic, strong) UIImageView    *icon;         ///<图标
@property (nonatomic, strong) UILabel        *describe;     ///<描述
@end

@implementation CLSHHomeTopViewBtn

-(UILabel *)title{
    if (!_title) {
        _title=[UILabel new];
        _title.textAlignment=NSTextAlignmentCenter;
        _title.font=[UIFont systemFontOfSize:13*AppScale];
    }
    return _title;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
    }
    return _icon;
}

-(UILabel *)describe{
    if (!_describe) {
        _describe=[UILabel new];
        _describe.textAlignment=NSTextAlignmentLeft;
        _describe.font=[UIFont systemFontOfSize:10*AppScale];
        _describe.textColor = RGBColor(135, 135, 135);
        
    }
    return _describe;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.title];
    [self addSubview:self.icon];
    [self addSubview:self.describe];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(5*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX).with.offset(-25*AppScale);
        make.top.equalTo(_title.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(20*AppScale, 16*AppScale));
    }];
    
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom);
        make.height.mas_equalTo(@(20*AppScale));
        make.left.equalTo(weakSelf.mas_centerX).with.offset(-10*AppScale);
        
    }];
}


#pragma mark <setter getter>
-(void)setTitleText:(NSString *)titleText{
    _titleText=titleText;
    _title.text=titleText;
    [NSString labelString:_title font:[UIFont systemFontOfSize:10*AppScale] range:NSMakeRange(_title.text.length-1, 1) color:RGBColor(81, 81, 81)];
}
-(void)setDescribeText:(NSString *)describeText{
    _describeText=describeText;
    _describe.text=describeText;
}
-(void)setIconText:(NSString *)iconText{
    _iconText=iconText;
    _icon.image=[UIImage imageNamed:iconText];
}
@end
