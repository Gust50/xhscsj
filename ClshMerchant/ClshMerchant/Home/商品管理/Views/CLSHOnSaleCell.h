//
//  CLSHOnSaleCell.h
//  ClshMerchant
//
//  Created by kobe on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>
@class CLSHHomeShopListItemModel;

@protocol CLSHOnSaleCellDeleagate <NSObject>
@optional
-(void)expandBtn:(BOOL)expand indexPath:(NSIndexPath *)indexPath;
-(void)clickArrow;
-(void)editShop:(NSIndexPath *)indexPath;
-(void)onSaleShop:(NSIndexPath *)indexPath;
-(void)saleOutShop:(NSIndexPath *)indexPath;
-(void)editShopCategory:(NSIndexPath *)indexPath;
-(void)deleteShop:(NSIndexPath *)indexPath;
@end

@interface CLSHOnSaleCell : UITableViewCell
@property (nonatomic, weak) id <CLSHOnSaleCellDeleagate>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isSaleOut;

@property (nonatomic, strong) CLSHHomeShopListItemModel *itemModel;
@end
