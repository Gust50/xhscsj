//
//  CLSHNeighborhoodMerChantOrder.h
//  ClshUser
//
//  Created by kobe on 16/7/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSHPurchaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface CLSHNeighborhoodMerChantOrderModel : NSObject

@end

@class CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel;
@interface  CLSHNeighborhoodMerChantCreateOrderModel: NSObject
@property (nonatomic, strong) NSArray *couponCodes;
@property (nonatomic, assign) CGFloat couponDiscount;
@property (nonatomic, assign) CGFloat deliveryFee;
@property (nonatomic, assign) BOOL isCouponUsed;
@property (nonatomic, assign) BOOL isSupportDelivery;
@property (nonatomic, assign) BOOL isSupportSelfPickUp;
@property (nonatomic, assign) CGFloat payableAmount;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel *defaultReceiver;

-(void)fetchNeighborhoodMerChantCreateOrderData:(NSDictionary *)params
                               callBack:(void (^)(BOOL isSuccess, id result))completion;
@end

@interface  CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel: NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *consignee;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *modifyDate;   ///<到店时间
@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *zipCode;
@end





@interface  CLSHNeighborhoodMerChantCreateOrderListModel: NSObject
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, assign) CGFloat price;
@end



@interface CLSHNeighborhoodMerChantCommitOrderModel: NSObject
@property (nonatomic, copy) NSString *sn;
@property (nonatomic, copy) NSString *status;
-(void)fetchNeighborhoodMerChantCommitOrderData:(NSDictionary *)params
                                       callBack:(void (^)(BOOL isSuccess, id result))completion;
@end


@interface  CLSHNeighborhoodMerChantCaculatorOrderModel: NSObject

@property (nonatomic, assign) CGFloat payableAmount;
@property (nonatomic, assign) CGFloat totalPrice;

-(void)fetchNeighborhoodMerChantCaculatorOrderData:(NSDictionary *)params
                                       callBack:(void (^)(BOOL isSuccess, id result))completion;
@end

NS_ASSUME_NONNULL_END
