//
//  CLSHUpLoadPropertyCell.h
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>
@class CLSHupLoadPropertyModel;
@protocol CLSHUpLoadPropertyCellDelegate <NSObject>
@optional
-(void)upLoadGoodsProperty:(NSString *)property indexPath:(NSIndexPath *)indexPath;
-(void)upLoadGoodsPrice:(NSString *)price indexPath:(NSIndexPath *)indexPath;
-(void)upLoadGoodsStock:(NSString *)stock indexPath:(NSIndexPath *)indexPath;
@required
-(void)deletePropery:(CLSHupLoadPropertyModel *)model;
@end

@interface CLSHUpLoadPropertyCell : UITableViewCell
@property (nonatomic, weak) id<CLSHUpLoadPropertyCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) CLSHupLoadPropertyModel *model;
@end
