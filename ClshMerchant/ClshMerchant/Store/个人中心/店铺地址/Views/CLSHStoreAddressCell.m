//
//  CLSHStoreAddressCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/11.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHStoreAddressCell.h"

@interface CLSHStoreAddressCell ()

@end

@implementation CLSHStoreAddressCell

#pragma mark - lazyLoad
-(UILabel *)storeAddress
{
    if (!_storeAddress) {
        _storeAddress = [[UILabel alloc] init];
        _storeAddress.text = @"店铺地址：";
        _storeAddress.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _storeAddress;
}

-(UILabel *)address
{
    if (!_address) {
        _address = [[UILabel alloc] init];
        _address.text = @"广东省深圳市";
        _address.font = [UIFont systemFontOfSize:13*AppScale];
        _address.textColor = RGBColor(90, 90, 90);
    }
    return _address;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.storeAddress];
    [self addSubview:self.address];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_storeAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 20*AppScale));
    }];
    
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_storeAddress.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
    }];
    
}

@end
