//
//  CLSHWriteJoinInfoFooter.m
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


#import "CLSHWriteJoinInfoFooter.h"

@interface CLSHWriteJoinInfoFooter ()

@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, strong)UILabel *describe;
@property (nonatomic, strong)UIButton *application;

@end
@implementation CLSHWriteJoinInfoFooter

-(UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setImage:[UIImage imageNamed:@"AgreeProtol_narmal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"AgreeProtol"] forState:(UIControlStateSelected)];
        [_selectBtn addTarget:self action:@selector(isAgreeProtol:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UILabel *)describe
{
    if (!_describe) {
        _describe = [[UILabel alloc] init];
        _describe.font = [UIFont systemFontOfSize:12*AppScale];
        _describe.text = @"我已阅读并同意《嗅虎商城商家协议》";
        [NSString labelString:_describe font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(7, _describe.text.length-7) color:RGBColor(109, 148, 185)];
    }
    return _describe;
}

-(UIButton *)application
{
    if (!_application) {
        _application = [[UIButton alloc] init];
        _application.layer.cornerRadius = 5*AppScale;
        _application.layer.masksToBounds = YES;
        _application.backgroundColor = systemColor;
        _application.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_application setTitle:@"立即申请" forState:UIControlStateNormal];
        [_application setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_application addTarget:self action:@selector(immediatelyApplication) forControlEvents:UIControlEventTouchUpInside];
    }
    return _application;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = backGroundColor;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.selectBtn];
    [self addSubview:self.describe];
    [self addSubview:self.application];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 15*AppScale));
    }];
    
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10*AppScale);
        make.left.equalTo(_selectBtn.mas_right).offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_application mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_describe.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(40*AppScale));
    }];
}

//是否同意协议
- (void)isAgreeProtol:(UIButton *)sender
{
    if (!sender.selected) {
        sender.selected = YES;
        if (self.agreeProtcolblock) {
            
            self.agreeProtcolblock(sender.selected);
        }
    }else{
    
        sender.selected = NO;
        if (self.agreeProtcolblock) {
            
            self.agreeProtcolblock(sender.selected);
        }
    }
   
}

//立即申请
- (void)immediatelyApplication
{
    if (self.immediatelyApplicationBlock) {
        self.immediatelyApplicationBlock();
    }
}

@end
