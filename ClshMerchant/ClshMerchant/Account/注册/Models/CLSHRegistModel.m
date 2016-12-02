//
//  CLSHRegistModel.m
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


#import "CLSHRegistModel.h"


@implementation CLSHRegistModel

- (void)postAppRegisterData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_Regist];
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            completion(YES,baseModel.content);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

-  (void)postAppPhoneData:(id)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Get_VerficationCode];
    
    [[KBHttpTool shareKBHttpToolManager]postNoJson:url postData:params success:^(id response) {
        
        completion(YES,response);
    } failure:^(NSError *error) {
         completion(NO,ServerError);
    }];
    
}


- (void)postAppPhoneVoiceData:(id)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Get_voiceCode];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
       
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            completion(YES,@"  ");
        }else{
        
            completion(NO,@"  ");
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end

@implementation CLSHtelephoneVerifyModel

- (void)FetchTelePhoneIsregistedData:(id)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,nil];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code == ResponseSuccess) {
            CLSHtelephoneVerifyModel * model = [CLSHtelephoneVerifyModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end
