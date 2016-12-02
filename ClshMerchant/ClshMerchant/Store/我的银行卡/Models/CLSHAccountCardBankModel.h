//
//  CLSHAccountCardBankModel.h
//  ClshUser
//
//  Created by kobe on 16/6/12.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHAccountCardBankModel : NSObject

@property (nonatomic, strong) NSArray *bankAccountList; ///<银行卡列表

/**
 *  获取银行卡列表
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountCardBankModel:(NSDictionary *)params
                           callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  添加银行卡
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountAddCardBankModel:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;

/**
 *  删除银行卡
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountDelectCardBankModel:(NSDictionary *)params
                          callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountCardBankListModel : NSObject

@property (nonatomic, copy) NSString *bankAccountImg;   ///<银行卡图片
@property (nonatomic, copy) NSString *bankAccountName;   ///<持卡人名
@property (nonatomic, copy) NSString *bankAccountNumber;   ///<银行卡卡号
@property (nonatomic, copy) NSString *bankBranchName;   ///<银行卡分行
@property (nonatomic, copy) NSString *bankCategory;   ///<银行卡类型
@property (nonatomic, copy) NSString *bankType; ///<
@property (nonatomic, copy) NSString *bankAccountId;   ///<银行卡ID

@end

@interface CLSHAccountCardBankCategoryModel : NSObject

@property (nonatomic, strong) NSArray *bankCategorys;   ///<银行卡分类数组

/**
 *  获取支持银行卡的分类信息
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
-(void)fetchAccountCardBankCategoryModel:(NSDictionary *)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;
@end

@interface CLSHAccountCardBankCategoryListModel : NSObject

@property (nonatomic, copy) NSString *bankCategoryName; ///<银行卡名
@property (nonatomic, copy) NSString *bankCategoryID;   ///<银行卡ID

@end

@class CLSHAccountCardBankDetailListModel;
@interface CLSHAccountCardBankDetailModel : NSObject
@property (nonatomic, strong) CLSHAccountCardBankDetailListModel *bankAccountDetails;  ///<银行卡详情

/**
 *  银行卡信息
 *
 *  @param params     bankAccountId ///<银行卡Id
 *  @param completion 返回数据
 */

-(void)fetchAccountCardBankDetailModel:(NSDictionary *)params
                                callBack:(void(^)(BOOL isSuccess,id result))completion;

@end

@interface CLSHAccountCardBankDetailListModel : NSObject

@property (nonatomic, copy) NSString *bankAccountImg;   ///<银行卡图片
@property (nonatomic, copy) NSString *bankAccountName;   ///<持卡人名
@property (nonatomic, copy) NSString *bankAccountNumber;   ///<银行卡卡号
@property (nonatomic, copy) NSString *bankBranchName;   ///<银行卡分行
@property (nonatomic, copy) NSString *bankCategory;   ///<银行卡类型
@property (nonatomic, copy) NSString *bankType; ///<
@property (nonatomic, copy) NSString *bankAccountId;   ///<银行卡ID

@end

@interface CLSHAccountUserNameModel : NSObject

@property (nonatomic,strong)NSArray * realNames;         ///用户姓名

/**
 *  获取用户姓名
 *
 *  @param params     参数
 *  @param completion 返回参数
 */
- (void)fetchAccountUserNameData:(id)params
                        callBack:(void(^)(BOOL isSuccess,id result))completion;

@end
