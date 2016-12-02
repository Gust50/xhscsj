//
//  CLSHJoinDiscountView.h
//  ClshMerchant
//
//  Created by arom on 16/9/27.
//  Copyright © 2016年 50. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHSelectDiscountView;

typedef void(^joinDiscountBlock)(NSInteger row);
@interface CLSHJoinDiscountView : UIView

@property (nonatomic,strong)CLSHSelectDiscountView * discountView;
@property (nonatomic,strong)NSMutableArray * dataArray;    //数组

@property (nonatomic,copy)joinDiscountBlock joinDiscountblock;

@end
