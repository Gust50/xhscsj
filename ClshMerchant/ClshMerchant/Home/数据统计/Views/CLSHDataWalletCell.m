//
//  CLSHDataWalletCell.m
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


#import "CLSHDataWalletCell.h"

@implementation CLSHDataWalletCell

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"超时退还";
        _name.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _name;
}

-(UILabel *)count
{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.text = @"8个";
        _count.font = [UIFont systemFontOfSize:12*AppScale];
        [NSString labelString:_count font:[UIFont systemFontOfSize:18*AppScale] range:NSMakeRange(0, _count.text.length-1) color:[UIColor redColor]];
        _count.textAlignment = NSTextAlignmentRight;
    }
    return _count;
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
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(200*AppScale, 20*AppScale));
    }];
    
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_name.mas_right).offset(10*AppScale);
         make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

@end
