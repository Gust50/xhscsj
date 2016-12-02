//
//  CLSHDataVisitorCell.m
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


#import "CLSHDataVisitorCell.h"

@implementation CLSHDataVisitorCell

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"今日访客量";
        _name.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _name;
}

-(UILabel *)countUV
{
    if (!_countUV) {
        _countUV = [[UILabel alloc] init];
        _countUV.text = @"87";
        _countUV.font = [UIFont systemFontOfSize:18*AppScale];
        _countUV.textColor = [UIColor redColor];
        _countUV.textAlignment = NSTextAlignmentCenter;
    }
    return _countUV;
}

-(UILabel *)totalUV
{
    if (!_totalUV) {
        _totalUV = [[UILabel alloc] init];
        _totalUV.text = @"访客(UV)";
        _totalUV.font = [UIFont systemFontOfSize:12*AppScale];
        _totalUV.textColor = RGBColor(161, 161, 161);
        _totalUV.textAlignment = NSTextAlignmentCenter;
    }
    return _totalUV;
}

-(UILabel *)countPV
{
    if (!_countPV) {
        _countPV = [[UILabel alloc] init];
        _countPV.text = @"87  ";
        _countPV.font = [UIFont systemFontOfSize:12*AppScale];
//        _countPV.textColor = [UIColor redColor];
        _countPV.textAlignment = NSTextAlignmentRight;
    }
    return _countPV;
}

-(UILabel *)totalPV
{
    if (!_totalPV) {
        _totalPV = [[UILabel alloc] init];
        _totalPV.text = @"访客  ";
        _totalPV.font = [UIFont systemFontOfSize:12*AppScale];
        _totalPV.textColor = RGBColor(161, 161, 161);
        _totalPV.textAlignment = NSTextAlignmentRight;
    }
    return _totalPV;
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
    [self addSubview:self.name];
    //[self addSubview:self.countUV];
    //[self addSubview:self.totalUV];
    [self addSubview:self.countPV];
    [self addSubview:self.totalPV];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
//    [_countUV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
//        make.left.equalTo(_name.mas_right);
//        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/2, 20*AppScale));
//    }];
//    
//    [_totalUV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_countUV.mas_bottom);
//        make.left.equalTo(_name.mas_right);
//        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/2, 20*AppScale));
//    }];
    
    [_countPV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
        //make.left.equalTo(_countUV.mas_right);
        make.width.equalTo(@(80*AppScale));
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_totalPV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_countPV.mas_bottom);
        //make.left.equalTo(_totalUV.mas_right);
        make.width.equalTo(@(80*AppScale));
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

@end
