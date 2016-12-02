//
//  CLSHRecordDetailView.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHRecordDetailView.h"
#import "CLSHWithdrawalsRecordModel.h"

@interface CLSHRecordDetailView ()

@property (nonatomic, strong) UILabel *withdrawalsMoneyLabel;
@property (nonatomic, strong) UILabel *withdrawalsMoney;
@property (nonatomic, strong) UILabel *accountNameLabel;
@property (nonatomic, strong) UILabel *accountName;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UILabel *bank;
@property (nonatomic, strong) UILabel *bankCardNumLabel;
@property (nonatomic, strong) UILabel *bankCardNum;
@property (nonatomic, strong) UILabel *withdrawalsTimeLabel;
@property (nonatomic, strong) UILabel *withdrawalsTime;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) UILabel *line;

@end

@implementation CLSHRecordDetailView

#pragma mark - lazyLoad
-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBColor(232, 231, 231);
    }
    return _line;
}

-(UILabel *)withdrawalsMoneyLabel
{
    if (!_withdrawalsMoneyLabel) {
        _withdrawalsMoneyLabel = [[UILabel alloc] init];
        _withdrawalsMoneyLabel.text = @"提现金额";
        _withdrawalsMoneyLabel.font = [UIFont systemFontOfSize:13*AppScale];
        _withdrawalsMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _withdrawalsMoneyLabel.textColor = RGBColor(175, 175, 175);
    }
    return _withdrawalsMoneyLabel;
}

-(UILabel *)withdrawalsMoney
{
    if (!_withdrawalsMoney) {
        _withdrawalsMoney = [[UILabel alloc] init];
        _withdrawalsMoney.text = @"288";
        _withdrawalsMoney.font = [UIFont systemFontOfSize:18*AppScale];
        _withdrawalsMoney.textAlignment = NSTextAlignmentCenter;
        _withdrawalsMoney.textColor = [UIColor redColor];
        
    }
    return _withdrawalsMoney;
}

-(UILabel *)accountNameLabel
{
    if (!_accountNameLabel) {
        _accountNameLabel = [[UILabel alloc] init];
        _accountNameLabel.text = @"账户名称";
        _accountNameLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _accountNameLabel.textColor = RGBColor(175, 175, 175);
    }
    return _accountNameLabel;
}

-(UILabel *)accountName
{
    if (!_accountName) {
        _accountName = [[UILabel alloc] init];
        _accountName.text = @"刘涛";
        _accountName.textAlignment = NSTextAlignmentRight;
        _accountName.font = [UIFont systemFontOfSize:12*AppScale];
        _accountName.textColor = RGBColor(54, 54, 54);
    }
    return _accountName;
}

-(UILabel *)bankLabel
{
    if (!_bankLabel) {
        _bankLabel = [[UILabel alloc] init];
        _bankLabel.text = @"开 户 行";
        _bankLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _bankLabel.textColor = RGBColor(175, 175, 175);
    }
    return _bankLabel;
}

-(UILabel *)bank
{
    if (!_bank) {
        _bank = [[UILabel alloc] init];
        _bank.text = @"招商银行（个人账户）";
        _bank.textAlignment = NSTextAlignmentRight;
        _bank.font = [UIFont systemFontOfSize:12*AppScale];
        _bank.textColor = RGBColor(54, 54, 54);
    }
    return _bank;
}

-(UILabel *)bankCardNumLabel
{
    if (!_bankCardNumLabel) {
        _bankCardNumLabel = [[UILabel alloc] init];
        _bankCardNumLabel.text = @"银行卡号";
        _bankCardNumLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _bankCardNumLabel.textColor = RGBColor(175, 175, 175);
    }
    return _bankCardNumLabel;
}

-(UILabel *)bankCardNum
{
    if (!_bankCardNum) {
        _bankCardNum = [[UILabel alloc] init];
        _bankCardNum.text = @"6452 6545 0211 0122 023";
        _bankCardNum.textAlignment = NSTextAlignmentRight;
        _bankCardNum.font = [UIFont systemFontOfSize:12*AppScale];
        _bankCardNum.textColor = RGBColor(54, 54, 54);
    }
    return _bankCardNum;
}

-(UILabel *)withdrawalsTimeLabel
{
    if (!_withdrawalsTimeLabel) {
        _withdrawalsTimeLabel = [[UILabel alloc] init];
        _withdrawalsTimeLabel.text = @"提现时间";
        _withdrawalsTimeLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _withdrawalsTimeLabel.textColor = RGBColor(175, 175, 175);
    }
    return _withdrawalsTimeLabel;
}

-(UILabel *)withdrawalsTime
{
    if (!_withdrawalsTime) {
        _withdrawalsTime = [[UILabel alloc] init];
        _withdrawalsTime.text = @"2016-07-26 10:00";
        _withdrawalsTime.textAlignment = NSTextAlignmentRight;
        _withdrawalsTime.font = [UIFont systemFontOfSize:12*AppScale];
        _withdrawalsTime.textColor = RGBColor(54, 54, 54);
    }
    return _withdrawalsTime;
}

-(UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"当前状态";
        _stateLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _stateLabel.textColor = RGBColor(175, 175, 175);
    }
    return _stateLabel;
}

-(UILabel *)state
{
    if (!_state) {
        _state = [[UILabel alloc] init];
        _state.text = @"提现成功";
        _state.textAlignment = NSTextAlignmentRight;
        _state.font = [UIFont systemFontOfSize:12*AppScale];
        _state.textColor = RGBColor(54, 54, 54);
        
    }
    return _state;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.withdrawalsMoneyLabel];
    [self addSubview:self.withdrawalsMoney];
    [self addSubview:self.accountNameLabel];
    [self addSubview:self.accountName];
    [self addSubview:self.bankLabel];
    [self addSubview:self.bank];
    [self addSubview:self.bankCardNumLabel];
    [self addSubview:self.bankCardNum];
    [self addSubview:self.withdrawalsTimeLabel];
    [self addSubview:self.withdrawalsTime];
    [self addSubview:self.stateLabel];
    [self addSubview:self.state];
    [self addSubview:self.line];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_withdrawalsMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(30*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_withdrawalsMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawalsMoneyLabel.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(40*AppScale));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawalsMoney.mas_bottom).offset(30*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_accountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_accountName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(20*AppScale);
        make.left.equalTo(_accountNameLabel.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountNameLabel.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_bank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accountName.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_bankLabel.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_bankCardNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankLabel.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_bankCardNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bank.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_bankCardNumLabel.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_withdrawalsTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankCardNumLabel.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_withdrawalsTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankCardNum.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_withdrawalsTimeLabel.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawalsTimeLabel.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_withdrawalsTime.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_stateLabel.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
}

#pragma mark - setter getter
-(void)setDetailModel:(CLSHWithdrawalsRecordDetailModel *)detailModel
{
    _detailModel = detailModel;
    NSString *amountStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[detailModel.amount floatValue]]];
    _withdrawalsMoney.text = amountStr;
    [NSString labelString:_withdrawalsMoney font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(_withdrawalsMoney.text.length - 2, 2) color:[UIColor redColor]];
    _accountName.text = detailModel.userName;
    _bank.text = detailModel.bankAccountName;
    _bankCardNum.text = detailModel.bankAccountNumber;
    
    //时间戳
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([detailModel.startDate doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
    _withdrawalsTime.text = timeString;
    
    if ([detailModel.status isEqualToString:@"processing" ]) {
        _state.text = @"处理中";
    }else if ([detailModel.status isEqualToString:@"transferred" ])
    {
        _state.text = @"已经到账";
    }else if ([detailModel.status isEqualToString:@"rejected" ])
    {
        _state.text = @"申请失败";
    }
}

@end
