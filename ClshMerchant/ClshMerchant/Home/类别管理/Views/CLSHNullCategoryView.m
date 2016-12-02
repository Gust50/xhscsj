//
//  CLSHNullCategoryView.m
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


#import "CLSHNullCategoryView.h"

@interface CLSHNullCategoryView ()
//@property (nonatomic, strong)UIImageView *icon;
//@property (nonatomic, strong)UILabel *describe;
//@property (nonatomic, strong)UIButton *addCategory;
@end
@implementation CLSHNullCategoryView

#pragma mark - lazyLoad
-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"NullCategory"];
    }
    return _icon;
}
-(UILabel *)describe
{
    if (!_describe) {
        _describe = [[UILabel alloc] init];
        _describe.text = @"这里空空如也";
        _describe.textColor = RGBColor(155, 154, 155);
        _describe.font = [UIFont systemFontOfSize:13*AppScale];
        _describe.textAlignment = NSTextAlignmentCenter;
    }
    return _describe;
}

-(UIButton *)addCategory
{
    if (!_addCategory) {
        _addCategory = [[UIButton alloc] init];
        _addCategory.backgroundColor = systemColor;
        _addCategory.layer.cornerRadius = 5.0;
        _addCategory.layer.masksToBounds = YES;
        [_addCategory setTitle:@"添加分类" forState:UIControlStateNormal];
        _addCategory.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_addCategory setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addCategory addTarget:self action:@selector(addcategoryManagement) forControlEvents:UIControlEventTouchUpInside];
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

-(void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.describe];
    [self addSubview:self.addCategory];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_addCategory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 40*AppScale));
    }];
    
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_addCategory.mas_top).offset(-20*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_describe.mas_top).offset(-10*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 70*AppScale));
    }];
}

//添加分类
- (void)addcategoryManagement
{
    if (self.addCategoryBlock) {
        self.addCategoryBlock();
    }
}

@end
