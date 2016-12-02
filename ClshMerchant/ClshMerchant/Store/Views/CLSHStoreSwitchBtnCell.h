//
//  CLSHStoreSwitchBtnCell.h
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
@class CLSHStoreMapModel;
typedef void(^selectOpenBlock)(BOOL isOpen);
@interface CLSHStoreSwitchBtnCell : UITableViewCell
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *shopState;
@property (nonatomic, assign) BOOL isOpen;  ///<是否营业
@property (nonatomic, copy)selectOpenBlock selectOpenBlock;

@property (nonatomic, strong)CLSHStoreMapModel * model;

@end
