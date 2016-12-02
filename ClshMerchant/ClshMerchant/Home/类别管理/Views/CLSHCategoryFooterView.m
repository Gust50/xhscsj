//
//  CLSHCategoryFooterView.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHCategoryFooterView.h"

@interface CLSHCategoryFooterView ()

@end
@implementation CLSHCategoryFooterView

-(UIButton *)addCategory
{
    if (!_addCategory) {
        _addCategory = [[UIButton alloc] init];
        _addCategory.backgroundColor = systemColor;
        _addCategory.layer.cornerRadius = 5.0;
        _addCategory.layer.masksToBounds = YES;
        [_addCategory setTitle:@"添加类别" forState:UIControlStateNormal];
        [_addCategory setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addCategory.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_addCategory addTarget:self action:@selector(addCategoryManagement) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCategory;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.addCategory];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_addCategory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(30*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(40*AppScale));
    }];
}

//添加类别管理
- (void)addCategoryManagement
{
    if (self.addCategoryBlock) {
        self.addCategoryBlock();
    }
}

@end
