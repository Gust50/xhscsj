//
//  CLSHAdvertiseManagementCell.m
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


#import "CLSHAdvertiseManagementCell.h"
#import "CLSHAdManagerModel.h"

@interface CLSHAdvertiseManagementCell ()

@property (nonatomic, strong)UILabel *describe;
@property (nonatomic, strong)UILabel *firstLine;
@property (nonatomic, strong)UILabel *browseNum;
@property (nonatomic, strong)UILabel *browseLabel;
@property (nonatomic, strong)UILabel *walletNum;
@property (nonatomic, strong)UILabel *walletLabel;
@property (nonatomic, strong)UILabel *couponNum;
@property (nonatomic, strong)UILabel *couponLabel;
@property (nonatomic, strong)UILabel *secondLine;
@property (nonatomic, strong)UILabel *time;
@property (nonatomic, strong)UIButton *lookAdv;

@end

@implementation CLSHAdvertiseManagementCell

#pragma mark - lazyLoad
-(UILabel *)describe
{
    if (!_describe) {
        _describe = [[UILabel alloc] init];
        _describe.font = [UIFont systemFontOfSize:14*AppScale];
        _describe.text = @"端午节优惠大酬宾, 仅限制3天！";
    }
    return _describe;
}

-(UILabel *)firstLine
{
    if (!_firstLine) {
        _firstLine = [[UILabel alloc] init];
        _firstLine.backgroundColor = RGBColor(227, 227, 227);
    }
    return _firstLine;
}

-(UILabel *)secondLine
{
    if (!_secondLine) {
        _secondLine = [[UILabel alloc] init];
        _secondLine.backgroundColor = RGBColor(227, 227, 227);
    }
    return _secondLine;
}

-(UILabel *)browseNum
{
    if (!_browseNum) {
        _browseNum = [[UILabel alloc] init];
        _browseNum.font = [UIFont systemFontOfSize:16*AppScale];
        _browseNum.text = @"160人";
        _browseNum.textAlignment = NSTextAlignmentCenter;
        _browseNum.textColor = [UIColor redColor];
        [NSString labelString:_browseNum font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(_browseNum.text.length-1, 1) color:RGBColor(60, 60, 60)];
    }
    return _browseNum;
}

-(UILabel *)browseLabel
{
    if (!_browseLabel) {
        _browseLabel = [[UILabel alloc] init];
        _browseLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _browseLabel.text = @"浏览人数";
        _browseLabel.textAlignment = NSTextAlignmentCenter;
        _browseLabel.textColor = RGBColor(123, 123, 123);
    }
    return _browseLabel;
}

-(UILabel *)walletNum
{
    if (!_walletNum) {
        _walletNum = [[UILabel alloc] init];
        _walletNum.font = [UIFont systemFontOfSize:16*AppScale];
        _walletNum.text = @"160个";
        _walletNum.textAlignment = NSTextAlignmentCenter;
        _walletNum.textColor = [UIColor redColor];
        [NSString labelString:_walletNum font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(_walletNum.text.length-1, 1) color:RGBColor(60, 60, 60)];
    }
    return _walletNum;
}

-(UILabel *)walletLabel
{
    if (!_walletLabel) {
        _walletLabel = [[UILabel alloc] init];
        _walletLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _walletLabel.text = @"已领取红包";
        _walletLabel.textAlignment = NSTextAlignmentCenter;
        _walletLabel.textColor = RGBColor(123, 123, 123);
    }
    return _walletLabel;
}

-(UILabel *)couponNum
{
    if (!_couponNum) {
        _couponNum = [[UILabel alloc] init];
        _couponNum.font = [UIFont systemFontOfSize:16*AppScale];
        _couponNum.text = @"160张";
        _couponNum.textAlignment = NSTextAlignmentCenter;
        _couponNum.textColor = [UIColor redColor];
        [NSString labelString:_couponNum font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(_couponNum.text.length-1, 1) color:RGBColor(60, 60, 60)];
    }
    return _couponNum;
}

-(UILabel *)couponLabel
{
    if (!_couponLabel) {
        _couponLabel = [[UILabel alloc] init];
        _couponLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _couponLabel.text = @"已领取抵扣券";
        _couponLabel.textAlignment = NSTextAlignmentCenter;
        _couponLabel.textColor = RGBColor(123, 123, 123);
    }
    return _couponLabel;
}

-(UILabel *)time
{
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:12*AppScale];
        _time.textColor = RGBColor(104, 104, 104);
        _time.text = @"2016-07-26 10:27:30";
    }
    return _time;
}

-(UIButton *)lookAdv
{
    if (!_lookAdv) {
        _lookAdv = [[UIButton alloc] init];
        _lookAdv.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_lookAdv setTitle:@"查看" forState:UIControlStateNormal];
        [_lookAdv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _lookAdv.backgroundColor = systemColor;
        _lookAdv.layer.cornerRadius = 5.0;
        _lookAdv.layer.masksToBounds = YES;
        [_lookAdv addTarget:self action:@selector(lookAdvertiseDetail) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookAdv;
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
    [self addSubview:self.firstLine];
    [self addSubview:self.secondLine];
    [self addSubview:self.browseNum];
    [self addSubview:self.browseLabel];
    [self addSubview:self.walletNum];
    [self addSubview:self.walletLabel];
    [self addSubview:self.couponNum];
    [self addSubview:self.couponLabel];
    [self addSubview:self.time];
    [self addSubview:self.lookAdv];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(25*AppScale));
    }];
    
    [_firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_describe.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_browseNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstLine.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 20*AppScale));
    }];
    
    [_browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_browseNum.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 20*AppScale));
    }];
    
    [_walletNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstLine.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_browseNum.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 20*AppScale));
    }];
    
    [_walletLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_walletNum.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_browseLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 20*AppScale));
    }];
    
    [_couponNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstLine.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_walletNum.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 20*AppScale));
    }];
    
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_couponNum.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_walletLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/3, 20*AppScale));
    }];
    
    [_secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_browseLabel.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_lookAdv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondLine.mas_bottom).offset(10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.width.mas_equalTo(@(100*AppScale));
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondLine.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(_lookAdv.mas_left).offset(-10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10*AppScale);
    }];
}

//查看广告详情
- (void)lookAdvertiseDetail
{
    if (self.lookAdvertiseDetailBlock) {
        self.lookAdvertiseDetailBlock();
    }
}

- (void)setModel:(CLSHAdListModel *)model{

    _model = model;
    self.describe.text = model.title;
    self.browseNum.text = [NSString stringWithFormat:@"%ld人",model.browseCount];
    [NSString labelString:_browseNum font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(_browseNum.text.length-1, 1) color:RGBColor(60, 60, 60)];
    self.walletNum.text = [NSString stringWithFormat:@"%ld个",model.luckyDrawCatchedCount];
    [NSString labelString:_walletNum font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(_walletNum.text.length-1, 1) color:RGBColor(60, 60, 60)];
    self.couponNum.text = [NSString stringWithFormat:@"%ld张",model.couponCatchedCount];
    [NSString labelString:_couponNum font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(_couponNum.text.length-1, 1) color:RGBColor(60, 60, 60)];
    NSDate * date = [[KBDateFormatter shareInstance] dateFromTimeInterval:([model.createDate doubleValue]/1000.0)];
    NSString * timeStr = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.time.text = timeStr;
}

@end
