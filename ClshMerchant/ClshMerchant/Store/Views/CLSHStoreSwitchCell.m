//
//  CLSHStoreSwitchCell.m
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


#import "CLSHStoreSwitchCell.h"

@interface CLSHStoreSwitchCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
//@property (nonatomic, strong) UISwitch *storeSwitch;

@end

@implementation CLSHStoreSwitchCell
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

- (UILabel *)discountLabel{

    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.font = [UIFont systemFontOfSize:13*AppScale];
        _discountLabel.textColor = RGBColor(102, 102, 102);
        _discountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _discountLabel;
}

//-(UISwitch *)storeSwitch{
//    if (!_storeSwitch) {
//        _storeSwitch=[UISwitch new];
//        [_storeSwitch addTarget:self action:@selector(clickSwitch:) forControlEvents:UIControlEventValueChanged];
//    }
//    return _storeSwitch;
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.icon];
    [self addSubview:self.title];
    [self addSubview:self.discountLabel];
//    [self addSubview:self.storeSwitch];
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

    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
//    
//    [_storeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
//        make.centerY.mas_equalTo(weakSelf.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(45*AppScale, 25*AppScale));
//    }];
}

//#pragma mark <otherResponse>
//-(void)clickSwitch:(UISwitch *)btn{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(clickSwitch:)]) {
//        [self.delegate clickSwitch:btn.isOn];
//    }
//}

#pragma mark <getter setter>
-(void)setTitleContent:(NSString *)titleContent{
    _titleContent=titleContent;
    _title.text=titleContent;
}
-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl=iconUrl;
    _icon.image=[UIImage imageNamed:iconUrl];
}

//-(void)setIsJoinPromotion:(BOOL)isJoinPromotion
//{
//    _isJoinPromotion = isJoinPromotion;
//    self.storeSwitch.on = isJoinPromotion;
//}

@end
