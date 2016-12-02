//
//  CLSHSelectUserCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/2.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSelectUserCell.h"
#import "CLSHAdManagerModel.h"

@interface CLSHSelectUserCell ()
{
    CGFloat userNameWidth;  ///<用户名宽度
}

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UIImageView *sexIcon;
@property (nonatomic, strong)UIImageView *locationIcon;
@property (nonatomic, strong)UILabel *distance;
@property (nonatomic, strong)UILabel *middleLine;
@property (nonatomic, strong)UILabel *subtitle;
@property (nonatomic, strong)UILabel *totalConsume;
@property (nonatomic, strong)UILabel *totalMoney;
@end

@implementation CLSHSelectUserCell

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"SelectOtherCircle"];
    }
    return _icon;
}

-(UIImageView *)sexIcon
{
    if (!_sexIcon) {
        _sexIcon = [[UIImageView alloc] init];
        _sexIcon.image = [UIImage imageNamed:@"WomenIcon"];
    }
    return _sexIcon;
}

-(UIImageView *)locationIcon
{
    if (!_locationIcon) {
        _locationIcon = [[UIImageView alloc] init];
        _locationIcon.image = [UIImage imageNamed:@"LocationIcon"];
    }
    return _locationIcon;
}

-(UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:12*AppScale];
        _title.text = @"比尔盖茨";
    }
    return _title;
}

-(UILabel *)distance
{
    if (!_distance) {
        _distance = [[UILabel alloc] init];
        _distance.textAlignment = NSTextAlignmentCenter;
        _distance.text = @"660m";
        _distance.textColor = RGBColor(177, 177, 177);
        _distance.font = [UIFont systemFontOfSize:11*AppScale];
    }
    return _distance;
}

-(UILabel *)middleLine
{
    if (!_middleLine) {
        _middleLine = [[UILabel alloc] init];
        _middleLine.backgroundColor = RGBColor(200, 199, 204);
    }
    return _middleLine;
}

-(UILabel *)subtitle
{
    if (!_subtitle) {
        _subtitle = [[UILabel alloc] init];
        _subtitle.text = @"时尚是我的坐标，自信是我的座右铭！";
        _subtitle.font = [UIFont systemFontOfSize:10*AppScale];
        _subtitle.textColor = RGBColor(128, 128, 128);
    }
    return _subtitle;
}

-(UILabel *)totalConsume
{
    if (!_totalConsume) {
        _totalConsume = [[UILabel alloc] init];
        _totalConsume.text = @"累积消费：168次";
        _totalConsume.font = [UIFont systemFontOfSize:8*AppScale];
        _totalConsume.textColor = RGBColor(128, 128, 128);
        [NSString labelString:_totalConsume font:[UIFont systemFontOfSize:8*AppScale] range:NSMakeRange(5, _totalConsume.text.length-5) color:[UIColor redColor]];
    }
    return _totalConsume;
}

-(UILabel *)totalMoney
{
    if (!_totalMoney) {
        _totalMoney = [[UILabel alloc] init];
        _totalMoney.text = @"消费总金额：￥1680.00";
        _totalMoney.font = [UIFont systemFontOfSize:8*AppScale];
        _totalMoney.textColor = RGBColor(128, 128, 128);
        [NSString labelString:_totalMoney font:[UIFont systemFontOfSize:8*AppScale] range:NSMakeRange(6, _totalMoney.text.length-6) color:[UIColor redColor]];
        _totalMoney.textAlignment = NSTextAlignmentRight;
    }
    return _totalMoney;
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
    [self addSubview:self.icon];
    [self addSubview:self.sexIcon];
    [self addSubview:self.title];
    [self addSubview:self.locationIcon];
    [self addSubview:self.distance];
    [self addSubview:self.middleLine];
    [self addSubview:self.subtitle];
    [self addSubview:self.totalConsume];
    [self addSubview:self.totalMoney];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(70*AppScale, 70*AppScale));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
        make.left.equalTo(_icon.mas_right).offset(10*AppScale);
       make.height.mas_equalTo(@(15*AppScale));
    }];
    
    [_title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(userNameWidth));
    }];
    
    [_sexIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
        make.left.equalTo(_title.mas_right).offset(3*AppScale);
        make.size.mas_equalTo(CGSizeMake(10*AppScale, 15*AppScale));
    }];
    
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
        make.right.equalTo(weakSelf.mas_right);
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 15*AppScale));
    }];
    
    [_locationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15*AppScale);
        make.right.equalTo(_distance.mas_left);
        make.size.mas_equalTo(CGSizeMake(13*AppScale, 15*AppScale));
    }];
    
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_title.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_icon.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(1));
    }];
    
    [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middleLine.mas_bottom).offset(10*AppScale);
        make.left.equalTo(_icon.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
    [_totalConsume mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subtitle.mas_bottom).offset(5*AppScale);
        make.left.equalTo(_icon.mas_right).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-110*AppScale)/2, 15*AppScale));
    }];
    
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_subtitle.mas_bottom).offset(5*AppScale);
        make.left.equalTo(_totalConsume.mas_right);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(15*AppScale));
    }];
}

#pragma mark - setter getter
-(void)setUserListModel:(CLSHAddAdSelectUsersListModel *)userListModel
{
    _userListModel = userListModel;
    [_icon sd_setImageWithURL:[NSURL URLWithString:userListModel.avatar] placeholderImage:nil];
    _title.text = userListModel.userName;
    CGSize titleSize = [NSString sizeWithStr:_title.text font:[UIFont systemFontOfSize:13*AppScale] width:120];
    userNameWidth = titleSize.width;
    
    
    if (userListModel.distance) {
        if (userListModel.distance>=1000) {
            _distance.text = [NSString stringWithFormat:@"%.1fkm", userListModel.distance/1000];
        }else{
            _distance.text = [NSString stringWithFormat:@"%.1fm", userListModel.distance];
        }
    }
    
    _totalConsume.text = [NSString stringWithFormat:@"累积消费：%ld次", userListModel.consumptionCount];
    [NSString labelString:_totalConsume font:[UIFont systemFontOfSize:8*AppScale] range:NSMakeRange(5, _totalConsume.text.length-5) color:[UIColor redColor]];
    
    NSString *totalMoneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:userListModel.consumptionAmount]];
    _totalMoney.text = [NSString stringWithFormat:@"消费总金额：%@", totalMoneyStr];
    [NSString labelString:_totalMoney font:[UIFont systemFontOfSize:8*AppScale] range:NSMakeRange(6, _totalMoney.text.length-6) color:[UIColor redColor]];
    if ([userListModel.gender isEqualToString:@"male"]) {
        _sexIcon.image = [UIImage imageNamed:@"ManIcon"];
    }else if ([userListModel.gender isEqualToString:@"female"])
    {
         _sexIcon.image = [UIImage imageNamed:@"WomenIcon"];
    }else
    {
        _sexIcon.image = [UIImage imageNamed:@"OthersIcon"];
    }
}

@end
