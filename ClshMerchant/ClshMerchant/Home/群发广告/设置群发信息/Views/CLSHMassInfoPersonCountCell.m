//
//  CLSHMassInfoPersonCountCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMassInfoPersonCountCell.h"
#import "CLSHAdManagerModel.h"

@interface CLSHMassInfoPersonCountCell ()
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *totalCount;
@property (nonatomic, strong)UILabel *totalLabel;
@property (nonatomic, strong)UILabel *topLine;
@property (nonatomic, strong)UILabel *oneMiddleLine;
@property (nonatomic, strong)UILabel *twoMiddleLine;
@property (nonatomic, strong)UILabel *bottomLine;
@property (nonatomic, strong)UILabel *manLabel;
@property (nonatomic, strong)UILabel *manCount;
@property (nonatomic, strong)UILabel *menLabel;
@property (nonatomic, strong)UILabel *menCount;
@property (nonatomic, strong)UILabel *otherLabel;
@property (nonatomic, strong)UILabel *otherCount;

@end

@implementation CLSHMassInfoPersonCountCell

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"SetupSendInfoCircle"];
    }
    return _icon;
}

- (UILabel *)totalCount
{
    if (!_totalCount) {
        _totalCount = [[UILabel alloc] init];
        _totalCount.textColor = [UIColor redColor];
        _totalCount.text = @"1680人";
        _totalCount.font = [UIFont systemFontOfSize:10*AppScale];
        _totalCount.textAlignment = NSTextAlignmentCenter;
    }
    return _totalCount;
}

-(UILabel *)totalLabel
{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.font = [UIFont systemFontOfSize:8*AppScale];
        _totalLabel.text = @"用户总人数";
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.textColor = RGBColor(154, 154, 154);
    }
    return _totalLabel;
}

-(UILabel *)topLine
{
    if (!_topLine) {
        _topLine = [[UILabel alloc] init];
        _topLine.backgroundColor = RGBColor(200, 199, 204);
    }
    return _topLine;
}

-(UILabel *)oneMiddleLine
{
    if (!_oneMiddleLine) {
        _oneMiddleLine = [[UILabel alloc] init];
        _oneMiddleLine.backgroundColor = RGBColor(200, 199, 204);
    }
    return _oneMiddleLine;
}

-(UILabel *)twoMiddleLine
{
    if (!_twoMiddleLine) {
        _twoMiddleLine = [[UILabel alloc] init];
        _twoMiddleLine.backgroundColor = RGBColor(200, 199, 204);
    }
    return _twoMiddleLine;
}

//-(UILabel *)bottomLine
//{
//    if (!_bottomLine) {
//        _bottomLine = [[UILabel alloc] init];
//        _bottomLine.backgroundColor = RGBColor(193, 193, 196);
//    }
//    return _bottomLine;
//}

-(UILabel *)manLabel
{
    if (!_manLabel) {
        _manLabel = [[UILabel alloc] init];
        _manLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _manLabel.text = @"男生";
        _manLabel.textAlignment = NSTextAlignmentCenter;
        _manLabel.textColor = RGBColor(154, 154, 154);
    }
    return _manLabel;
}

-(UILabel *)manCount
{
    if (!_manCount) {
        _manCount = [[UILabel alloc] init];
        _manCount.font = [UIFont systemFontOfSize:12*AppScale];
        _manCount.text = @"1000人";
        _manCount.textAlignment = NSTextAlignmentCenter;
        _manCount.textColor = [UIColor redColor];
    }
    return _manCount;
}

-(UILabel *)menLabel
{
    if (!_menLabel) {
        _menLabel = [[UILabel alloc] init];
        _menLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _menLabel.text = @"女生";
        _menLabel.textAlignment = NSTextAlignmentCenter;
        _menLabel.textColor = RGBColor(154, 154, 154);
    }
    return _menLabel;
}

-(UILabel *)menCount
{
    if (!_menCount) {
        _menCount = [[UILabel alloc] init];
        _menCount.font = [UIFont systemFontOfSize:12*AppScale];
        _menCount.text = @"1000人";
        _menCount.textAlignment = NSTextAlignmentCenter;
        _menCount.textColor = [UIColor redColor];
    }
    return _menCount;
}

-(UILabel *)otherLabel
{
    if (!_otherLabel) {
        _otherLabel = [[UILabel alloc] init];
        _otherLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _otherLabel.text = @"其他";
        _otherLabel.textAlignment = NSTextAlignmentCenter;
        _otherLabel.textColor = RGBColor(154, 154, 154);
    }
    return _otherLabel;
}

-(UILabel *)otherCount
{
    if (!_otherCount) {
        _otherCount = [[UILabel alloc] init];
        _otherCount.font = [UIFont systemFontOfSize:12*AppScale];
        _otherCount.text = @"1000人";
        _otherCount.textAlignment = NSTextAlignmentCenter;
        _otherCount.textColor = [UIColor redColor];
    }
    return _otherCount;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.totalLabel];
    [self addSubview:self.totalCount];
    [self addSubview:self.oneMiddleLine];
    [self addSubview:self.twoMiddleLine];
//    [self addSubview:self.bottomLine];
    [self addSubview:self.topLine];
    [self addSubview:self.manLabel];
    [self addSubview:self.manCount];
    [self addSubview:self.menLabel];
    [self addSubview:self.menCount];
    [self addSubview:self.otherLabel];
    [self addSubview:self.otherCount];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 80*AppScale));
        
    }];
    
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_icon.mas_bottom).offset(-3*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 15*AppScale));
    }];
    
    [_totalCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_totalLabel.mas_top).offset(3*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 15*AppScale));
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).offset(15*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(1));
    }];
    
//    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_topLine.mas_bottom).offset(51*AppScale);
//        make.left.equalTo(weakSelf.mas_left);
//        make.right.equalTo(weakSelf.mas_right);
//        make.height.mas_equalTo(@(1));
//    }];
    
    [_oneMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
        make.height.equalTo(@(51*AppScale));
        make.left.equalTo(weakSelf.mas_left).offset((SCREENWIDTH-2)/3);
        make.width.mas_equalTo(@(1));
    }];
    
    [_twoMiddleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom);
         make.height.equalTo(@(51*AppScale));
        make.left.equalTo(_oneMiddleLine.mas_right).offset((SCREENWIDTH-2)/3);
        make.width.mas_equalTo(@(1));
    }];
    
    [_manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom).offset(5*AppScale);
        make.right.equalTo(_oneMiddleLine.mas_left);
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_manCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_manLabel.mas_bottom);
        make.right.equalTo(_oneMiddleLine.mas_left);
        make.left.equalTo(weakSelf.mas_left);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_menLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom).offset(5*AppScale);
        make.left.equalTo(_oneMiddleLine.mas_right);
        make.right.equalTo(_twoMiddleLine.mas_left);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_menCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_menLabel.mas_bottom);
        make.left.equalTo(_oneMiddleLine.mas_right);
        make.right.equalTo(_twoMiddleLine.mas_left);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLine.mas_bottom).offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right);
        make.left.equalTo(_twoMiddleLine.mas_right);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_otherCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_otherLabel.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
        make.left.equalTo(_twoMiddleLine.mas_right);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setSelectUsersModel:(CLSHAddAdSelectUsersModel *)selectUsersModel
{
    _selectUsersModel = selectUsersModel;
    _totalCount.text = [NSString stringWithFormat:@"%zi人", selectUsersModel.totalCount];
    _manCount.text = [NSString stringWithFormat:@"%zi人", selectUsersModel.male];
    _menCount.text = [NSString stringWithFormat:@"%zi人", selectUsersModel.female];
    _otherCount.text = [NSString stringWithFormat:@"%zi", selectUsersModel.notMaleNotFemale];
}

@end
