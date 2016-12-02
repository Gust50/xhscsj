//
//  CLSHUpLoadPropertyFooter.m
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHUpLoadPropertyFooter.h"


@interface CLSHUpLoadPropertyFooter ()
@property (nonatomic, strong) UIImageView *icon;
@end

@implementation CLSHUpLoadPropertyFooter

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image=[UIImage imageNamed:@"addProperty"];
        _icon.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addProperty:)];
        [_icon addGestureRecognizer:tap];
    }
    return _icon;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18*AppScale, 18*AppScale));
    }];
    
}

#pragma mark <otherResponse>
-(void)addProperty:(UIGestureRecognizer *)gesture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addProperty)]) {
        [self.delegate addProperty];
    }
}

@end
