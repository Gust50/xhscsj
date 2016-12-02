//
//  CLSHApplicationForRefundModel.m
//  ClshMerchant
//
//  Created by wutaobo on 16/9/28.
//  Copyright © 2016年 50. All rights reserved.
//

#import "CLSHApplicationForRefundModel.h"

@implementation CLSHApplicationForRefundModel

-(void)fetchCLSHApplicationForRefundModel:(id)params callBack:(void (^)(BOOL, id))completion
{
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Order_OrderRefund];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
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
