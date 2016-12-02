//
//  CLSHSelectIndustryCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSelectIndustryCell.h"
#import "CLSHMerchantJoinModel.h"

@interface CLSHSelectIndustryCell ()

@end
@implementation CLSHSelectIndustryCell

#pragma makr <lazyLoad>
-(UILabel *)industryName{
    if (!_industryName) {
        _industryName=[[UILabel alloc]init];
        _industryName.backgroundColor = [UIColor whiteColor];
        _industryName.font = [UIFont systemFontOfSize:11*AppScale];
        _industryName.textAlignment = NSTextAlignmentCenter;
        _industryName.text = @"红烧豆腐";
    }
    return _industryName;
}

#pragma mark <init>
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.industryName];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_industryName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).offset(5*AppScale);
        make.left.equalTo(weakSelf.mas_left).offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(5*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(5*AppScale);
    }];
}


-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (selected) {
        self.industryName.layer.borderColor = systemColor.CGColor;
        self.industryName.layer.borderWidth = 1;
        
    }else
    {
        self.industryName.layer.borderWidth = 0;
    }
}

-(void)setMerchantJoinListListModel:(CLSHMerchantJoinListListModel *)merchantJoinListListModel
{
    _merchantJoinListListModel = merchantJoinListListModel;
    _industryName.text = merchantJoinListListModel.name;
}

@end
