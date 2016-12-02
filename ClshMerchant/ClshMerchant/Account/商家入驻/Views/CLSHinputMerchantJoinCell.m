//
//  CLSHinputMerchantJoinCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHinputMerchantJoinCell.h"

@interface CLSHinputMerchantJoinCell ()<UITextFieldDelegate>

@end
@implementation CLSHinputMerchantJoinCell

-(UILabel *)leftName
{
    if (!_leftName) {
        _leftName = [[UILabel alloc] init];
        _leftName.text = @"店铺名称:";
        _leftName.font = [UIFont systemFontOfSize:13*AppScale];
        _inputInfo.userInteractionEnabled = NO;

    }
    return _leftName;
}

-(UITextField *)inputInfo
{
    if (!_inputInfo) {
        _inputInfo = [[UITextField alloc] init];
        _inputInfo.font = [UIFont systemFontOfSize:13*AppScale];
        _inputInfo.placeholder = @"请输入店铺名称";
        _inputInfo.borderStyle = UITextBorderStyleNone;
        _inputInfo.userInteractionEnabled = YES;
        _inputInfo.delegate = self;
    }
    return _inputInfo;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.leftName];
    [self addSubview:self.inputInfo];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_leftName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 20*AppScale));
    }];
    
    [_inputInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_leftName.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(30*AppScale));
    }];
}

#pragma mark <UITextFieldDelegate>

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(nameLabel:inputName:)]) {
        [self.delegate nameLabel:self.leftName.text inputName:self.inputInfo.text];
    }
    return YES;
}
@end
