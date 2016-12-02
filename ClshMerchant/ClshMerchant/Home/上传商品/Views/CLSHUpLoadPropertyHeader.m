//
//  CLSHUpLoadPropertyHeader.m
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHUpLoadPropertyHeader.h"

@interface CLSHUpLoadPropertyHeader ()
@property (nonatomic, strong) UILabel *propertyLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *stockLab;
@end

@implementation CLSHUpLoadPropertyHeader

-(UILabel *)propertyLab{
    if (!_propertyLab) {
        _propertyLab=[UILabel new];
        _propertyLab.textColor=RGBColor(51, 51, 51);
        _propertyLab.font=[UIFont systemFontOfSize:13*AppScale];
        _propertyLab.text=@"规则";
        _propertyLab.textAlignment=NSTextAlignmentCenter;
    }
    return _propertyLab;
}

-(UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab=[UILabel new];
        _priceLab.textColor=RGBColor(51, 51, 51);
        _priceLab.font=[UIFont systemFontOfSize:13*AppScale];
        _priceLab.text=@"价格(元)";
        _priceLab.textAlignment=NSTextAlignmentCenter;
    }
    return _priceLab;
}

-(UILabel *)stockLab{
    if (!_stockLab) {
        _stockLab=[UILabel new];
        _stockLab.textColor=RGBColor(51, 51, 51);
        _stockLab.font=[UIFont systemFontOfSize:13*AppScale];
        _stockLab.text=@"库存(件)";
        _stockLab.textAlignment=NSTextAlignmentCenter;
    }
    return _stockLab;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.propertyLab];
    [self addSubview:self.priceLab];
    [self addSubview:self.stockLab];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_propertyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-20*AppScale)/3, 20*AppScale));
    }];
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_propertyLab.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-20*AppScale)/3, 20*AppScale));
    }];
    
    [_stockLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLab.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-20*AppScale)/3, 20*AppScale));
    }];
}

@end
