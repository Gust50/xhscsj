//
//  CLSHBusinessStyleCell.m
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


#import "CLSHBusinessStyleCell.h"

@interface CLSHBusinessStyleCell ()

@property (nonatomic, strong)UILabel *leftName;
@property (nonatomic, strong)UILabel *style;
@end
@implementation CLSHBusinessStyleCell

-(UILabel *)leftName
{
    if (!_leftName) {
        _leftName = [[UILabel alloc] init];
        _leftName.text = @"营业类型:";
        _leftName.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _leftName;
}

-(UILabel *)style
{
    if (!_style) {
        _style = [[UILabel alloc] init];
        _style.font = [UIFont systemFontOfSize:13*AppScale];
        _style.text = @"餐饮美食";
        
    }
    return _style;
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
    [self addSubview:self.style];
    
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
    
    [_style mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_leftName.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(30*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setIndustryName:(NSString *)industryName
{
    _industryName = industryName;
    self.style.text = self.industryName;
}

@end
