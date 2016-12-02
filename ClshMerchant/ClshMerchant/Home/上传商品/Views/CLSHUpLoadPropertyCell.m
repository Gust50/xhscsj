//
//  CLSHUpLoadPropertyCell.m
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHUpLoadPropertyCell.h"
#import "CLSHupLoadGoodsModel.h"
@interface CLSHUpLoadPropertyCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *propertyTextField;
@property (nonatomic, strong) UITextField *priceTextField;
@property (nonatomic, strong) UITextField *stockTextField;
@property (nonatomic, strong) UIView *middleLineOne;
@property (nonatomic, strong) UIView *middleLineTwo;
@property (nonatomic, strong) UIImageView *icon;
@end

@implementation CLSHUpLoadPropertyCell

-(UITextField *)propertyTextField{
    if (!_propertyTextField) {
        _propertyTextField=[UITextField new];
        _propertyTextField.borderStyle=UITextBorderStyleNone;
        _propertyTextField.layer.borderColor=RGBColor(51, 51, 51).CGColor;
        _propertyTextField.layer.borderWidth=1;
        _propertyTextField.placeholder=@"名称";
        _propertyTextField.textAlignment=NSTextAlignmentCenter;
        _propertyTextField.font=[UIFont systemFontOfSize:12*AppScale];
        _propertyTextField.delegate=self;
    }
    return _propertyTextField;
}

-(UITextField *)priceTextField{
    if (!_priceTextField) {
        _priceTextField=[UITextField new];
        _priceTextField.borderStyle=UITextBorderStyleNone;
        _priceTextField.layer.borderColor=RGBColor(51, 51, 51).CGColor;
        _priceTextField.layer.borderWidth=1;
        _priceTextField.placeholder=@"价格";
        _priceTextField.textAlignment=NSTextAlignmentCenter;
        _priceTextField.font=[UIFont systemFontOfSize:12*AppScale];
        _priceTextField.delegate=self;
        
    }
    return _priceTextField;
}

-(UITextField *)stockTextField{
    if (!_stockTextField) {
        _stockTextField=[UITextField new];
        _stockTextField.borderStyle=UITextBorderStyleNone;
        _stockTextField.layer.borderColor=RGBColor(51, 51, 51).CGColor;
        _stockTextField.layer.borderWidth=1;
        _stockTextField.placeholder=@"库存";
        _stockTextField.textAlignment=NSTextAlignmentCenter;
        _stockTextField.font=[UIFont systemFontOfSize:12*AppScale];
        _stockTextField.delegate=self;
    }
    return _stockTextField;
}

-(UIView *)middleLineOne{
    if (!_middleLineOne) {
        _middleLineOne=[UIView new];
        _middleLineOne.backgroundColor=backGroundColor;
    }
    return _middleLineOne;
}

-(UIView *)middleLineTwo{
    if (!_middleLineTwo) {
        _middleLineTwo=[UIView new];
        _middleLineTwo.backgroundColor=backGroundColor;
    }
    return _middleLineTwo;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
        _icon.image=[UIImage imageNamed:@"deleteProperty"];
        _icon.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteProperyModel:)];
        [_icon addGestureRecognizer:tap];
    }
    return _icon;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.propertyTextField];
    [self addSubview:self.middleLineOne];
    [self addSubview:self.priceTextField];
    [self addSubview:self.middleLineTwo];
    [self addSubview:self.stockTextField];
    [self addSubview:self.icon];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_propertyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-20*AppScale-48*AppScale)/3, 25*AppScale));
    }];
    
    [_middleLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_propertyTextField.mas_right).with.offset(2);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(5*AppScale, 1));
    }];
    
    [_priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleLineOne.mas_right).with.offset(2);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-20*AppScale-48*AppScale)/3, 25*AppScale));
    }];
    
    [_middleLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceTextField.mas_right).with.offset(2);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(5*AppScale, 1));
    }];
    
    [_stockTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_middleLineTwo.mas_right).with.offset(2);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-20*AppScale-48*AppScale)/3, 25*AppScale));
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18*AppScale, 18*AppScale));
    }];
}




#pragma mark <UITextFieldDelegate>
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField==_propertyTextField) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(upLoadGoodsProperty:indexPath:)]) {
            [self.delegate upLoadGoodsProperty:textField.text indexPath:_indexPath];
        }
    }else if (textField==_priceTextField){
        if (self.delegate && [self.delegate respondsToSelector:@selector(upLoadGoodsPrice:indexPath:)]) {
            [self.delegate upLoadGoodsPrice:textField.text indexPath:_indexPath];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(upLoadGoodsStock:indexPath:)]) {
            [self.delegate upLoadGoodsStock:textField.text indexPath:_indexPath];
        }
    }
}


#pragma mark <otherResponse>
-(void)deleteProperyModel:(UITapGestureRecognizer *)gesture{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deletePropery:)]) {
        [self.delegate deletePropery:_model];
    }
}

#pragma mark <getter setter>
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
}

-(void)setModel:(CLSHupLoadPropertyModel *)model{
    _model=model;
    if (model.name.length==0) {
        
    }else{
        _propertyTextField.text=model.name;
        _priceTextField.text=[NSString stringWithFormat:@"%0.2lf",model.price];
        _stockTextField.text=[NSString stringWithFormat:@"%ld",model.stock];
    }
    
}
@end
