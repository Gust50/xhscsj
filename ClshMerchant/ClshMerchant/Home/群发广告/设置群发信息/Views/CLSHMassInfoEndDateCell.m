//
//  CLSHMassInfoEndDateCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMassInfoEndDateCell.h"

@interface CLSHMassInfoEndDateCell ()
@property (nonatomic, strong)UILabel *endDate;
@property (nonatomic, strong)UITextField *inputYear;
@property (nonatomic, strong)UIButton *deadLineBtn;

@end

@implementation CLSHMassInfoEndDateCell

-(UILabel *)endDate
{
    if (!_endDate) {
        _endDate = [[UILabel alloc] init];
        _endDate.font = [UIFont systemFontOfSize:12*AppScale];
        _endDate.text = @"截止日期:";
        
    }
    return _endDate;
}

-(UITextField *)inputYear
{
    if (!_inputYear) {
        _inputYear = [[UITextField alloc] init];
        _inputYear.font = [UIFont systemFontOfSize:11*AppScale];
        _inputYear.placeholder = @"请选择日期";
    }
    return _inputYear;
}

-(UIButton *)deadLineBtn{
    if (!_deadLineBtn) {
        _deadLineBtn=[UIButton buttonWithType:0];
        _deadLineBtn.backgroundColor=[UIColor clearColor];
        _deadLineBtn.timeInterval=0.2;
        [_deadLineBtn addTarget:self action:@selector(datePickerBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deadLineBtn;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.endDate];
    [self addSubview:self.inputYear];
    [self.inputYear addSubview:self.deadLineBtn];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_endDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
        
    }];
    
    [_inputYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_endDate.mas_right).offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo((20*AppScale));
    }];
    
    [_deadLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_inputYear).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

-(void)datePickerBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker)]) {
        [self.delegate datePicker];
    }
}

#pragma makr <getter setter>
-(void)setShowDatePickerTime:(NSString *)showDatePickerTime{
    _showDatePickerTime = showDatePickerTime;
    _inputYear.text = showDatePickerTime;
}

@end
