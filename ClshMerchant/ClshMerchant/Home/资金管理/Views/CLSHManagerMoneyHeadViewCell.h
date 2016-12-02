//
//  CLSHManagerMoneyHeadViewCell.h
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

typedef void(^detailIncomeBlock)();

@interface CLSHManagerMoneyHeadViewCell : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel * unCaculatorMoneyLabel;
@property (nonatomic,strong)UIButton * detailIncomeBtn;

@property (nonatomic,copy)detailIncomeBlock detailIncomeblock;

@end
