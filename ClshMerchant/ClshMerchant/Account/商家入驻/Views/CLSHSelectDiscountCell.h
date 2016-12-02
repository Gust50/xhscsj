//
//  CLSHSelectDiscountCell.h
//  ClshMerchant
//
//  Created by arom on 16/9/13.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^DiscountBlock)();

@interface CLSHSelectDiscountCell : UITableViewCell

@property (nonatomic,strong)UILabel * leftLabel;       ///<左侧文字
@property (nonatomic,strong)UIButton * selectBtn;      ///<选择折扣
@property (nonatomic,strong)UIImageView * arrowIcon;   ///<箭头

@property (nonatomic,copy)DiscountBlock Discountblock;

@end
