//
//  CLSHOrderTableViewCell.h
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

@class CLSHOrderDetailGoodsListModel;
@class CLSHOrderModel;
@interface CLSHOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsSpecificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;

@property (nonatomic,strong) CLSHOrderDetailGoodsListModel *model;
@property (nonatomic,strong) CLSHOrderModel * orderListModel;
@end
