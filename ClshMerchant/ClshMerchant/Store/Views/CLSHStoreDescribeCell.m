//
//  CLSHStoreDescribeCell.m
//  ClshMerchant
//
//  Created by kobe on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHStoreDescribeCell.h"

@interface CLSHStoreDescribeCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *describe;

@end

@implementation CLSHStoreDescribeCell


-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
    }
    return _icon;
}

-(UILabel *)title{
    if (!_title) {
        _title=[UILabel new];
        _title.font=[UIFont systemFontOfSize:13*AppScale];
        _title.textColor=RGBColor(51, 51, 51);
    }
    return _title;
}

-(UILabel *)describe{
    if (!_describe) {
        _describe=[UILabel new];
        _describe.font=[UIFont systemFontOfSize:12*AppScale];
        _describe.textColor=RGBColor(51, 51, 51);
        _describe.textAlignment = NSTextAlignmentRight;
    }
    return _describe;
}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow=[UIImageView new];
        _arrow.image=[UIImage imageNamed:@"arrow_gray"];
    }
    return _arrow;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.icon];
    [self addSubview:self.title];
    [self addSubview:self.describe];
    [self addSubview:self.arrow];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20*AppScale, 20*AppScale));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 18*AppScale));
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(8*AppScale, 12*AppScale));
    }];
    
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_arrow.mas_left).with.offset(-10*AppScale);
        make.left.equalTo(_title.mas_right).with.offset(5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(18*AppScale));
    }];
}

-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl=iconUrl;
    _icon.image=[UIImage imageNamed:iconUrl];
}

-(void)setTitleContent:(NSString *)titleContent{
    _titleContent=titleContent;
    _title.text=titleContent;
}

-(void)setDescribeContent:(NSString *)describeContent{
    _describeContent=describeContent;
    _describe.text=describeContent;
}
@end
