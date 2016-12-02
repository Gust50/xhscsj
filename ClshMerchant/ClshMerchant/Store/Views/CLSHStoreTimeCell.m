//
//  CLSHStoreTimeCell.m
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


#import "CLSHStoreTimeCell.h"

@interface CLSHStoreTimeCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel  *startTime;
@property (nonatomic, strong) UIImageView *startIcon;
@property (nonatomic, strong) UIView *middleLine;
@property (nonatomic, strong) UILabel *endTime;
@property (nonatomic, strong) UIImageView *endTimeIcon;
@end

@implementation CLSHStoreTimeCell


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

-(UILabel *)startTime{
    if (!_startTime) {
        _startTime=[UILabel new];
        _startTime.font=[UIFont systemFontOfSize:11*AppScale];
        _startTime.textAlignment=NSTextAlignmentRight;
        _startTime.textColor=RGBColor(51, 51, 51);
    }
    return _startTime;
}

-(UILabel *)endTime{
    if (!_endTime) {
        _endTime=[UILabel new];
        _endTime.font=[UIFont systemFontOfSize:11*AppScale];
        _endTime.textAlignment=NSTextAlignmentRight;
        _endTime.textColor=RGBColor(51, 51, 51);
    }
    return _endTime;
}

-(UIImageView *)startIcon{
    if (!_startIcon) {
        _startIcon=[UIImageView new];
        _startIcon.image=[UIImage imageNamed:@"time"];
    }
    return _startIcon;
}

-(UIImageView *)endTimeIcon{
    if (!_endTimeIcon) {
        _endTimeIcon=[UIImageView new];
        _endTimeIcon.image=[UIImage imageNamed:@"time"];
    }
    return _endTimeIcon;
}

-(UIView *)middleLine{
    if (!_middleLine) {
        _middleLine=[UIView new];
        _middleLine.backgroundColor=backGroundColor;
    }
    return _middleLine;
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
    [self addSubview:self.startTime];
    [self addSubview:self.startIcon];
    [self addSubview:self.middleLine];
    [self addSubview:self.endTime];
    [self addSubview:self.endTimeIcon];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18*AppScale, 18*AppScale));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 18*AppScale));
    }];
    
    [_endTimeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12*AppScale, 12*AppScale));
    }];
    
    [_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_endTimeIcon.mas_left).with.offset(-5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30*AppScale, 18*AppScale));
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_endTime.mas_left);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20*AppScale, 1));
    }];
    
    [_startIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_middleLine.mas_left).with.offset(-5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12*AppScale, 12*AppScale));
    }];
    
    [_startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_startIcon.mas_left).with.offset(-5*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30*AppScale, 18*AppScale));
    }];
}

-(void)setStartContent:(NSString *)startContent{
    _startContent=startContent;
    _startTime.text=startContent;
}
-(void)setEndContent:(NSString *)endContent{
    _endContent=endContent;
    _endTime.text=endContent;
}

-(void)setTitleContent:(NSString *)titleContent{
    _titleContent=titleContent;
    _title.text=titleContent;
}
-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl=iconUrl;
    _icon.image=[UIImage imageNamed:iconUrl];
}
@end
