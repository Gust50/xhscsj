//
//  CLSHConmmetHeadView.m
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


#import "CLSHConmmetHeadView.h"
#import "CLGSStarRate.h"
#import "CLSHOrderManageModel.h"

@interface CLSHConmmetHeadView (){

    CLGSStarRate *starRate;
}

@end

@implementation CLSHConmmetHeadView

#pragma mark -- 懒加载
- (UILabel *)describLabel{

    if (!_describLabel) {
        _describLabel = [[UILabel alloc] init];
        _describLabel.text = @"综合评分";
        _describLabel.textColor = RGBColor(53, 53, 53);
        _describLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _describLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _describLabel;
}

- (UIView *)starRateView{

    if (!_starRateView) {
        _starRateView = [[UIView alloc] init];
        _starRateView.userInteractionEnabled = NO;
//        _starRateView.backgroundColor = [UIColor cyanColor];
        
    }
    return _starRateView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.describLabel];
    [self addSubview:self.starRateView];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_describLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(60*AppScale));
    }];
    
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_describLabel.mas_right).with.offset(8*AppScale);
        
        make.height.equalTo(@(30*AppScale));
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
    }];
}

- (void)setModel:(CLSHCommentDataModel *)model{

    _model = model;
    
    starRate=[[CLGSStarRate alloc]initWithFrame:CGRectMake(5*AppScale, 0, 60*AppScale, 30*AppScale) numberOfStars:5];
    starRate.scorePercent= model.score/5;
    [self.starRateView addSubview:starRate];
}

@end
