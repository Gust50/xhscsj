//
//  CLSHHeaderView.m
//  ClshMerchant
//
//  Created by arom on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHHeaderView.h"
#import "CLSHOrderManageModel.h"
#import "KBDateFormatter.h"

@implementation CLSHHeaderView

#pragma mark --懒加载
- (UILabel *)orderTimeLabel{

    if (!_orderTimeLabel) {
        _orderTimeLabel = [[UILabel alloc] init];
        _orderTimeLabel.text = @"下单时间";
        _orderTimeLabel.textColor = RGBColor(102, 102, 102);
        _orderTimeLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _orderTimeLabel;
}

- (UILabel *)timeLabel{

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2016-06-03";
        _timeLabel.textColor = RGBColor(51, 51, 51);
        _timeLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _timeLabel;
}

- (UILabel *)stateLabel{

    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"已付款";
        _stateLabel.textColor = RGBColor(51, 51, 51);
        _stateLabel.textAlignment = NSTextAlignmentRight;
        _stateLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _stateLabel;
}

- (UIView *)bottonView{
    
    if (!_bottonView) {
        _bottonView = [[UIView alloc] init];
        _bottonView.backgroundColor = backGroundColor;
    }
    return _bottonView;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.frame = CGRectMake(0, 10, SCREENWIDTH, 30*AppScale);
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark --init UI
- (void)initUI{

    [self addSubview:self.orderTimeLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.stateLabel];
    [self addSubview:self.bottonView];

    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    
    [_orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.mas_centerY);
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(8*AppScale);
        make.height.equalTo(@(20));
        make.width.equalTo(@(60*AppScale));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.mas_centerY);
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.left.equalTo(_orderTimeLabel.mas_right).with.offset(8*AppScale);
        make.height.equalTo(@20);
        make.width.equalTo(@(150*AppScale));
    }];
    
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.mas_centerY);
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.equalTo(@(20));
        make.left.equalTo(_timeLabel.mas_right).with.offset(8*AppScale);
    }];
    [_bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.height.equalTo(@(10*AppScale));
        
    }];
}

- (void)setModel:(CLSHOderListModel *)model{

    _model = model;
     NSDate * date = [[KBDateFormatter shareInstance] dateFromTimeInterval:([model.createTime doubleValue]/1000.0)];
    NSString * timeStr = [[KBDateFormatter shareInstance] stringFromDate:date];
    _timeLabel.text = timeStr;
    
    if ([model.status isEqualToString:@"pendingShipment"]) {
        //已付款
        _stateLabel.text = @"已付款";
    }else if ([model.status isEqualToString:@"shipped"]){
        //配送中
        _stateLabel.text = @"配送中";
    }else if ([model.status isEqualToString:@"pendingReview"]){
        //退款申请
        _stateLabel.text = @"退款中";
    }else if ([model.status isEqualToString:@"customerReviewed"]){
        //已评论
        _stateLabel.text = @"已评论";
    }else if ([model.status isEqualToString:@"ownerReplied"]){
        //已回评
        _stateLabel.text = @"已回评";
    }else if ([model.status isEqualToString:@"completed"]){
        //已完成
        _stateLabel.text = @"已完成";
    }else if ([model.status isEqualToString:@"received"]){
    
        _stateLabel.text = @"待评价";
    }
    
}

@end
