//
//  CLSHStoreDeliveryCell.m
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


#import "CLSHStoreDeliveryCell.h"
#import "KBLeftTextRightImgBtn.h"
@interface CLSHStoreDeliveryCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) KBLeftTextRightImgBtn *deliveryBtn;
@property (nonatomic, strong) KBLeftTextRightImgBtn *takeBtn;
@property (nonatomic, assign) BOOL chooseOne;      ///<至少一种方式
@property (nonatomic, assign) BOOL chooseDelivery;
@property (nonatomic, assign) BOOL chooseTake;
@end

@implementation CLSHStoreDeliveryCell

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

-(KBLeftTextRightImgBtn *)deliveryBtn{
    if (!_deliveryBtn) {
        _deliveryBtn=[KBLeftTextRightImgBtn buttonWithType:0];
        [_deliveryBtn setTitle:@"配送" forState:0];
        [_deliveryBtn setImage:[UIImage imageNamed:@"Button_normal"] forState:0];
        [_deliveryBtn addTarget:self action:@selector(clickDeliveryBtn:) forControlEvents:UIControlEventTouchUpInside];
        _deliveryBtn.selected = YES;
        [_deliveryBtn setTitleColor:RGBColor(51, 51, 51) forState:0];
        _deliveryBtn.titleLabel.font=[UIFont systemFontOfSize:12*AppScale];
    }
    return _deliveryBtn;
}

-(KBLeftTextRightImgBtn *)takeBtn{
    if (!_takeBtn) {
        _takeBtn=[KBLeftTextRightImgBtn buttonWithType:0];
        [_takeBtn setTitle:@"自提" forState:0];
        [_takeBtn setImage:[UIImage imageNamed:@"Button_normal"] forState:0];
        [_takeBtn addTarget:self action:@selector(clickTakeBtn:) forControlEvents:UIControlEventTouchUpInside];
        _takeBtn.selected = YES;
        [_takeBtn setTitleColor:RGBColor(51, 51, 51) forState:0];
        _takeBtn.titleLabel.font=[UIFont systemFontOfSize:12*AppScale];
    }
    return _takeBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.icon];
    [self addSubview:self.title];
    [self addSubview:self.deliveryBtn];
    [self addSubview:self.takeBtn];
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
    
    
    [_takeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50*AppScale, 20*AppScale));
    }];
    
    [_deliveryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_takeBtn.mas_left).with.offset(-5*AppScale);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50*AppScale, 20*AppScale));
    }];
}

#pragma mark <otherResponse>
-(void)clickDeliveryBtn:(UIButton *)btn{
    if (btn.isSelected) {
        
        if (_chooseOne) {
            btn.selected=NO;
            _chooseOne=NO;
            _chooseDelivery=NO;
            [_deliveryBtn setImage:[UIImage imageNamed:@"Button_normal"] forState:UIControlStateNormal];
            [self chooseDelivery:_chooseDelivery take:_chooseTake];
        }else{
            [MBProgressHUD showError:@"至少选择一种方式"];
        }
        
    }else{
        _chooseOne=YES;
        _chooseDelivery=YES;
        btn.selected=YES;
        [_deliveryBtn setImage:[UIImage imageNamed:@"Button_select"] forState:UIControlStateNormal];
       NSLog(@"。。。自提%@",_chooseTake?@"YES":@"NO");
        [self chooseDelivery:_chooseDelivery take:_chooseTake];
    }
}

-(void)clickTakeBtn:(UIButton *)btn{
    if (btn.isSelected) {
        
        if (_chooseOne) {
            btn.selected=NO;
            _chooseOne=NO;
            _chooseTake=NO;
            [_takeBtn setImage:[UIImage imageNamed:@"Button_normal"] forState:UIControlStateNormal];
            [self chooseDelivery:_chooseDelivery take:_chooseTake];
        }else{
            [MBProgressHUD showError:@"至少选择一种方式"];
        }
    }else{
        _chooseOne=YES;
        btn.selected=YES;
        _chooseTake=YES;
        [_takeBtn setImage:[UIImage imageNamed:@"Button_select"] forState:UIControlStateNormal];
        [self chooseDelivery:_chooseDelivery take:_chooseTake];
    }
}

-(void)chooseDelivery:(BOOL)delivery take:(BOOL)take{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseDelivery:take:)]) {
        [self.delegate chooseDelivery:delivery take:take];
    }
}

#pragma mark <getter setter>
-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl=iconUrl;
    _icon.image=[UIImage imageNamed:iconUrl];
}

-(void)setTitleContent:(NSString *)titleContent{
    _titleContent=titleContent;
    _title.text=titleContent;
}

-(void)setIsSupportDelivery:(BOOL)isSupportDelivery
{
    _deliveryBtn.selected= isSupportDelivery;
    _chooseDelivery = isSupportDelivery;
    if (_chooseTake && _chooseDelivery) {
        _chooseOne = YES;
    }
    
    NSLog(@"配送%@",isSupportDelivery?@"YES":@"NO");
    if (isSupportDelivery) {
        
        [_deliveryBtn setImage:[UIImage imageNamed:@"Button_select"] forState:UIControlStateNormal];
    }else{
        [_deliveryBtn setImage:[UIImage imageNamed:@"Button_normal"] forState:UIControlStateNormal];
    }
    
}

-(void)setIsSupportSelfPickUp:(BOOL)isSupportSelfPickUp
{
    _takeBtn.selected=isSupportSelfPickUp;
    _chooseTake = isSupportSelfPickUp;
    if (_chooseTake && _chooseDelivery) {
        _chooseOne = YES;
    }
    NSLog(@"自提%@",isSupportSelfPickUp?@"YES":@"NO");
    if (isSupportSelfPickUp) {
       
         [_takeBtn setImage:[UIImage imageNamed:@"Button_select"] forState:UIControlStateNormal];
    }else{
          [_takeBtn setImage:[UIImage imageNamed:@"Button_normal"] forState:UIControlStateNormal];
    }
}

@end
