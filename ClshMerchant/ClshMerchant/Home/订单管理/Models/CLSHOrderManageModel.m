//
//  CLSHOrderManageModel.m
//  ClshMerchant
//
//  Created by arom on 16/8/4.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHOrderManageModel.h"

@implementation CLSHOrderManageModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"orders":[CLSHOderListModel class]};
}

- (void)fetchOrderData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Order_list];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        NSLog(@"====%@",response);
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHOrderManageModel * model = [CLSHOrderManageModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
    
}
@end


@class CLSHOrderModel;
@implementation CLSHOderListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"orderId":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"orderItems":[CLSHOrderModel class]};
}

@end


@implementation CLSHOrderModel

@end



@implementation CLSHOrderDetailModel

- (void)fetchOrderDetailData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Order_detail];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams:params]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
         
            CLSHOrderDetailModel * model = [CLSHOrderDetailModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end


@class CLSHOrderDetailGoodsListModel;
@implementation CLSHOrderDetailInfoModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"orderItems":[CLSHOrderDetailGoodsListModel class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"id":@"orderId"};
}

@end


@implementation CLSHOrderDetailGoodsListModel

@end


@implementation CLSHDeliveryOrderModel

- (void)fetchDeliveryOrderData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Order_delivery];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            completion(YES,baseModel.message);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
    
}

@end


@implementation CLSHCancelOrderModel

- (void)fetchCancelOrderData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Order_cancel];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            completion(YES,baseModel.message);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
    
}

@end




@implementation CLSHCommentDataModel

+ (NSDictionary *)mj_objectClassInArray{

    return @{@"parentReview":[CLSHAnswerCommentDataModel class]};
}

- (void)fetchCommentData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Order_commentDetail];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHCommentDataModel * model = [CLSHCommentDataModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end


@implementation CLSHAnswerCommentDataModel

@end



@implementation CLSHAnswerCommentBehaviorModel

- (void)fetchAnswerCommentBehaviorData:(id)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Order_commentReview];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            completion(YES,baseModel.message);
        }else{
        
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end
