//
//  CLSHConmmetHeadView.h
//  ClshMerchant
//
//  Created by arom on 16/8/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>
@class CLSHCommentDataModel;
@interface CLSHConmmetHeadView : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel * describLabel;
@property (nonatomic,strong)UIView * starRateView;

@property (nonatomic,strong)CLSHCommentDataModel * model;

@end
