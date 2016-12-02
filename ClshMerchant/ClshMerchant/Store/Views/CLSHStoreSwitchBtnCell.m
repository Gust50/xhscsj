//
//  CLSHStoreSwitchBtnCell.m
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


#import "CLSHStoreSwitchBtnCell.h"
#import "CLSHStoreModel.h"

@interface CLSHStoreSwitchBtnCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation CLSHStoreSwitchBtnCell

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

-(UIButton *)btn{
    if (!_btn) {
        _btn=[UIButton buttonWithType:0];
        [_btn setImage:[UIImage imageNamed:@"NoBusiness"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"Business"] forState:UIControlStateSelected];
        [_btn addTarget:self action:@selector(businessState:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
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
    [self addSubview:self.btn];
    self.btn.selected = _isOpen;
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
    
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 25*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl=iconUrl;
    _icon.image=[UIImage imageNamed:iconUrl];
}
-(void)setShopState:(NSString *)shopState{
    _shopState=shopState;
    _title.text=shopState;
}

//营业状态
- (void)businessState:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (self.selectOpenBlock) {
            self.selectOpenBlock(YES);
        }
    }else
    {
        if (self.selectOpenBlock) {
            self.selectOpenBlock(NO);
        }
    }
    
}

- (void)setModel:(CLSHStoreMapModel *)model{

    _model = model;
    if (model.isOpen) {
        _btn.selected = YES;
    }else{
    
        _btn.selected = NO;
    }
}

@end
