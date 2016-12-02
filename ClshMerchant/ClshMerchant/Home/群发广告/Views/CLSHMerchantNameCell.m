//
//  CLSHMerchantNameCell.m
//  ClshUser
//
//  Created by wutaobo on 16/7/6.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMerchantNameCell.h"
#import "Masonry.h"

@interface CLSHMerchantNameCell ()

@end

@implementation CLSHMerchantNameCell

- (UILabel *)merchantName
{
    if (!_merchantName) {
        _merchantName = [[UILabel alloc] init];
        _merchantName.font = [UIFont systemFontOfSize:14*AppScale];
        _merchantName.textAlignment = NSTextAlignmentCenter;
        _merchantName.text = @"端午节优惠大酬宾";
    }
    return _merchantName;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.merchantName];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

@end
