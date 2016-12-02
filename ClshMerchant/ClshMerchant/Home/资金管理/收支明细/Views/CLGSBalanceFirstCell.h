//
//  CLGSBalanceFirstCell.h
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHAccountIncomeModel;
//收支明细1
@interface CLGSBalanceFirstCell : UITableViewCell

/** 传入收入和支出数据模型*/
@property (nonatomic, strong) CLSHAccountIncomeModel *incomeAndExpendModel;
@end
