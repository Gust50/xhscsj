//
//  CLSHManagerMoneyFooterView.h
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

typedef void(^goImmediatelySettleVCBlock)();

@interface CLSHManagerMoneyFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel * describeLabel;
@property (nonatomic,strong)UIButton * immediatelyBalanceBtn;
@property (nonatomic,copy)goImmediatelySettleVCBlock goImmediatelySettleVCblock;

@end
