//
//  CLSHDataStatsticFooterView.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHDataStatsticFooterView.h"

@interface CLSHDataStatsticFooterView()
@property (nonatomic, strong)UILabel *topLabel;
@property (nonatomic, strong)UILabel *bottomLabel;

@end
@implementation CLSHDataStatsticFooterView

#pragma mark - lazyLoad
-(UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.text = @"*UV：单个独立IP地址对应单个访客的总和";
        _topLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _topLabel.textColor = RGBColor(172, 172, 172);
        [NSString labelString:_topLabel font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    }
    return _topLabel;
}

-(UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.text = @"*PV：所有独立IP地址访客访问的页面量的总和";
        _bottomLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _bottomLabel.textColor = RGBColor(172, 172, 172);
        [NSString labelString:_bottomLabel font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    }
    return _bottomLabel;
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
//    [self addSubview:self.topLabel];
//    [self addSubview:self.bottomLabel];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLabel.mas_bottom).offset(5*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

@end
