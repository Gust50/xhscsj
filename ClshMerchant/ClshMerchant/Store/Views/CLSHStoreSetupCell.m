//
//  CLSHStoreSetupCell.m
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


#import "CLSHStoreSetupCell.h"

@interface CLSHStoreSetupCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UIImageView *arrow;
@end

@implementation CLSHStoreSetupCell

#pragma mark <lazyLoad>
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=30*AppScale;
        _icon.layer.borderColor=[UIColor whiteColor].CGColor;
        _icon.layer.borderWidth=1;
    }
    return _icon;
}
-(UILabel *)nickName{
    if (!_nickName) {
        _nickName=[UILabel new];
        _nickName.font=[UIFont systemFontOfSize:13*AppScale];
        _nickName.textColor=[UIColor whiteColor];
    }
    return _nickName;
}

-(UILabel *)phone{
    if (!_phone) {
        _phone=[UILabel new];
        _phone.font=[UIFont systemFontOfSize:11*AppScale];
        _phone.textColor=[UIColor whiteColor];
    }
    return _phone;
}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow=[UIImageView new];
        _arrow.image=[UIImage imageNamed:@"arrow_white"];
    }
    return _arrow;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=systemColor;
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    [self addSubview: self.icon];
    [self addSubview: self.nickName];
    [self addSubview: self.phone];
    [self addSubview: self.arrow];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 60*AppScale));
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(-10*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 14*AppScale));
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY).with.offset(10*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 14*AppScale));
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.size.mas_equalTo(CGSizeMake(8*AppScale, 12*AppScale));
    }];
}


-(void)setNickNameContent:(NSString *)nickNameContent{
    _nickNameContent=nickNameContent;
    _nickName.text=nickNameContent;
}

-(void)setPhoneContent:(NSString *)phoneContent{
    _phoneContent=phoneContent;
    _phone.text=phoneContent;
}
-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl=iconUrl;
    [_icon sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:nil];
}
@end
