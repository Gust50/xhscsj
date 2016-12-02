//
//  CLSHupLoadGoodsModel.h
//  ClshMerchant
//
//  Created by kobe on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface CLSHupLoadGoodsModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *specifications;
@property (nonatomic, copy) NSString *isDiscount;

-(void)fetchUploadGoodsData:(NSDictionary *)params
                   callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHupLoadPropertyModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger stock;
@end


NS_ASSUME_NONNULL_END
