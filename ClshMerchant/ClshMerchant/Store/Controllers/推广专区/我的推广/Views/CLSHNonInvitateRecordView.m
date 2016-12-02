//
//  CLSHNonInvitateRecordView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHNonInvitateRecordView.h"
#import "Masonry.h"

@interface CLSHNonInvitateRecordView()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *describe;

@end

@implementation CLSHNonInvitateRecordView

#pragma mark-getter setter
-(UILabel *)describe{
    if (!_describe) {
        _describe=[[UILabel alloc]init];
        _describe.textColor = RGBColor(157, 157, 157);
        _describe.font = [UIFont systemFontOfSize:14*AppScale];
        _describe.text = @"暂无邀请记录!";
        _describe.textAlignment = NSTextAlignmentCenter;
    }
    return _describe;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"NoInvitateRecord"];
    }
    return _icon;
}

#pragma mark-init UI
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.describe];
    [self addSubview:self.icon];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(100*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 60*AppScale));
    }];
    
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

@end
