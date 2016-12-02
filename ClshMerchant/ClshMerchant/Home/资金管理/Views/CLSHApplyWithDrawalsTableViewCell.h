//
//  CLSHApplyWithDrawalsTableViewCell.h
//  ClshMerchant
//
//  Created by arom on 16/9/2.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^applyDrawalsBlock)();
typedef void(^moneyDetailBlock)();

@interface CLSHApplyWithDrawalsTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel * normalLabel;
@property (nonatomic,strong)UIButton * moneyDetailBtn;
@property (nonatomic,strong)UILabel * activeMoneyLabel;
@property (nonatomic,strong)UILabel * unActiveMoneyLabel;
@property (nonatomic,strong)UIButton * applyDrawalsBtn;

@property (nonatomic,copy)applyDrawalsBlock applyDrawalsblock;
@property (nonatomic,copy)moneyDetailBlock moneyDetailblock;
@end
