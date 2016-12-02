//
//  CLGSPaymentOrderSecondCell.h
//  粗粮
//
//  Created by 吴桃波 on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHAccountIncomeDetailModel;
@interface CLGSPaymentOrderSecondCell : UITableViewCell

/** 收支明细详情 */
@property (nonatomic, strong) CLSHAccountIncomeDetailModel *incomeAndExpendDetailModel;
@end
