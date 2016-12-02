//
//  CLSHAccountCardBankModel.m
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


#import "CLSHAccountCardBankModel.h"

@implementation CLSHAccountCardBankModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"bankAccountList":[CLSHAccountCardBankListModel class]};
}

-(void)fetchAccountCardBankModel:(NSDictionary *)params
                        callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Store_bankCardList];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];

    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountCardBankModel *model = [CLSHAccountCardBankModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}


-(void)fetchAccountAddCardBankModel:(NSDictionary *)params
                          callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Store_addBankCard];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];

    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,baseModel.message);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}

-(void)fetchAccountDelectCardBankModel:(NSDictionary *)params
                              callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Store_deleteBankCard];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];

    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,baseModel.message);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];

}
@end


@implementation CLSHAccountCardBankListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"bankAccountId":@"id"};
}

@end

@implementation CLSHAccountCardBankCategoryModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"bankCategorys": [CLSHAccountCardBankCategoryListModel class]};
}

-(void)fetchAccountCardBankCategoryModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Store_bankCategoryList];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountCardBankCategoryModel *model = [CLSHAccountCardBankCategoryModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountCardBankCategoryListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"bankCategoryID":@"id"};
}

@end

@implementation CLSHAccountCardBankDetailModel

-(void)fetchAccountCardBankDetailModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
//    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_BankCardInfo];
//    
//    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
//    [needParams addEntriesFromDictionary:params];
//    
//    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
//        
//        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
//        if (baseModel.code==ResponseSuccess) {
//            CLSHAccountCardBankDetailModel *model = [CLSHAccountCardBankDetailModel mj_objectWithKeyValues:baseModel.content];
//            completion(YES,model);
//        }else{
//            //错误信息
//            completion(NO,baseModel.message);
//        }
//    } failure:^(NSError *error) {
//        completion(NO,ServerError);
//    }];
}

@end

@implementation CLSHAccountCardBankDetailListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"bankAccountId":@"id"};
}

@end

@implementation CLSHAccountUserNameModel

- (void)fetchAccountUserNameData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Store_userName];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams] ];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountUserNameModel *model = [CLSHAccountUserNameModel mj_objectWithKeyValues:baseModel.content];
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
