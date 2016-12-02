//
//  CLSHDataStaticModel.m
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


#import "CLSHDataStaticModel.h"

@implementation CLSHDataStaticModel

-(void)fetchDataStaticData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Static_home];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHDataStaticModel *model=[CLSHDataStaticModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHVisitorStaticModel

- (void)fetchVisitorStaticData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Static_visitor];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHVisitorStaticModel * model = [CLSHVisitorStaticModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}


@end



@implementation CLSHIncomeStaticDataModel

- (void)fetchIncomeStaticData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Static_income];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHIncomeStaticDataModel * model = [CLSHIncomeStaticDataModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end


@implementation CLSHLuckyDrawStaticDataModel

- (void)fetchLuckyDrawStaticData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Static_luckyDraw];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHLuckyDrawStaticDataModel * model = [CLSHLuckyDrawStaticDataModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end


@implementation CLSHSalesStaticDataModel

- (void)fetchSalesStaticData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Static_sales];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHSalesStaticDataModel * model = [CLSHSalesStaticDataModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end


@implementation CLSHConpousStaticDataModel

- (void)fetchConpousStaticData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Static_coupon];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
       
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHConpousStaticDataModel * model = [CLSHConpousStaticDataModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end
