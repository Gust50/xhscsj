//
//  CLSHHomeShopListModel.m
//  ClshMerchant
//
//  Created by kobe on 16/8/15.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHHomeShopListModel.h"
#import "CLSHupLoadGoodsModel.h"

@implementation CLSHHomeShopListModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"items":[CLSHHomeShopListItemModel class]};
}
-(void)fetchShopListData:(NSDictionary *)params
                callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_shopList];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
     NSLog(@"%@",needParams);
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHHomeShopListModel *model=[CLSHHomeShopListModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            completion(NO,baseModel.content);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
@end



@implementation CLSHHomeShopListItemModel
@end



@implementation CLSHHomeEditShopModel
-(void)fetchEditShopData:(NSDictionary *)params
                callBack:(void (^)(BOOL, id _Nonnull))completion{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_editShop];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    NSLog(@"%@",needParams);
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            completion(YES,baseModel.message);
            
        }else{
            completion(NO,baseModel.message);
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
@end



@implementation CLSHHomeShopItemDetailModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"specifications":[CLSHupLoadPropertyModel class]};
}

-(void)fetchShopDetailData:(NSDictionary *)params
                  callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_editShopDetail];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHHomeShopItemDetailModel *model=[CLSHHomeShopItemDetailModel mj_objectWithKeyValues:baseModel.content[@"goods"]];
            completion(YES,model);
        }else{
            
            completion(NO,baseModel.content);
        }
        
    } failure:^(NSError *error) {
        
    }];
}
@end


@implementation CLSHHomeOnSaleShopModel

-(void)fetchOnSaleShopData:(NSDictionary *)params
                  callBack:(void (^)(BOOL, id _Nonnull))completion{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_OnSaleShop];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    NSLog(@"%@",needParams);
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,@"success");
        }else{
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
    }];
}
@end


@implementation CLSHHomeSaleOutShopModel

-(void)fetchSaleOutShopData:(NSDictionary *)params
                   callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_SaleOutShop];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,@"success");
        }else{
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
    }];
}
@end


@implementation CLSHHomeDeleteShopModel
-(void)fetchDeleteShopData:(NSDictionary *)params
                  callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_DeleteShop];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,@"success");
        }else{
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
    }];
}
@end

@implementation CLSHHomeShopTypeNumbersModel

@end


@implementation CLSHHomeMotifyClassifyModel

- (void)fetchMotifyClassifyData:(id)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Category_Motify];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
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

@end


