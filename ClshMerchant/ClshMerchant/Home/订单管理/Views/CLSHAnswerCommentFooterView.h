//
//  CLSHAnswerCommentFooterView.h
//  ClshMerchant
//
//  Created by arom on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHOderListModel;
typedef void(^stateButtonBlock)();

@interface CLSHAnswerCommentFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel * sortMoneyLabel;       ///<总金额
@property (nonatomic,strong)UILabel * moneyLabel;           ///<金额
@property (nonatomic,strong)UIButton * stateButton;         ///<状态

@property (nonatomic,copy)stateButtonBlock stateButtonblock;///<配送按钮block

@property (nonatomic,strong)CLSHOderListModel * model;     ///<model
@end
