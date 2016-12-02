//
//  CLSHEditOnSaleToolBar.h
//  ClshMerchant
//
//  Created by kobe on 16/8/2.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@protocol  CLSHEditOnSaleToolBarDelegate<NSObject>
@optional
-(void)doneEditing;
-(void)selectAllShops:(BOOL)isSelectAll;
-(void)saleOutShops;
-(void)onSaleShops;
-(void)delectShops;
@end

@interface CLSHEditOnSaleToolBar : UIView
@property (nonatomic, assign) BOOL isSaleOut;
@property (nonatomic, assign) BOOL isSelectAll;
@property (nonatomic, weak) id<CLSHEditOnSaleToolBarDelegate>delegate;
@end
