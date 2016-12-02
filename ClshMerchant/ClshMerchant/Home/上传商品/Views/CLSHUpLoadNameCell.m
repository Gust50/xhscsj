//
//  CLSHUpLoadNameCell.m
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


#import "CLSHUpLoadNameCell.h"

@interface CLSHUpLoadNameCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation CLSHUpLoadNameCell

#pragma mark <lazyLoad>
-(UILabel *)name{
    if (!_name) {
        _name=[UILabel new];
        _name.textColor=RGBColor(51, 51, 51);
        _name.font=[UIFont systemFontOfSize:13*AppScale];
        _name.text=@"商品名称";
    }
    return _name;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField=[UITextField new];
        _textField.delegate=self;
        _textField.font=[UIFont systemFontOfSize:13*AppScale];
        _textField.borderStyle=UITextBorderStyleNone;
        _textField.layer.borderColor=RGBColor(51, 51, 51).CGColor;
        _textField.layer.borderWidth=1;
    }
    return _textField;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.name];
    [self addSubview:self.textField];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_name.mas_right).with.offset(5*AppScale);
        make.height.mas_equalTo(@(30*AppScale));
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
    }];
}

#pragma mark <UITextFieldDelegate>
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(upLoadNameCellDone:)]) {
        [self.delegate upLoadNameCellDone:textField.text];
    }
}

#pragma mark <getter setter>
-(void)setNameText:(NSString *)nameText{
    _textField.text=nameText;
}

@end
