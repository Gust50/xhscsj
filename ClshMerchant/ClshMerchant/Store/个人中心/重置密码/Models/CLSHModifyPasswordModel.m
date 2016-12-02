//
//  CLSHModifyPasswordModel.m
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


#import "CLSHModifyPasswordModel.h"

@implementation CLSHModifyPasswordModel

-(void)fetchAccountModifyPasswordModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_ModifyPassword];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    NSMutableDictionary *needProfile=[NSMutableDictionary dictionaryWithDictionary:params];
    NSString *profileStr=[NSObject jsonTypeStringWithData:needProfile];
    NSString *encryProfileStr=[KBRSA encryptString:profileStr publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    needParams[@"profile"]=encryProfileStr;
    
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
