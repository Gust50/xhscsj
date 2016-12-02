//
//  CLSHHomeTopViewCell.m
//  ClshMerchant
//
//  Created by kobe on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHHomeTopViewCell.h"
#import "CLSHHomeTopViewBtn.h"
#import "CLSHHomeModel.h"

@interface CLSHHomeTopViewCell ()
@property (nonatomic, strong) UILabel    *currentIncome;           ///<当前收入
@property (nonatomic, strong) UILabel    *income;                  ///<收入多少
@property (nonatomic, strong) UIButton   *withDrawBtn;             ///<提现
@property (nonatomic, strong) UIView     *splitHorizonLine;        ///<水平分割线

@property (nonatomic, strong) CLSHHomeTopViewBtn *visitor;          ///<今日访客
@property (nonatomic, strong) CLSHHomeTopViewBtn *totalIncome;      ///<累积收入
@property (nonatomic, strong) CLSHHomeTopViewBtn *totalSaleCount;   ///<总销量
@property (nonatomic, strong) UIView *splitLineOne;                 ///<分割线1
@property (nonatomic, strong) UIView *splitLineTwo;                 ///<分割线2
@end

@implementation CLSHHomeTopViewCell


-(UILabel *)currentIncome{
    if (!_currentIncome) {
        _currentIncome=[UILabel new];
        _currentIncome.text=@"当前收入";
        _currentIncome.font=[UIFont systemFontOfSize:12*AppScale];
        _currentIncome.textColor = RGBColor(133, 133, 133);
        _currentIncome.textAlignment=NSTextAlignmentCenter;
    }
    return _currentIncome;
}

-(UILabel *)income{
    if (!_income) {
        _income=[UILabel new];
//        _income.text=@"100000";
        _income.textColor = [UIColor redColor];
        _income.font=[UIFont systemFontOfSize:18*AppScale];
       _income.textAlignment=NSTextAlignmentCenter;
    }
    return _income;
}

-(UIButton *)withDrawBtn{
    if (!_withDrawBtn) {
        _withDrawBtn=[UIButton buttonWithType:0];
        [_withDrawBtn setTitle:@"申请提现" forState:0];
        _withDrawBtn.layer.borderColor=systemColor.CGColor;
        _withDrawBtn.layer.borderWidth=1;
        _withDrawBtn.layer.masksToBounds=YES;
        _withDrawBtn.layer.cornerRadius=5.0;
        _withDrawBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_withDrawBtn addTarget:self action:@selector(clickWithDrawBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_withDrawBtn setTitleColor:systemColor forState:0];
    }
    return _withDrawBtn;
}

-(UIView *)splitHorizonLine{
    if (!_splitHorizonLine) {
        _splitHorizonLine=[UIView new];
        _splitHorizonLine.backgroundColor=backGroundColor;
    }
    return _splitHorizonLine;
}

-(CLSHHomeTopViewBtn *)visitor{
    if (!_visitor) {
        _visitor=[CLSHHomeTopViewBtn new];
        _visitor.titleText=@"100人";
        _visitor.describeText=@"今日访客";
        _visitor.iconText=@"TodayVisitors";
    }
    return _visitor;
}

-(UIView *)splitLineOne{
    if (!_splitLineOne) {
        _splitLineOne=[UIView new];
        _splitLineOne.backgroundColor=backGroundColor;
    }
    return _splitLineOne;
}

-(CLSHHomeTopViewBtn *)totalIncome{
    if (!_totalIncome) {
        _totalIncome=[CLSHHomeTopViewBtn new];
        _totalIncome.titleText=@"100.00元";
        _totalIncome.describeText=@"累积收入";
        _totalIncome.iconText=@"TotalRevenue";
    }
    return _totalIncome;
}

-(UIView *)splitLineTwo{
    if (!_splitLineTwo) {
        _splitLineTwo=[UIView new];
        _splitLineTwo.backgroundColor=backGroundColor;
    }
    return _splitLineTwo;
}

-(CLSHHomeTopViewBtn *)totalSaleCount{
    if (!_totalSaleCount) {
        _totalSaleCount=[CLSHHomeTopViewBtn new];
        _totalSaleCount.titleText=@"800件";
        _totalSaleCount.describeText=@"总销量";
        _totalSaleCount.iconText=@"TotalSales";
    }
    return _totalSaleCount;
}



-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.currentIncome];
    [self addSubview:self.income];
    [self addSubview:self.withDrawBtn];
    [self addSubview:self.splitHorizonLine];
    [self addSubview:self.visitor];
    [self addSubview:self.totalIncome];
    [self addSubview:self.totalSaleCount];
    [self addSubview:self.splitLineOne];
    [self addSubview:self.splitLineTwo];
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_currentIncome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(20*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200*AppScale, 20*AppScale));
    }];
    
    [_income mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_currentIncome.mas_bottom).with.offset(5*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.mas_equalTo(@(SCREENWIDTH-25*AppScale));
        make.height.mas_equalTo(@(25*AppScale));
    }];
    
    [_withDrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_income.mas_bottom).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 30*AppScale));
    }];
    
    [_splitHorizonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_withDrawBtn.mas_bottom).with.offset(20*AppScale);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH-20*AppScale, 1));
    }];
    
    
    //以下是尝试使用masonry修改
    [_visitor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_splitHorizonLine.mas_bottom).with.offset(10*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-2)/3, 40*AppScale));
    }];
    
    [_splitLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_visitor.mas_right);
        make.top.equalTo(_visitor.mas_top).with.offset(5*AppScale);
        make.size.mas_equalTo(CGSizeMake(1, 40*AppScale));
    }];
    
    [_totalIncome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_splitLineOne.mas_right);
        make.top.equalTo(_visitor.mas_top);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-2)/3, 40*AppScale));
    }];
    
    [_splitLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalIncome.mas_right);
        make.top.equalTo(_visitor.mas_top).with.offset(5*AppScale);
        make.size.mas_equalTo(CGSizeMake(1, 40*AppScale));
    }];
    
    [_totalSaleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_splitLineTwo.mas_right);
        make.top.equalTo(_visitor.mas_top);
        make.size.mas_equalTo(CGSizeMake((SCREENWIDTH-2)/3, 40*AppScale));
    }];
    
}

#pragma mark - setter getter
-(void)setHomeModel:(CLSHHomeModel *)homeModel
{
    _homeModel = homeModel;
    NSString *str = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[homeModel.balance floatValue]]];
    _income.text = str;
    [NSString labelString:_income font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(_income.text.length-2, 2) color:[UIColor redColor]];
    _visitor.titleText = [NSString stringWithFormat:@"%@人", homeModel.todayVisitCount];
    _totalIncome.titleText = [NSString stringWithFormat:@"%.2f元", [homeModel.totalIncomeAmount floatValue]];
    _totalSaleCount.titleText = [NSString stringWithFormat:@"%@件", homeModel.totalSalesCount];

}

#pragma mark <otherResponse>
-(void)clickWithDrawBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithDrawBtn)]) {
        [self.delegate clickWithDrawBtn];
    }
}
@end
