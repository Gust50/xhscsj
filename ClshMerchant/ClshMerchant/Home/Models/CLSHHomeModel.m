//
//  CLSHHomeModel.m
//  ClshMerchant
//
//  Created by kobe on 16/8/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHHomeModel.h"

@implementation CLSHHomeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"merchantID":@"id"};
}

-(void)fetchHomeData:(NSDictionary *)params
            callBack:(void (^)(BOOL, id _Nonnull))completion{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_Data];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeModel *model = [CLSHHomeModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHDiscountdataModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"modelMapList":[CLSHDiscountListModel class]};
}

- (void)fetchDiscountData:(id)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Home_discount];
//    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
//    [needParams addEntriesFromDictionary:params];

    
//    [[KBHttpTool shareKBHttpToolManager] postNoJson:url postData:params success:^(id response) {
//        
//        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
//        if (baseModel.code == ResponseSuccess) {
//            CLSHDiscountdataModel * model = [CLSHDiscountdataModel mj_objectWithKeyValues:baseModel.content];
//            completion(YES,model);
//        }else{
//            
//            completion(NO,baseModel.message);
//        }
//
//    } failure:^(NSError *error) {
//        
//         completion(NO,ServerError);
//    }];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:params success:^(id response) {
       
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code == ResponseSuccess) {
            CLSHDiscountdataModel * model = [CLSHDiscountdataModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end



@implementation CLSHDiscountListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"discountID":@"id"};
}

@end


@implementation CLSHApplyDiscountDataModel

- (void)fetchApplyDiscountData:(id)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_updateDiscount];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
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

@end





