//
//  CLSHMoneyManagerModel.m
//  ClshMerchant
//
//  Created by arom on 16/9/6.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMoneyManagerModel.h"

@implementation CLSHMoneyManagerModel

-(void)fetchAccountBalanceData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Balance_home];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHMoneyManagerModel *model=[CLSHMoneyManagerModel mj_objectWithKeyValues:baseModel.content];
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



@implementation CLSHSettleImmediatelyModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"items":[CLSHSettleBalanceListModel class]};
}

- (void)fetchSettleBalanceImmediately:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Balance_settleImmediately];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        NSLog(@"------>%@",response);
        if (baseModel.code==ResponseSuccess) {
            CLSHSettleImmediatelyModel *model=[CLSHSettleImmediatelyModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHSettleBalanceListModel

@end



@implementation CLSHSubmitSettleModel

- (void)fetchSubmitSettle:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Balance_submitSettle];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHSubmitSettleModel *model=[CLSHSubmitSettleModel mj_objectWithKeyValues:baseModel.content];
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

