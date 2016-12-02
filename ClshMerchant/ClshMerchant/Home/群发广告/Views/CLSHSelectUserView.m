//
//  CLSHSelectUserView.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/2.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSelectUserView.h"
#import "CLSHAdManagerModel.h"

@interface CLSHSelectUserView()

@property (nonatomic, strong)UILabel *totalCount;
@property (nonatomic, strong)UIImageView *manIcon;
@property (nonatomic, strong)UILabel *manCount;
@property (nonatomic, strong)UILabel *manSex;

@property (nonatomic, strong)UIImageView *menIcon;
@property (nonatomic, strong)UILabel *menCount;
@property (nonatomic, strong)UILabel *menSex;

@property (nonatomic, strong)UIImageView *otherIcon;
@property (nonatomic, strong)UILabel *otherCount;
@property (nonatomic, strong)UILabel *otherSex;
@property (nonatomic, strong)UILabel *bottomLine;

@end
@implementation CLSHSelectUserView

-(UILabel *)totalCount
{
    if (!_totalCount) {
        _totalCount = [[UILabel alloc] init];
        _totalCount.textAlignment = NSTextAlignmentCenter;
        _totalCount.font = [UIFont systemFontOfSize:14*AppScale];
        _totalCount.text = @"筛选结果总计：2368人";
    }
    return _totalCount;
}

-(UIImageView *)manIcon
{
    if (!_manIcon) {
        _manIcon = [[UIImageView alloc] init];
        _manIcon.image = [UIImage imageNamed:@"SelectManCircle"];
//        _manIcon.layer.cornerRadius = (SCREENWIDTH-90*AppScale)/6;
//        _manIcon.layer.masksToBounds = YES;
    }
    return _manIcon;
}

- (UILabel *)manCount
{
    if (!_manCount) {
        _manCount = [[UILabel alloc] init];
        _manCount.textColor = RGBColor(90, 198, 218);
        _manCount.text = @"1680人";
        _manCount.font = [UIFont systemFontOfSize:10*AppScale];
        _manCount.textAlignment = NSTextAlignmentCenter;
    }
    return _manCount;
}

-(UILabel *)manSex
{
    if (!_manSex) {
        _manSex = [[UILabel alloc] init];
        _manSex.font = [UIFont systemFontOfSize:8*AppScale];
        _manSex.text = @"男人";
        _manSex.textAlignment = NSTextAlignmentCenter;
        _manSex.textColor = RGBColor(90, 198, 218);
        
    }
    return _manSex;
}

-(UIImageView *)menIcon
{
    if (!_menIcon) {
        _menIcon = [[UIImageView alloc] init];
        _menIcon.image = [UIImage imageNamed:@"SelectWomenCircle"];
//        _menIcon.layer.cornerRadius = (SCREENWIDTH-90*AppScale)/6;
//        _menIcon.layer.masksToBounds = YES;
    }
    return _menIcon;
}

- (UILabel *)menCount
{
    if (!_menCount) {
        _menCount = [[UILabel alloc] init];
        _menCount.textColor = RGBColor(255, 94, 161);
        _menCount.text = @"1680人";
        _menCount.font = [UIFont systemFontOfSize:10*AppScale];
        _menCount.textAlignment = NSTextAlignmentCenter;
    }
    return _menCount;
}

-(UILabel *)menSex
{
    if (!_menSex) {
        _menSex = [[UILabel alloc] init];
        _menSex.font = [UIFont systemFontOfSize:8*AppScale];
        _menSex.text = @"女人";
        _menSex.textAlignment = NSTextAlignmentCenter;
        _menSex.textColor = RGBColor(255, 94, 161);
    }
    return _menSex;
}

-(UIImageView *)otherIcon
{
    if (!_otherIcon) {
        _otherIcon = [[UIImageView alloc] init];
        _otherIcon.image = [UIImage imageNamed:@"SelectOtherCircle"];
//        _otherIcon.layer.cornerRadius = (SCREENWIDTH-90*AppScale)/6;
//        _otherIcon.layer.masksToBounds = YES;
    }
    return _otherIcon;
}

- (UILabel *)otherCount
{
    if (!_otherCount) {
        _otherCount = [[UILabel alloc] init];
        _otherCount.textColor = RGBColor(253, 124, 255);
        _otherCount.text = @"1680人";
        _otherCount.font = [UIFont systemFontOfSize:10*AppScale];
        _otherCount.textAlignment = NSTextAlignmentCenter;
    }
    return _otherCount;
}

-(UILabel *)otherSex
{
    if (!_otherSex) {
        _otherSex = [[UILabel alloc] init];
        _otherSex.font = [UIFont systemFontOfSize:8*AppScale];
        _otherSex.text = @"其他";
        _otherSex.textAlignment = NSTextAlignmentCenter;
        _otherSex.textColor = RGBColor(253, 124, 255);
    }
    return _otherSex;
}

-(UILabel *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = RGBColor(231, 231, 231);
    }
    return _bottomLine;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.totalCount];
    [self addSubview:self.manIcon];
    [self addSubview:self.manCount];
    [self addSubview:self.manSex];
    [self addSubview:self.menIcon];
    [self addSubview:self.menCount];
    [self addSubview:self.menSex];
    [self addSubview:self.otherIcon];
    [self addSubview:self.otherCount];
    [self addSubview:self.otherSex];
    [self addSubview:self.bottomLine];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_totalCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(20*AppScale);
    }];
    
    [_manIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalCount.mas_bottom).offset(15*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, (SCREENWIDTH-100*AppScale)/3));
    }];
    
    [_manSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_manIcon.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, 15*AppScale));
    }];
    
    [_manCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_manSex.mas_top).offset(3*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, 15*AppScale));
    }];
    
    [_menIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalCount.mas_bottom).offset(15*AppScale);
        make.left.equalTo(_manIcon.mas_right).offset(30*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, (SCREENWIDTH-100*AppScale)/3));
    }];
    
    [_menSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_menIcon.mas_bottom);
        make.left.equalTo(_manIcon.mas_right).offset(30*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, 15*AppScale));
    }];
    
    [_menCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_menSex.mas_top).offset(3*AppScale);
        make.left.equalTo(_manIcon.mas_right).offset(30*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, 15*AppScale));
    }];
    
    [_otherIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalCount.mas_bottom).offset(15*AppScale);
        make.left.equalTo(_menIcon.mas_right).offset(30*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, (SCREENWIDTH-100*AppScale)/3));
    }];
    
    [_otherSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_otherIcon.mas_bottom);
        make.left.equalTo(_menIcon.mas_right).offset(30*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, 15*AppScale));
    }];
    
    [_otherCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_otherSex.mas_top).offset(3*AppScale);
        make.left.equalTo(_menIcon.mas_right).offset(30*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/3, 15*AppScale));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(1));
    }];
}

#pragma mark - setter getter
-(void)setSelectUsersModel:(CLSHAddAdSelectUsersModel *)selectUsersModel
{
    _selectUsersModel = selectUsersModel;
    _totalCount.text = [NSString stringWithFormat:@"筛选结果总计：%zi人", selectUsersModel.totalCount];
    _manCount.text = [NSString stringWithFormat:@"%zi人", selectUsersModel.male];
    _menCount.text = [NSString stringWithFormat:@"%zi人", selectUsersModel.female];
    _otherCount.text = [NSString stringWithFormat:@"%zi人", selectUsersModel.notMaleNotFemale];
}

@end
