//
//  CLSHSelectIndustryCell.h
//  ClshMerchant
//
//  Created by wutaobo on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHMerchantJoinListListModel;
@interface CLSHSelectIndustryCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *industryName;

@property (nonatomic, strong)CLSHMerchantJoinListListModel *merchantJoinListListModel;   ///<二级菜单列表
@end
