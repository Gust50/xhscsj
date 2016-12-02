//
//  CLSHupLoadGoodsModel.m
//  ClshMerchant
//
//  Created by kobe on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHupLoadGoodsModel.h"

@implementation CLSHupLoadGoodsModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"specifications":[CLSHupLoadPropertyModel class]};
}

-(void)fetchUploadGoodsData:(NSDictionary *)params
                   callBack:(void (^)(BOOL, id _Nonnull))completion{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_UploadGoods];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager]fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,@"上传成功");
        }else{
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}
@end

@implementation CLSHupLoadPropertyModel


@end
