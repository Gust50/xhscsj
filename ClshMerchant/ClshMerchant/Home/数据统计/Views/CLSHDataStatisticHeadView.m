//
//  CLSHDataStatisticHeadView.m
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


#import "CLSHDataStatisticHeadView.h"

@implementation CLSHDataStatisticHeadView

#pragma mark - lazyLoad
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGBColor(120, 217, 107);
    }
    return _backView;
}

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"DataBigVisitorIcon"];
    }
    return _icon;
}

-(UILabel *)total
{
    if (!_total) {
        _total = [[UILabel alloc] init];
        _total.textAlignment = NSTextAlignmentCenter;
        _total.font = [UIFont systemFontOfSize:16*AppScale];
        _total.text = @"累计访客";
        _total.textColor = RGBColor(205, 240, 201);
    }
    return _total;
}

-(UILabel *)count
{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.textAlignment = NSTextAlignmentCenter;
        _count.font = [UIFont systemFontOfSize:16*AppScale];
        _count.text = @"7589个";
        _count.textColor = [UIColor whiteColor];
        [NSString labelString:_count font:[UIFont systemFontOfSize:30*AppScale] range:NSMakeRange(0, _count.text.length-1) color:[UIColor whiteColor]];
    }
    return _count;
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
    [self addSubview:self.backView];
    [self addSubview:self.icon];
    [self addSubview:self.total];
    [self addSubview:self.count];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(180*AppScale));
    }];
    
    [_total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(55*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_total.mas_bottom).offset(5*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(40*AppScale));
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_bottom).offset(-30*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 60*AppScale));
    }];
}

@end
