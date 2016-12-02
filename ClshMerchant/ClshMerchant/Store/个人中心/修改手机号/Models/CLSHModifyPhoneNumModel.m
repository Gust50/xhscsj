//
//  CLSHModifyPhoneNumModel.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHModifyPhoneNumModel.h"

@implementation CLSHModifyPhoneNumModel

-(void)fetchAccountModifyPhoneModel:(NSDictionary *)params
                           callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_ModifyPhone];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    NSMutableDictionary *needProfile=[NSMutableDictionary dictionaryWithDictionary:params];
    NSString *profileStr=[NSObject jsonTypeStringWithData:needProfile];
    NSString *encryProfileStr=[KBRSA encryptString:profileStr publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    needParams[@"profile"]=encryProfileStr;
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHModifyPhoneNumModel *model = [CLSHModifyPhoneNumModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHPhoneNumModel

-(void)fetchAccountValidateCodeModel:(NSDictionary *)params
                            callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_PhoneCode];
    
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


-(void)fetchAccountPhoneNumModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_PhoneNum];
    
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHPhoneNumModel *model=[CLSHPhoneNumModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHAccountCheckTokenModel

-(void)fetchAccountCheckTokenModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_EnsureToken];
    
    
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

@implementation CLSHNewPhoneNumModel

-(void)fetchModifyPhoneNumValidateCodeModel:(id)params
                                   callBack:(void (^)(BOOL, id _Nonnull))completion
{
    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Get_voiceCode];
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
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
