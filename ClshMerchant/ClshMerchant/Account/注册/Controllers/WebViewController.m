//
//  WebViewController.m
//  ClshMerchant
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addWeb];
    [self initUI];
}

- (void)initUI{
    self.view.backgroundColor = backGroundColor;
    [self.view addSubview:self.navView];
    [_navView addSubview:self.BackButton];
    [_navView addSubview:self.navTitleLabel];
    [self.view addSubview:self.web];
    [self updateConstraints];
}

- (UIWebView *)web{
    if (!_web) {
    _web = [[UIWebView alloc] init];
    _web.backgroundColor = [UIColor grayColor];
    _web.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:@"http://m.culsh.cn/agreement.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_web loadRequest:request];
    
    }
    return _web;
}

- (UIView *)navView{
    
    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (UILabel *)navTitleLabel{
    
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        _navTitleLabel.textColor = systemColor;
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleLabel.text = @"嗅虎商城服务协议";
        _navTitleLabel.font = [UIFont systemFontOfSize:16*AppScale];
    }
    return _navTitleLabel;
}

- (UIButton *)BackButton{
    
    if (!_BackButton) {
        _BackButton = [[UIButton alloc] init];
        [_BackButton setImage:[UIImage imageNamed:@"Arrow"] forState:(UIControlStateNormal)];
        [_BackButton setTitle:@" 返回" forState:(UIControlStateNormal)];
        [_BackButton setTitleColor:systemColor forState:(UIControlStateNormal)];
        _BackButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_BackButton addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        [_BackButton setTitleColor:systemColor forState:(UIControlStateNormal)];
    }
    return _BackButton;
}
- (void)dismiss{
    [_web stopLoading];
    [self dismissViewControllerAnimated:YES completion:nil];
    //self.dismissblock();
    
}


- (void)updateConstraints{
    
    //[super updateConstraints];
    
    WS(weakSelf);
    
    [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.equalTo(@64);
    }];
    
    [_web mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_navView.mas_bottom).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
//        make.height.equalTo(@64);
    }];

    
    [_BackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_navView.mas_left).with.offset(8);
        make.bottom.equalTo(_navView.mas_bottom).with.offset(0);
        make.top.equalTo(_navView.mas_top).with.offset(20);
        make.width.mas_equalTo(@(40*AppScale));
        
    }];
    
    [_navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_navView.mas_centerX);
        make.top.equalTo(_navView.mas_top).with.offset(15);
        make.bottom.equalTo(_navView.mas_bottom).with.offset(0);
        make.width.equalTo(@210);
    }];
}
@end
