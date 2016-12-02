//
//  CLSHMechantTaskWalletView.m
//  ClshUser
//
//  Created by wutaobo on 16/7/13.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMechantTaskWalletView.h"
#import "Masonry.h"

@interface CLSHMechantTaskWalletView ()

@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *defaultLabel;

@property (nonatomic, strong) UILabel *describe;
@property (nonatomic, strong) UIButton *close;

@end

@implementation CLSHMechantTaskWalletView

-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] init];
        _backImage.image = [UIImage imageNamed:@"MeichantAdWalletBack"];
    }
    return _backImage;
}

- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] init];
        _imageview.image = [UIImage imageNamed:@"GetWalletWard"];
    }
    return _imageview;
}

-(UILabel *)defaultLabel
{
    if (!_defaultLabel) {
        _defaultLabel = [[UILabel alloc] init];
        _defaultLabel.text = @"恭喜您";
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
        _defaultLabel.font = [UIFont systemFontOfSize:18*AppScale];
    }
    return _defaultLabel;
}

- (UILabel *)getWallet
{
    if (!_getWallet) {
        _getWallet = [[UILabel alloc] init];
        _getWallet.textColor = RGBColor(67, 67, 67);
        _getWallet.font = [UIFont systemFontOfSize:14*AppScale];
        _getWallet.text = @"获得一个红包和一张优惠券";
        _getWallet.textAlignment = NSTextAlignmentCenter;
    }
    return _getWallet;
}

-(UILabel *)describe
{
    if (!_describe) {
        _describe = [[UILabel alloc] init];
        _describe.text = @"记得去查看哦！";
        _describe.textColor = RGBColor(108, 107, 108);
        _describe.font = [UIFont systemFontOfSize:12*AppScale];
        _describe.textAlignment = NSTextAlignmentCenter;
    }
    return _describe;
}

-(UIButton *)close
{
    if (!_close) {
        _close = [[UIButton alloc] init];
        _close.layer.cornerRadius = 15.0*AppScale;
        _close.layer.masksToBounds = YES;
        [_close setImage:[UIImage imageNamed:@"MeichantAdWalletClose"] forState:UIControlStateNormal];
        [_close addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _close;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = RGBAColor(0, 0, 0, 0.7);
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAdWallet)];
        [self addGestureRecognizer:gesture];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.backImage];
    [self.backImage addSubview:self.imageview];
    [self.backImage addSubview:self.defaultLabel];
    [self.backImage addSubview:self.getWallet];
    [self.backImage addSubview:self.describe];
    [self.backImage addSubview:self.close];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(200*AppScale);
    }];
    
    [_getWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(15*AppScale);
    }];
    
    [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.bottom.equalTo(_getWallet.mas_top).offset(-10*AppScale);
        make.height.mas_equalTo(20*AppScale);
    }];
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.bottom.equalTo(_backImage.mas_top).offset(50*AppScale);
        make.height.mas_equalTo(80*AppScale);
    }];
    
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_getWallet.mas_bottom).offset(15*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(15*AppScale);
    }];
    
    [_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_describe.mas_bottom).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake(30*AppScale, 30*AppScale));
    }];
}

//移除视图
- (void)removeAdWallet
{
    [self removeFromSuperview];
}

- (void)closeView
{
    [self removeFromSuperview];
}

@end
