//
//  CLSHNeightbourhoodShopLeftCell.h
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSHNeighborhoodMerchantLeftCategoryListModel;
@interface CLSHNeightbourhoodShopLeftCell : UITableViewCell

@property(nonatomic,strong)UILabel *categoryName;
@property(nonatomic,strong)UIView *indicatorLine;

@property(nonatomic,strong)CLSHNeighborhoodMerchantLeftCategoryListModel * NeighborhoodMerchantLeftCategoryListModel;//!<分类model

@end
