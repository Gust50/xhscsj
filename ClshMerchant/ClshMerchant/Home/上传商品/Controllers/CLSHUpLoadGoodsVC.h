//
//  CLSHUpLoadGoodsVC.h
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


#import "CLSHBaseViewVC.h"
@class CLSHHomeShopListItemModel;

@interface CLSHUpLoadGoodsVC : CLSHBaseViewVC
@property (nonatomic ,strong) CLSHHomeShopListItemModel *itemModel;
@property (nonatomic, assign)  BOOL isEditShop;
@property (nonatomic, copy) NSString *goodsId;
@end
