//
//  CLSHGetPictureCodeModel.m
//  ClshUser
//
//  Created by wutaobo on 16/8/17.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHGetPictureCodeModel.h"

@implementation CLSHGetPictureCodeModel

-(void)fetchAccountGetPictureCodeModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    
    NSString *Url=[NSString stringWithFormat:@"%@%@%@",URL_Header,Account_PictureCode,params[@"phoneNum"]];
    
    UIImage *result;
    
    NSData *img=[NSData dataWithContentsOfURL:[NSURL URLWithString:Url]];
    result=[UIImage imageWithData:img];
    
    completion(YES,result);
}

@end

@implementation CLSHVerifyPictureCodeModel

-(void)fetchAccountVerifyPictureCodeModel:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Account_VerifyPictureCode];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:params success:^(id response) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            CLSHVerifyPictureCodeModel *model = [CLSHVerifyPictureCodeModel mj_objectWithKeyValues:baseModel.content];
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
