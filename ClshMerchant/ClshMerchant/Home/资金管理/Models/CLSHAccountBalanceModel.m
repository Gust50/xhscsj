//
//  CLSHAccountBalanceModel.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHAccountBalanceModel.h"

@implementation CLSHAccountBalanceModel

-(void)fetchAccountBalanceData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Balance_home];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountBalanceModel *model=[CLSHAccountBalanceModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountIncomeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHAccountIncomeListModel class]};
}

-(void)fetchAccountIncomeData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Balance_income];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountIncomeModel *model=[CLSHAccountIncomeModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountIncomeListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"incomeID":@"id"};
}

@end

@implementation CLSHAccountIncomeDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"incomeDetailID":@"id"};
}
-(void)fetchAccountIncomeDetailData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Balance_incomeDetail];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHAccountIncomeDetailModel *model=[CLSHAccountIncomeDetailModel mj_objectWithKeyValues:baseModel.content[@"items"]];
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



//@2
@implementation CLSHIncomeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"items":[CLSHIncomeDetailModel class]};
}

-(void)fetchIncomeData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    //收入的接口
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Single_income];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHIncomeModel *model=[CLSHIncomeModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHIncomeDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"name":@"description"};
}

@end
