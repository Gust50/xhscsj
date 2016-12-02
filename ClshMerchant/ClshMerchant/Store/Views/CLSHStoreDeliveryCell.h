//
//  CLSHStoreDeliveryCell.h
//  ClshMerchant
//
//  Created by kobe on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@protocol  CLSHStoreDeliveryCellDelegate<NSObject>
@optional
-(void)chooseDelivery:(BOOL)delivery;
-(void)chooseTake:(BOOL)take;
-(void)chooseDelivery:(BOOL)delivery take:(BOOL)take;
@end

@interface CLSHStoreDeliveryCell : UITableViewCell
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *titleContent;
@property (nonatomic, weak) id<CLSHStoreDeliveryCellDelegate>delegate;

@property (nonatomic, assign)BOOL isSupportDelivery;    ///<传入是否配送
@property (nonatomic, assign)BOOL isSupportSelfPickUp;  ///<传入是否自提

@end
