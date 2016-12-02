//
//  CLSHBankCartInfoView.m
//  ClshUser
//
//  Created by wutaobo on 16/6/23.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHBankCartInfoView.h"
#import "Masonry.h"
#import "CLSHAccountCardBankModel.h"

@interface CLSHBankCartInfoView ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *bankName;
@property (nonatomic, strong) UILabel *bankBrance;
@property (nonatomic, strong) UILabel *bankNumber;
@property (nonatomic, strong) UILabel *bankCartType;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *bankBranceLabel;
@property (nonatomic, strong) UILabel *bankNumberLabel;
@property (nonatomic, strong) UILabel *bankCartTypeLabel;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@end

@implementation CLSHBankCartInfoView

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"持卡人";
        _nameLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _nameLabel.textColor = RGBColor(64, 64, 64);
        
    }
    return _nameLabel;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc]init];
        _bankNameLabel.textColor = RGBColor(64, 64, 64);
        _bankNameLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _bankNameLabel.text = @"开户行";
    }
    return _bankNameLabel;
}

-(UILabel *)bankBranceLabel{
    if (!_bankBranceLabel) {
        _bankBranceLabel =[[UILabel alloc]init];
        _bankBranceLabel.textColor = RGBColor(64, 64, 64);
        _bankBranceLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _bankBranceLabel.text = @"支    行";
        
    }
    return _bankBranceLabel;
}

-(UILabel *)bankNumberLabel{
    if (!_bankNumberLabel) {
        _bankNumberLabel = [[UILabel alloc]init];
        _bankNumberLabel.text = @"卡    号";
        _bankNumberLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _bankNumberLabel.textColor = RGBColor(64, 64, 64);
        
    }
    return _bankNumberLabel;
}

-(UILabel *)bankCartTypeLabel{
    if (!_bankCartTypeLabel) {
        _bankCartTypeLabel = [[UILabel alloc]init];
        _bankCartTypeLabel.text = @"类    型";
        _bankCartTypeLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _bankCartTypeLabel.textColor = RGBColor(64, 64, 64);
        
    }
    return _bankCartTypeLabel;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.textColor = RGBColor(64, 64, 64);
        _name.font = [UIFont systemFontOfSize:14*AppScale];
        _name.text = @"赵云";
    }
    return _name;
}

-(UILabel *)bankName{
    if (!_bankName) {
        _bankName = [[UILabel alloc]init];
        _bankName.textColor = RGBColor(64, 64, 64);
        _bankName.font = [UIFont systemFontOfSize:14*AppScale];
        _bankName.text = @"中国银行";
        
    }
    return _bankName;
}

-(UILabel *)bankBrance{
    if (!_bankBrance) {
        _bankBrance = [[UILabel alloc]init];
        _bankBrance.text = @"龙岗分行";
        _bankBrance.font = [UIFont systemFontOfSize:14*AppScale];
        _bankBrance.textColor = RGBColor(64, 64, 64);
        
    }
    return _bankBrance;
}

-(UILabel *)bankNumber{
    if (!_bankNumber) {
        _bankNumber = [[UILabel alloc]init];
        _bankNumber.textColor = RGBColor(64, 64, 64);
        _bankNumber.font = [UIFont systemFontOfSize:14*AppScale];
        _bankNumber.text = @"11111111111111111111111111";
    }
    return _bankNumber;
}

-(UILabel *)bankCartType{
    if (!_bankCartType) {
        _bankCartType = [[UILabel alloc]init];
        _bankCartType.textColor = RGBColor(64, 64, 64);
        _bankCartType.font = [UIFont systemFontOfSize:14*AppScale];
        _bankCartType.text = @"借记卡";
    }
    return _bankCartType;
}

-(UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc]init];
        _label1.backgroundColor = RGBColor(239, 239, 239);
        
    }
    return _label1;
}

-(UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc]init];
        _label2.backgroundColor = RGBColor(239, 239, 239);
    }
    return _label2;
}

-(UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc]init];
        _label3.backgroundColor = RGBColor(239, 239, 239);
        
    }
    return _label3;
}

-(UILabel *)label4{
    if (!_label4) {
        _label4 = [[UILabel alloc]init];
        _label4.backgroundColor = RGBColor(239, 239, 239);
        
    }
    return _label4;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.bankNameLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.bankBranceLabel];
    [self addSubview:self.bankNumberLabel];
    [self addSubview:self.bankCartTypeLabel];
    [self addSubview:self.name];
    [self addSubview:self.bankBrance];
    [self addSubview:self.bankName];
    [self addSubview:self.bankNumber];
    [self addSubview:self.bankCartType];
    [self addSubview:self.label3];
    [self addSubview:self.label2];
    [self addSubview:self.label1];
    [self addSubview:self.label4];
    
    [self updateConstraints];
}

-(void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.left.equalTo(_nameLabel.mas_right).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label1.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(_bankNameLabel.mas_right).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankNameLabel.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_bankBranceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label2.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_bankBrance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label2.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(_bankBranceLabel.mas_right).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankBranceLabel.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_bankCartTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label4.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_bankCartType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label4.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(_bankCartTypeLabel.mas_right).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankCartTypeLabel.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_bankNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label3.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_bankNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label3.mas_bottom).with.offset(20*AppScale);
        make.left.equalTo(_bankNumberLabel.mas_right).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
}

#pragma mark - setter getter
-(void)setAccountCardBankListModel:(CLSHAccountCardBankListModel *)accountCardBankListModel
{
    _accountCardBankListModel = accountCardBankListModel;
    _name.text = accountCardBankListModel.bankAccountName;
    _bankName.text = accountCardBankListModel.bankCategory;
    _bankBrance.text = accountCardBankListModel.bankBranchName;
    _bankNumber.text = accountCardBankListModel.bankAccountNumber;
    if ([accountCardBankListModel.bankType isEqualToString:@"debit"]) {
        _bankCartType.text = @"借记卡";
    }else if ([accountCardBankListModel.bankType isEqualToString:@"credit"])
    {
        _bankCartType.text = @"信用卡";
    }else if ([accountCardBankListModel.bankType isEqualToString:@"company"])
    {
        _bankCartType.text = @"对公账户";
    }
}

@end
