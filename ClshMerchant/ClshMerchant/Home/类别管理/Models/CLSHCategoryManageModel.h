//
//  CLSHCategoryManageModel.h
//  ClshMerchant
//
//  Created by arom on 16/8/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHCategoryManageModel : NSObject

@property (nonatomic,strong)NSArray * classification;               ///<分类数组

- (void)fetchCategoryManageData:(NSDictionary *)params
                    callBack:(void (^)(BOOL isSuccess, id result))completion;

@end

@interface CLSHCategoryListModel : NSObject

@property (nonatomic,assign)NSInteger categoryID;                     ///<分类id
@property (nonatomic,assign)NSInteger priority;                      ///<分类优先级
@property (nonatomic,copy)NSString * name;                           ///<分类名称
@property (nonatomic,assign)NSInteger size;                          ///<数量

@end



@interface CLSHAddCategoryModel : NSObject

- (void)fetchAddCategoryData:(NSDictionary *)params
                    callBack:(void (^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHEditCategoryKeepModel : NSObject

- (void)fetchEditCategoryKeepData:(NSMutableDictionary *)params
                    callBack:(void (^) (BOOL isSuccess,id result))completion;

@end


@interface CLSHEditCategoryDeleteModel : NSObject

- (void)fetchEditCategoryDeleteData:(NSMutableDictionary *)params
                    callBack:(void (^) (BOOL isSuccess, id result))completion;

@end
