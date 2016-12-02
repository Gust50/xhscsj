//
//  CLSHOtherFooterView.h
//  ClshMerchant
//
//  Created by arom on 16/8/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHOderListModel;
@interface CLSHOtherFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel * sortMoneyLabel;       ///<总金额
@property (nonatomic,strong)UILabel * moneyLabel;           ///<金额

@property (nonatomic,strong)CLSHOderListModel * model;     ///<model

@end
