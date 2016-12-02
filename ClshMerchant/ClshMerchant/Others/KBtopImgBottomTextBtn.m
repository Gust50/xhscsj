//
//  KBtopImgBottomTextBtn.m
//  ClshMerchant
//
//  Created by kobe on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBtopImgBottomTextBtn.h"

@interface KBtopImgBottomTextBtn ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@end

@implementation KBtopImgBottomTextBtn

#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
    }
    return _icon;
}

-(UILabel *)name{
    if (!_name) {
        _name=[UILabel new];
        _name.textAlignment=NSTextAlignmentCenter;
    }
    return _name;
}

#pragma mark <initWithFrame>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView:)];
        [self addGestureRecognizer:tap];
        
        [self initUI];
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
        make.top.equalTo(weakSelf.mas_top);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(8);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}


#pragma mark <otherResponse>
-(void)clickView:(UITapGestureRecognizer *)gesture{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickKBtopImgBottomTextBtn:)]) {
        [self.delegate clickKBtopImgBottomTextBtn:_nameContent];
    }
}

#pragma mark <getter setter>
-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl=iconUrl;
    _icon.image=[UIImage imageNamed:iconUrl];
}

-(void)setNameContent:(NSString *)nameContent{
    _nameContent=nameContent;
    _name.text=nameContent;
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor=textColor;
    _name.textColor=textColor;
}

-(void)setTextFont:(UIFont *)textFont{
    _textFont=textFont;
    _name.font=textFont;
}
@end
