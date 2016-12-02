//
//  CLSHJoinDiscountView.m
//  ClshMerchant
//
//  Created by arom on 16/9/27.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHJoinDiscountView.h"
#import "CLSHSelectDiscountView.h"
#import "CLSHHomeModel.h"

@interface CLSHJoinDiscountView (){

    
    CLSHDiscountdataModel * discountDataModel;
}


@end
@implementation CLSHJoinDiscountView

#pragma mark -- 懒加载
- (CLSHSelectDiscountView *)discountView{

    if (!_discountView) {
        _discountView = [[CLSHSelectDiscountView alloc] initWithFrame:CGRectMake(80*AppScale, 214*AppScale, 150*AppScale, 150*AppScale)];
        _discountView.layer.masksToBounds = YES;
        _discountView.layer.cornerRadius = 5;
        _discountView.layer.borderWidth = 1;
        _discountView.layer.borderColor = RGBColor(102, 102, 102).CGColor;
    }
    return _discountView;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self loadDiscountListData];
    WS(weakSelf);
    self.discountView.selectDiscountblock = ^(NSInteger row){
    
        //[weakSelf removeFromSuperview];
        if (weakSelf.joinDiscountblock) {
            weakSelf.joinDiscountblock(row);
        }
    };
}

#pragma mark - loaddiscountListData
- (void)loadDiscountListData{
    
    discountDataModel = [[CLSHDiscountdataModel alloc]init];
    [discountDataModel fetchDiscountData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            discountDataModel = result;
            self.dataArray = [NSMutableArray arrayWithArray:discountDataModel.modelMapList];
            self.discountView.dataSource = self.dataArray;
            [self addSubview:self.discountView];
        }else{
        }
    }];
}


@end
