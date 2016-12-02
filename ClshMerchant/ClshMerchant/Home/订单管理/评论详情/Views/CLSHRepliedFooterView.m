//
//  CLSHRepliedFooterView.m
//  ClshMerchant
//
//  Created by arom on 16/8/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHRepliedFooterView.h"
#import "CLSHOrderManageModel.h"

@interface CLSHRepliedFooterView (){

    CGFloat contentHeight;
}

@end

@implementation CLSHRepliedFooterView

#pragma mark -- 懒加载

- (UIImageView *)iconView{

    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 15*AppScale;
    }
    return _iconView;
}

- (UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"安息香";
        _nameLabel.textColor = RGBColor(102, 102, 102);
        _nameLabel.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2016.06.03";
        _timeLabel.textColor = RGBColor(102, 102, 102);
        _timeLabel.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{

    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"很好吃，服务很赞，物流很快，果断好评啊，为了凑满15个字我也是蛮拼的";
        _contentLabel.textColor = RGBColor(53, 53, 53);
        _contentLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(30*AppScale));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_iconView.mas_right).with.offset(10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(120*AppScale));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(130*AppScale));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_iconView.mas_bottom).with.offset(0*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
    }];
    
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(contentHeight));
    }];
}

- (void)setModel:(CLSHAnswerCommentDataModel *)model{

    _model = model;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"OrderImage"]];
    _nameLabel.text = @"商家回复";
    NSDate * date = [[KBDateFormatter shareInstance] dateFromTimeInterval:([model.createDat doubleValue]/1000.0)];
    NSString * timeStr = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.timeLabel.text = timeStr;
    
    self.contentLabel.text = model.Content;
    
    CGSize size = [NSString sizeWithStr:model.Content font:[UIFont systemFontOfSize:10*AppScale] width:SCREENWIDTH-20];
    contentHeight = size.height;
}

@end
