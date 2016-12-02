//
//  CLSHHomePublishHeader.m
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


#import "CLSHHomePublishHeader.h"

@interface CLSHHomePublishHeader ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation CLSHHomePublishHeader

-(UIButton *)btn{
    if (!_btn) {
        _btn=[UIButton buttonWithType:0];
        [_btn setTitle:@"发布商品" forState:0];
        [_btn setTitleColor:systemColor forState:0];
        [_btn addTarget:self action:@selector(upLoadNewGoods:) forControlEvents:UIControlEventTouchUpInside];
        [_btn setImage:[UIImage imageNamed:@"PublishProduct"] forState:0];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10*AppScale, 0, 0);
    }
    return _btn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.btn];
    [self updateConstraints];
}
-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 30*AppScale));
    }];
}


#pragma mark <otherResponse>
-(void)upLoadNewGoods:(UIButton *)btn{
    if (self.deleagete && [self.deleagete respondsToSelector:@selector(upLoadNewGoods)]) {
        [self.deleagete upLoadNewGoods];
    }
}
@end
