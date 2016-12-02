//
//  CLSHMassInfoFooterView.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMassInfoFooterView.h"

@interface CLSHMassInfoFooterView ()
@property (nonatomic, strong)UILabel *totalPay;
@property (nonatomic, strong)UIButton *goPay;
@end

@implementation CLSHMassInfoFooterView

-(UILabel *)totalPay
{
    if (!_totalPay) {
        _totalPay = [[UILabel alloc] init];
        _totalPay.font = [UIFont systemFontOfSize:13*AppScale];
        _totalPay.text = @"合计支付：0.00元";
        [NSString labelString:_totalPay font:[UIFont systemFontOfSize:14*AppScale] range:NSMakeRange(5, _totalPay.text.length-5) color:[UIColor redColor]];
        _totalPay.textAlignment = NSTextAlignmentCenter;
        
    }
    return _totalPay;
}

-(UIButton *)goPay
{
    if (!_goPay) {
        _goPay = [[UIButton alloc] init];
        _goPay.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _goPay.backgroundColor = systemColor;
        _goPay.timeInterval = 5;
        _goPay.isEnableClickBtn = YES;
        [_goPay  setTitle:@"去支付" forState:UIControlStateNormal];
        [_goPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_goPay addTarget:self action:@selector(payMoney) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goPay;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.totalPay];
    [self addSubview:self.goPay];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_totalPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH*2/3-20*AppScale, 40*AppScale));
    }];
    
    [_goPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_totalPay.mas_right);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(40*AppScale));
    }];
}

//去支付
- (void)payMoney
{
    if (self.payBlock) {
        self.payBlock();
    }
}

#pragma mark - setter getter
-(void)setTotalAmount:(NSString *)totalAmount
{
    _totalAmount = totalAmount;
    NSString *amountStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[totalAmount floatValue]]];
    _totalPay.text = [NSString stringWithFormat:@"合计支付：%@", amountStr];
    [NSString labelString:_totalPay font:[UIFont systemFontOfSize:14*AppScale] range:NSMakeRange(5, _totalPay.text.length-5) color:[UIColor redColor]];
}

@end
