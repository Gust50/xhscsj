//
//  CLSHBottomView.h
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

typedef void(^selectAllBlock)(BOOL isSelect);
typedef void(^sureSettleBlock)();
@interface CLSHBottomView : UIView

@property (nonatomic,strong)UIButton * selectBtn; //选择按钮
@property (nonatomic,strong)UILabel * sumMoneyLabel;
@property (nonatomic,strong)UIButton * sureSettle;

@property (nonatomic,copy)selectAllBlock selectAllblock;
@property (nonatomic,copy)sureSettleBlock sureSettleblock;
@end
