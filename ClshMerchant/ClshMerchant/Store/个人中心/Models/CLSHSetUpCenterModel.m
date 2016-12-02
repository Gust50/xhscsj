//
//  CLSHSetUpCenterModel.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSetUpCenterModel.h"

@implementation CLSHSetUpCenterModel

-(void)fetchStoreSetUpCenterData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Store_SetUpCenter];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        NSLog(@"------%@",response);
        if (baseModel.code==ResponseSuccess) {
            CLSHSetUpCenterModel *model = [CLSHSetUpCenterModel mj_objectWithKeyValues:baseModel.content];
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


@implementation CLSHIconUploadModel

//文件上传
- (void)fetchAccountIconUploadModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{
    
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Store_FileUpload];
    
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
    [needsParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needsParams success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHIconUploadModel * model = [CLSHIconUploadModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
    
}

@end


@implementation CLSHIconChangeModel

- (void)fetchAccountChangeIconModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{
    
    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Store_motifyAvatar];
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    [[KBHttpTool shareKBHttpToolManager]post:url params:needParams success:^(id response) {
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code == ResponseSuccess) {
            CLSHIconChangeModel * model = [CLSHIconChangeModel mj_objectWithKeyValues:baseModel.content];
            completion(YES,model);
        }else{
            
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end
