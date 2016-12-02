//
//  CLSHMerchantJoinModel.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/4.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMerchantJoinModel.h"

@implementation CLSHMerchantJoinModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"industry":[CLSHMerchantJoinListModel class]};
}

-(void)fetchMerchantJoinData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Merchant_industryList];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHMerchantJoinModel *model = [CLSHMerchantJoinModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end

@implementation CLSHMerchantJoinListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"industryID":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"childen":[CLSHMerchantJoinListListModel class]};
}

@end

@implementation CLSHMerchantJoinListListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"industryListID":@"id"};
}

@end

@implementation CLSHMerchantJoinWriteInfoModel

-(void)fetchMerchantJoinWriteInfoData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Merchant_WriteInfo];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHMerchantJoinWriteInfoModel *model = [CLSHMerchantJoinWriteInfoModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end

@implementation CLSHMerchantJoinInfoModel

-(void)fetchMerchantJoinInfoData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Merchant_JoinInfo];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHMerchantJoinInfoModel *model = [CLSHMerchantJoinInfoModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end

@implementation CLSHMerchantJoinAddressModel

-(void)fetchMerchantJoinAddressData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Merchant_AddressList];
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        CLSHMerchantJoinAddressModel * model = [CLSHMerchantJoinAddressModel mj_objectWithKeyValues:response];
        completion(YES,model);
        
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
}

@end
