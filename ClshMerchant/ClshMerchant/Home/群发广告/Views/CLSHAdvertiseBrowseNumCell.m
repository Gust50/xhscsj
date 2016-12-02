//
//  CLSHAdvertiseBrowseNumCell.m
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


#import "CLSHAdvertiseBrowseNumCell.h"
#import "CLSHAdManagerModel.h"

@interface CLSHAdvertiseBrowseNumCell ()
@property (nonatomic, strong)UILabel *totalBrowseNum;
@property (nonatomic, strong)UILabel *line;
@property (nonatomic, strong)UILabel *wallet;
@property (nonatomic, strong)UILabel *getWalletNum;
@property (nonatomic, strong)UILabel *noGetWalletNum;
@property (nonatomic, strong)UILabel *middleLine;
@property (nonatomic, strong)UILabel *coupon;
@property (nonatomic, strong)UILabel *getCouponNum;
@property (nonatomic, strong)UILabel *noGetCouponNum;
@end
@implementation CLSHAdvertiseBrowseNumCell

#pragma mark - lazyLoad
-(UILabel *)totalBrowseNum
{
    if (!_totalBrowseNum) {
        _totalBrowseNum = [[UILabel alloc] init];
        _totalBrowseNum.text = @"累积浏览人数168人";
        _totalBrowseNum.font = [UIFont systemFontOfSize:14*AppScale];
        [NSString labelString:_totalBrowseNum font:[UIFont systemFontOfSize:14*AppScale] range:NSMakeRange(6, _totalBrowseNum.text.length - 7) color:[UIColor redColor]];
    }
    return _totalBrowseNum;
}

-(UILabel *)line
{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = RGBColor(231, 230, 231);
    }
    return _line;
}

-(UILabel *)wallet
{
    if (!_wallet) {
        _wallet = [[UILabel alloc] init];
        _wallet.font = [UIFont systemFontOfSize:12*AppScale];
        _wallet.text = @"红  包:";
        _wallet.textColor = RGBColor(78, 78, 78);
    }
    return _wallet;
}

-(UILabel *)getWalletNum
{
    if (!_getWalletNum) {
        _getWalletNum = [[UILabel alloc] init];
        _getWalletNum.font = [UIFont systemFontOfSize:12*AppScale];
        _getWalletNum.text = @"已领取268个";
        _getWalletNum.textColor = RGBColor(78, 78, 78);
        [NSString labelString:_getWalletNum font:[UIFont systemFontOfSize:16*AppScale] range:NSMakeRange(3, _getWalletNum.text.length-4) color:[UIColor redColor]];
    }
    return _getWalletNum;
}

-(UILabel *)noGetWalletNum
{
    if (!_noGetWalletNum) {
        _noGetWalletNum = [[UILabel alloc] init];
        _noGetWalletNum.font = [UIFont systemFontOfSize:12*AppScale];
        _noGetWalletNum.text = @"未领取268个";
        _noGetWalletNum.textColor = RGBColor(78, 78, 78);
        [NSString labelString:_noGetWalletNum font:[UIFont systemFontOfSize:16*AppScale] range:NSMakeRange(3, _noGetWalletNum.text.length-4) color:[UIColor redColor]];
    }
    return _noGetWalletNum;
}

-(UILabel *)middleLine
{
    if (!_middleLine) {
        _middleLine = [[UILabel alloc] init];
        _middleLine.backgroundColor = RGBColor(231, 230, 231);
    }
    return _middleLine;
}

-(UILabel *)coupon
{
    if (!_coupon) {
        _coupon = [[UILabel alloc] init];
        _coupon.font = [UIFont systemFontOfSize:12*AppScale];
        _coupon.text = @"优惠券:";
        _coupon.textColor = RGBColor(78, 78, 78);
    }
    return _coupon;
}

-(UILabel *)getCouponNum
{
    if (!_getCouponNum) {
        _getCouponNum = [[UILabel alloc] init];
        _getCouponNum.font = [UIFont systemFontOfSize:12*AppScale];
        _getCouponNum.text = @"已领取268张";
        _getCouponNum.textColor = RGBColor(78, 78, 78);
        [NSString labelString:_getCouponNum font:[UIFont systemFontOfSize:16*AppScale] range:NSMakeRange(3, _getCouponNum.text.length-4) color:[UIColor redColor]];
    }
    return _getCouponNum;
}

-(UILabel *)noGetCouponNum
{
    if (!_noGetCouponNum) {
        _noGetCouponNum = [[UILabel alloc] init];
        _noGetCouponNum.font = [UIFont systemFontOfSize:12*AppScale];
        _noGetCouponNum.text = @"未领取268张";
        _noGetCouponNum.textColor = RGBColor(78, 78, 78);
        [NSString labelString:_noGetCouponNum font:[UIFont systemFontOfSize:16*AppScale] range:NSMakeRange(3, _noGetCouponNum.text.length-4) color:[UIColor redColor]];
    }
    return _noGetCouponNum;
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
    [self addSubview:self.totalBrowseNum];
    [self addSubview:self.line];
    [self addSubview:self.wallet];
    [self addSubview:self.getWalletNum];
    [self addSubview:self.noGetWalletNum];
    [self addSubview:self.middleLine];
    [self addSubview:self.coupon];
    [self addSubview:self.getCouponNum];
    [self addSubview:self.noGetCouponNum];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_totalBrowseNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(20*AppScale);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalBrowseNum.mas_bottom).offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    [_wallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(15*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 20*AppScale));
    }];
    
    [_getWalletNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(15*AppScale);
        make.left.equalTo(_wallet.mas_right).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/2, 20*AppScale));
    }];
    
    [_noGetWalletNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).offset(15*AppScale);
        make.left.equalTo(_getWalletNum.mas_right);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wallet.mas_bottom).offset(15*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(1);
    }];
    
    [_coupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLine.mas_bottom).offset(15*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 20*AppScale));
    }];
    
    [_getCouponNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLine.mas_bottom).offset(15*AppScale);
        make.left.equalTo(_coupon.mas_right).offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-100*AppScale)/2, 20*AppScale));
    }];
    
    [_noGetCouponNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLine.mas_bottom).offset(15*AppScale);
        make.left.equalTo(_getCouponNum.mas_right);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

- (void)setModel:(CLSHAdDetailManagerModel *)model{

    _model = model;
    self.totalBrowseNum.text = [NSString stringWithFormat:@"累计浏览人次%ld人",model.browseCount];
    [NSString labelString:_totalBrowseNum font:[UIFont systemFontOfSize:14*AppScale] range:NSMakeRange(6, _totalBrowseNum.text.length - 7) color:[UIColor redColor]];
    self.getWalletNum.text = [NSString stringWithFormat:@"已领取%ld个",model.luckyDrawCatchedCount];
    [NSString labelString:_getWalletNum font:[UIFont systemFontOfSize:16*AppScale] range:NSMakeRange(3, _getWalletNum.text.length-4) color:[UIColor redColor]];
    self.noGetWalletNum.text = [NSString stringWithFormat:@"未领取%ld个",model.notReceiveLuckyDrawCount];
    [NSString labelString:_noGetWalletNum font:[UIFont systemFontOfSize:16*AppScale] range:NSMakeRange(3, _noGetWalletNum.text.length-4) color:[UIColor redColor]];
    self.getCouponNum.text = [NSString stringWithFormat:@"已领取%ld个",model.couponCatchedCount];[NSString labelString:_getCouponNum font:[UIFont systemFontOfSize:16*AppScale] range:NSMakeRange(3, _getCouponNum.text.length-4) color:[UIColor redColor]];
    self.noGetCouponNum.text = [NSString stringWithFormat:@"未领取%ld个",model.notReceiveCouponCount];
    [NSString labelString:_noGetCouponNum font:[UIFont systemFontOfSize:16*AppScale] range:NSMakeRange(3, _noGetCouponNum.text.length-4) color:[UIColor redColor]];
}

@end
