//
//  CLSHMerchantJoinSelectAddressCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMerchantJoinSelectAddressCell.h"
#import "KBPickerArea.h"

@interface CLSHMerchantJoinSelectAddressCell()<KBPickerAreaDelegate>
@property (nonatomic, strong)UILabel *leftName;
@property (nonatomic, strong)UITextField *address;
@property (nonatomic, strong)UIButton *selectAddress;
@end

@implementation CLSHMerchantJoinSelectAddressCell

-(UILabel *)leftName
{
    if (!_leftName) {
        _leftName = [[UILabel alloc] init];
        _leftName.text = @"店铺地址:";
        _leftName.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _leftName;
}

-(UITextField *)address
{
    if (!_address) {
        _address = [[UITextField alloc] init];
        _address.font = [UIFont systemFontOfSize:13*AppScale];
        _address.placeholder = @"请选择地址";
        _address.userInteractionEnabled = YES;
    }
    return _address;
}

-(UIButton *)selectAddress
{
    if (!_selectAddress) {
        _selectAddress = [[UIButton alloc] init];
        [_selectAddress addTarget:self action:@selector(addressSelect:) forControlEvents:UIControlEventTouchUpInside];
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
    [self addSubview:self.leftName];
    [self addSubview:self.address];
    [self addSubview:self.selectAddress];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_leftName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 20*AppScale));
    }];
    
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_leftName.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(30*AppScale));
    }];
    
    [_selectAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_leftName.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(30*AppScale));
    }];
    
}

- (void)addressSelect:(UIButton *)sender
{
    KBPickerArea * pickArea = [[KBPickerArea alloc] initWithDelegate:self];
    pickArea.delegate = self;
    [pickArea showSelectAreaView];
}

#pragma mark - KBPickerAreaDelegate delegate

- (void)pickerArea:(KBPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area areaId:(NSString *)areaId{
    NSString *string=[NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    self.address.text = string;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"areaId"] = areaId;
    dic[@"shopAddress"]=string;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectAddress" object:nil userInfo:dic];
    
}



-(void)setShopAddress:(NSString *)shopAddress{
    _address.text=shopAddress;
}


@end
