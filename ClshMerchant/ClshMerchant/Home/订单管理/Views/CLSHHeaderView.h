//
//  CLSHHeaderView.h
//  ClshMerchant
//
//  Created by arom on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHOderListModel;
@interface CLSHHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel * orderTimeLabel;      ///<下单时间
@property (nonatomic,strong)UILabel * timeLabel;           ///<时间
@property (nonatomic,strong)UILabel * stateLabel;          ///<状态
@property (nonatomic,strong)UIView * bottonView;           ///<底部留白

@property (nonatomic,strong)CLSHOderListModel * model;     ///<model

@end
