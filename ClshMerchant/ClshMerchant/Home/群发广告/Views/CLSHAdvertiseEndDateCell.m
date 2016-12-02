//
//  CLSHAdvertiseEndDateCell.m
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


#import "CLSHAdvertiseEndDateCell.h"
#import "CLSHAdManagerModel.h"

@interface CLSHAdvertiseEndDateCell ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *date;

@end
@implementation CLSHAdvertiseEndDateCell

#pragma mark - lazyLoad
-(UILabel *)date
{
    if (!_date) {
        _date = [[UILabel alloc] init];
        _date.text = @"2016-07-26 12:00:00";
        _date.textColor = RGBColor(75, 75, 75);
        _date.textAlignment = NSTextAlignmentRight;
        _date.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _date;
}

-(UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = @"截止日期";
        _dateLabel.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _dateLabel;
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
    [self addSubview:self.dateLabel];
    [self addSubview:self.date];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_dateLabel.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
}

- (void)setModel:(CLSHAdDetailManagerModel *)model{

    _model = model;
    NSDate * date = [[KBDateFormatter shareInstance] dateFromTimeInterval:([model.expiredDate doubleValue]/1000.0)];
    NSString * timeStr = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.date.text = timeStr;
}

@end
