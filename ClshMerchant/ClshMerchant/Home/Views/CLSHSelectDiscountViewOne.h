//
//  CLSHSelectDiscountViewOne.h
//  ClshMerchant
//
//  Created by arom on 16/9/28.
//  Copyright © 2016年 50. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectDiscountBlockOne)(NSInteger row);

@interface CLSHSelectDiscountViewOne : UIView

@property (nonatomic,strong)NSMutableArray * dataSource;

@property (nonatomic,copy)selectDiscountBlockOne selectDiscountblockOne;


@end
