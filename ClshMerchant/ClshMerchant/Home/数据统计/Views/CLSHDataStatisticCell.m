//
//  CLSHDataStatisticCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHDataStatisticCell.h"

@interface CLSHDataStatisticCell ()

@end

@implementation CLSHDataStatisticCell

#pragma mark - lazyLoad
-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"DataVisitorIcon"];
    }
    return _icon;
}

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14*AppScale];
        _name.text = @"访客";
    }
    return _name;
}

-(UILabel *)total
{
    if (!_total) {
        _total = [[UILabel alloc] init];
        _total.font = [UIFont systemFontOfSize:12*AppScale];
        _total.text = @"累积访客";
        _total.textColor = RGBColor(160, 160, 160);
        _total.textAlignment = NSTextAlignmentRight;
    }
    return _total;
}

-(UILabel *)count
{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.font = [UIFont systemFontOfSize:12*AppScale];
        _count.text = @"8888个";
        [NSString labelString:_count font:[UIFont systemFontOfSize:20*AppScale] range:NSMakeRange(0, _count.text.length - 1) color:[UIColor redColor]];
        _count.textAlignment = NSTextAlignmentRight;
        
    }
    return _count;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self addSubview:self.total];
    [self addSubview:self.count];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 40*AppScale));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_icon.mas_right).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10*AppScale);
        make.left.equalTo(_name.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_total.mas_bottom);
        make.left.equalTo(_name.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(25*AppScale));
    }];
}

@end
