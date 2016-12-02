//
//  CLSHOnSaleSegment.m
//  ClshMerchant
//
//  Created by kobe on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHOnSaleSegment.h"

@interface CLSHOnSaleSegment ()
@property (nonatomic, strong) UISegmentedControl *segment;
@end

@implementation CLSHOnSaleSegment

-(UISegmentedControl *)segment{
    if (!_segment) {
        _segment=[UISegmentedControl new];
        [_segment insertSegmentWithTitle:@"出售中" atIndex:0 animated:YES];
        [_segment insertSegmentWithTitle:@"已下架" atIndex:1 animated:YES];
        [_segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*AppScale],NSForegroundColorAttributeName:systemColor} forState:0];
        [_segment setTintColor:systemColor];
        [_segment addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
        _segment.selectedSegmentIndex=0;
    }
    return _segment;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.segment];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    
}


-(void)changeSegment:(UISegmentedControl *)segment{
    BOOL temp=NO;
    if (segment.selectedSegmentIndex==0) {
        temp=YES;
    }else if (segment.selectedSegmentIndex==1){
        temp=NO;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickSegment:)]) {
        [self.delegate clickSegment:temp];
    }
    
}

#pragma mark <getter setter>
-(void)setOnSaleText:(NSString *)onSaleText{
    [_segment setTitle:onSaleText forSegmentAtIndex:0];
}

-(void)setSaleOutText:(NSString *)saleOutText{
    [_segment setTitle:saleOutText forSegmentAtIndex:1];
}
@end
