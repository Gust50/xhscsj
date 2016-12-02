//
//  CLSHNeightbourhoodShopRightCell.h
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHNeighborhoodMerchantRightGoodsListModel,CLSHNeighborhoodMerchantRightGoodsListProductsModel;

typedef void(^selectSpecificationBlock)();

@protocol  NeightbourhoodShopRightCellDelegate<NSObject>
-(void)addMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model;
-(void)deleteMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model;


-(void)addMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model;
-(void)deleteMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model;

@end


@interface CLSHNeightbourhoodShopRightCell : UITableViewCell
@property (nonatomic,strong)CLSHNeighborhoodMerchantRightGoodsListModel * model;
@property (nonatomic, weak) id<NeightbourhoodShopRightCellDelegate>delegate;
@property (nonatomic, assign) BOOL isReset;

@property (nonatomic, copy) selectSpecificationBlock selectSpecificationBlock;
@end
