//
//  CLSHHomeShopListModel.h
//  ClshMerchant
//
//  Created by kobe on 16/8/15.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLSHHomeShopListModel : NSObject
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalPages;
@property (nonatomic, assign) NSInteger totalRecord;

@property (nonatomic, strong) NSArray *items;
-(void)fetchShopListData:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess, id result))completion;
@end


@interface CLSHHomeShopListItemModel : NSObject
@property (nonatomic, copy) NSString *defaultProductId;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, assign) BOOL isMarketable;                ///<true上架  false 下架
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger stock;
@property (nonatomic, assign) NSInteger sales;

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isExpand;
@property (nonatomic, assign) BOOL isArrow;

@end

@interface CLSHHomeEditShopModel: NSObject

-(void)fetchEditShopData:(NSDictionary *)params
                callBack:(void(^)(BOOL isSuccess,id result))completion;

@end




@interface CLSHHomeShopItemDetailModel : NSObject


@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) NSString *defaultProductId;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsid;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic ,copy) NSString *isJoinPromotion;
@property (nonatomic, strong) NSArray *specifications;

-(void)fetchShopDetailData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess, id result))completion;
@end




@interface CLSHHomeOnSaleShopModel : NSObject
-(void)fetchOnSaleShopData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess, id result))completion;
@end



@interface CLSHHomeSaleOutShopModel : NSObject
-(void)fetchSaleOutShopData:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;
@end



@interface CLSHHomeDeleteShopModel : NSObject
-(void)fetchDeleteShopData:(NSDictionary *)params
                  callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHHomeShopTypeNumbersModel: NSObject
@property (nonatomic, assign) NSInteger currentOnSaleCount;
@property (nonatomic, assign) NSInteger currentSaleOutCount;
@end


@interface CLSHHomeMotifyClassifyModel : NSObject

- (void)fetchMotifyClassifyData:(id)params
                 callBack:(void (^)(BOOL isSuccess,id result))completion;

@end


NS_ASSUME_NONNULL_END
