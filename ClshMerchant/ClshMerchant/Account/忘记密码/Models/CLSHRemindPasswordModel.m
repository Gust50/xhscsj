//
//  CLSHRemindPasswordModel.m
//  ClshMerchant
//
//  Created by arom on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHRemindPasswordModel.h"

@implementation CLSHRemindPasswordModel

- (void)postAppForgetPasswordData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_ResetPassword];
    
    NSMutableDictionary *needEncrypt=[NSMutableDictionary dictionary];
    needEncrypt[@"smsToken"]=params[@"smsToken"];
    needEncrypt[@"newPassword"]=params[@"newPassword"];
    NSString *needEncryptString=[NSObject jsonTypeStringWithData:needEncrypt];
    NSString *postString=[KBRSA encryptString:needEncryptString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"body"]=postString;
    needParams[@"phone"]=params[@"phone"];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        
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

- (void)postAppPhoneData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString * Url=[NSString stringWithFormat:@"%@%@",URL_Header,Get_VerficationCode];
    [[KBHttpTool shareKBHttpToolManager]postNoJson:Url postData:params success:^(id response) {
        
        completion(YES,response);
        
    } failure:^(NSError *error) {
        completion(NO,error);
    }];
}

@end
