//
//  CLSHDataSalesCell.m
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


#import "CLSHDataSalesCell.h"

@implementation CLSHDataSalesCell

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"今日订单数";
        _name.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _name;
}

-(UILabel *)count
{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.text = @"8单";
        _count.font = [UIFont systemFontOfSize:12*AppScale];
        _count.textColor = RGBColor(122, 122, 122);
        [NSString labelString:_count font:[UIFont systemFontOfSize:18*AppScale] range:NSMakeRange(0, _count.text.length-1) color:[UIColor redColor]];
        _count.textAlignment = NSTextAlignmentRight;
    }
    return _count;
}

-(UILabel *)state
{
    if (!_state) {
        _state = [[UILabel alloc] init];
        _state.text = @"交易成功";
        _state.font = [UIFont systemFontOfSize:12*AppScale];
        _state.textColor = RGBColor(187, 187, 187);
        _state.textAlignment = NSTextAlignmentRight;
    }
    return _state;
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
    [self addSubview:self.count];
    [self addSubview:self.state];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(150*AppScale, 20*AppScale));
    }];
    
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
        make.left.equalTo(_name.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(25*AppScale));
    }];
    
    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_count.mas_bottom);
        make.left.equalTo(_name.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

@end
