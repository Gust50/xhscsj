//
//  CLSHOrderTableViewCell.m
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


#import "CLSHOrderTableViewCell.h"
#import "CLSHOrderManageModel.h"

@interface CLSHOrderTableViewCell ()

@end

@implementation CLSHOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CLSHOrderDetailGoodsListModel *)model{

    _model = model;
    [self.goodsIconImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    NSString *goodsPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:model.price]];
    self.goodsPrice.text = goodsPriceStr;
    self.goodsNumLabel.text = [NSString stringWithFormat:@"X%ld",model.quantity];
    self.goodsNameLabel.text = model.goodsName;
    //self.goodsSpecificationLabel.text = model.specifications[0];
}

- (void)setOrderListModel:(CLSHOrderModel *)orderListModel{

    _orderListModel = orderListModel;
    [self.goodsIconImageView sd_setImageWithURL:[NSURL URLWithString:orderListModel.image] placeholderImage:nil];
    NSString *goodsPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderListModel.price]];
    self.goodsPrice.text = goodsPriceStr;
    self.goodsNumLabel.text = [NSString stringWithFormat:@"X%ld",orderListModel.quantity];
    self.goodsNameLabel.text = orderListModel.goodsName;
    self.goodsSpecificationLabel.text = orderListModel.specifications;
}

@end
