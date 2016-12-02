//
//  CLSHImmedieatelySettleTableViewCell.h
//  ClshMerchant
//
//  Created by arom on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHSettleBalanceListModel;
@interface CLSHImmedieatelySettleTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView * selectIcon;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * sortLabel;
@property (nonatomic,strong)UILabel * sumMoneyLabel;
@property (nonatomic,strong)UILabel * predictLabel;

@property (nonatomic,strong)CLSHSettleBalanceListModel * model;

@end
