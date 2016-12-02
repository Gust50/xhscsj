//
//  CLSHIsJoinDiscountCell.m
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


#import "CLSHIsJoinDiscountCell.h"

@interface CLSHIsJoinDiscountCell ()

@property (nonatomic, strong)UISwitch *isJoinDiscount;
@end
@implementation CLSHIsJoinDiscountCell
#pragma mark - lazyLoad
-(UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"参与打折：";
        _leftLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _leftLabel;
}

-(UISwitch *)isJoinDiscount
{
    if (!_isJoinDiscount) {
        _isJoinDiscount = [[UISwitch alloc] init];
        [_isJoinDiscount addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _isJoinDiscount;
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
    [self addSubview:self.leftLabel];
    [self addSubview:self.isJoinDiscount];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 20*AppScale));
    }];
    
    [_isJoinDiscount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.size.mas_equalTo(CGSizeMake(45*AppScale, 25*AppScale));
    }];
}

#pragma mark <otherResponse>
//选择是否参加折扣
-(void)clickSwitch:(UISwitch *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickSwitch:)]) {
        [self.delegate clickSwitch:btn.isOn];
    }
}

#pragma  mark <getter setter>
-(void)setIsOn:(BOOL)isOn{
    _isOn=isOn;
    _isJoinDiscount.on=isOn;
}
@end
