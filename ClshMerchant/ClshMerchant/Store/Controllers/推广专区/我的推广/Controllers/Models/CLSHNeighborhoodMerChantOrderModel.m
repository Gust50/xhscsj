//
//  CLSHNeighborhoodMerChantOrder.m
//  ClshUser
//
//  Created by kobe on 16/7/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighborhoodMerChantOrderModel.h"

@implementation CLSHNeighborhoodMerChantOrderModel

@end


@implementation CLSHNeighborhoodMerChantCreateOrderModel


+(NSDictionary *)mj_objectClassInArray
{
    return @{@"products":[CLSHNeighborhoodMerChantCreateOrderListModel class],@"couponCodes":[CLSHPurchaseCouponCodesListModel class]};
}

-(void)fetchNeighborhoodMerChantCreateOrderData:(NSDictionary *)params
                                       callBack:(void (^)(BOOL, id _Nonnull))completion{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_merChantCreateOrder];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code==ResponseSuccess) {
            CLSHNeighborhoodMerChantCreateOrderModel *model=[CLSHNeighborhoodMerChantCreateOrderModel mj_objectWithKeyValues:baseModel.content];
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



@implementation CLSHNeighborhoodMerChantCreateOrderDefaultAddressModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"addressId":@"id"};
}
@end




@implementation CLSHNeighborhoodMerChantCreateOrderListModel
@end


@implementation CLSHNeighborhoodMerChantCommitOrderModel
-(void)fetchNeighborhoodMerChantCommitOrderData:(NSDictionary *)params
                                       callBack:(void (^)(BOOL, id _Nonnull))completion{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_merChantCommitOrder];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    NSLog(@">>>>>>>>>>>>>>>>>>>%@",needParams);
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            
            CLSHNeighborhoodMerChantCommitOrderModel *model=[CLSHNeighborhoodMerChantCommitOrderModel mj_objectWithKeyValues:baseModel.content];
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

@implementation CLSHNeighborhoodMerChantCaculatorOrderModel

-(void)fetchNeighborhoodMerChantCaculatorOrderData:(NSDictionary *)params callBack:(void (^)(BOOL, id _Nonnull))completion{

    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Neighborhood_merChantCaculatorOrder];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        
        NSLog(@"重新计算商家订单>>>>>>>>>>>>>>>>>>%@",response);
        if (baseModel.code==ResponseSuccess) {
            
            CLSHNeighborhoodMerChantCaculatorOrderModel *model=[CLSHNeighborhoodMerChantCaculatorOrderModel mj_objectWithKeyValues:baseModel.content];
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

