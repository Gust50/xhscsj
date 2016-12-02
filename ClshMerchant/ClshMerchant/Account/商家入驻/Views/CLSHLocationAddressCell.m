//
//  CLSHLocationAddressCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/17.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHLocationAddressCell.h"

@interface CLSHLocationAddressCell ()

@property (nonatomic, strong)UILabel *leftlabel;
@property (nonatomic, strong)UITextField *address;
@property (nonatomic, strong)UILabel *line;
@property (nonatomic, strong)UIButton *selectAddress;
@end
@implementation CLSHLocationAddressCell

#pragma mark - lazyLoad
-(UILabel *)leftlabel
{
    if (!_leftlabel) {
        _leftlabel = [[UILabel alloc] init];
        _leftlabel.text = @"定位选择：";
        _leftlabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _leftlabel;
}

-(UITextField *)address
{
    if (!_address) {
        _address = [[UITextField alloc] init];
        _address.font = [UIFont systemFontOfSize:13*AppScale];
        _address.placeholder = @"定位到您的当前地点";
        _address.userInteractionEnabled = NO;
    }
    return _address;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBColor(235, 234, 235);
    }
    return _line;
}

-(UIButton *)selectAddress
{
    if (!_selectAddress) {
        _selectAddress = [[UIButton alloc] init];
        [_selectAddress setImage:[UIImage imageNamed:@"LocationIcon"] forState:UIControlStateNormal];
        [_selectAddress addTarget:self action:@selector(addressLocation) forControlEvents:UIControlEventTouchUpInside];
        [_selectAddress addTarget:self action:@selector(addressMap) forControlEvents:(UIControlEventTouchDownRepeat)];
    }
    return _selectAddress;
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
    [self addSubview:self.leftlabel];
    [self addSubview:self.address];
    [self addSubview:self.line];
    [self addSubview:self.selectAddress];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 20*AppScale));
    }];
    
    [_selectAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right);
        make.size.mas_equalTo(CGSizeMake(50*AppScale, 30*AppScale));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_selectAddress.mas_left);
        make.top.equalTo(weakSelf.mas_top).offset(5*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5*AppScale);
        make.width.mas_equalTo(@(1));
    }];
    
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_leftlabel.mas_right);
        make.right.equalTo(_line.mas_left);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
}

//地址定位
- (void)addressLocation
{
    if (self.locationAddressBlock) {
        self.locationAddressBlock();
    }
}

//地图
- (void)addressMap{

    if (self.AmapAddressblock) {
        self.AmapAddressblock();
    }
    
}


-(void)setDetailAddress:(NSString *)detailAddress{
    _address.text=detailAddress;
}

@end
