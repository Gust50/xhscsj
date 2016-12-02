//
//  CLSHWithdrawalsRecordCell.m
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


#import "CLSHWithdrawalsRecordCell.h"
#import "CLSHWithdrawalsRecordModel.h"

@interface CLSHWithdrawalsRecordCell ()

@property (nonatomic, strong) UILabel *describe;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *money;
@property (nonatomic, strong) UILabel *state;

@end

@implementation CLSHWithdrawalsRecordCell

#pragma mark - lazyLoad
-(UILabel *)describe
{
    if (!_describe) {
        _describe = [[UILabel alloc] init];
        _describe.font = [UIFont systemFontOfSize:13*AppScale];
        _describe.textColor = RGBColor(53, 53, 53);
        _describe.text = @"提现至银行卡";
    }
    return _describe;
}

-(UILabel *)time
{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:11*AppScale];
        _time.textColor = RGBColor(170, 170, 170);
        _time.text = @"2016-07-26 10:20";
    }
    return _time;
}

-(UILabel *)money
{
    if (!_money) {
        _money = [[UILabel alloc] init];
        _money.font = [UIFont systemFontOfSize:15*AppScale];
        _money.text = @"￥58.00";
        _money.textAlignment = NSTextAlignmentRight;
        
    }
    return _money;
}

-(UILabel *)state
{
    if (!_state) {
        _state = [[UILabel alloc] init];
        _state.font = [UIFont systemFontOfSize:11*AppScale];
        _state.textColor = RGBColor(170, 170, 170);
        _state.text = @"提现成功";
        _state.textAlignment = NSTextAlignmentRight;
    }
    return _state;
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
    [self addSubview:self.describe];
    [self addSubview:self.time];
    [self addSubview:self.money];
    [self addSubview:self.state];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(150*AppScale, 20*AppScale));
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_describe.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(150*AppScale, 20*AppScale));
    }];
    
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10*AppScale);
        make.left.equalTo(_describe.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_money.mas_bottom);
        make.left.equalTo(_time.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

-(void)setListModel:(CLSHWithdrawalsRecordListModel *)listModel
{
    _listModel = listModel;
    if ([listModel.withDrawStatus isEqualToString:@"processing" ]) {
        self.state.text = @"处理中";
    }else if ([listModel.withDrawStatus isEqualToString:@"transferred" ])
    {
        self.state.text = @"已经到账";
    }else if ([listModel.withDrawStatus isEqualToString:@"rejected" ])
    {
        self.state.text = @"申请失败";
    }
    
    NSString *withDrawAmount = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat: listModel.withDrawAmount]];
    self.money.text = withDrawAmount;
    
    //时间戳
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([listModel.withDrawCreateDate doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.time.text = timeString;
}

@end
