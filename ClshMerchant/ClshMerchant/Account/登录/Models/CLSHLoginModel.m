//
//  CLSHLoginModel.m
//  ClshMerchant
//
//  Created by arom on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHLoginModel.h"
#import "CLSHLoginInfoModel.h"
#import "KBRSA.h"

@implementation CLSHLoginModel

- (void)postAppLoginData:(NSDictionary *)params callBack:(void (^)(BOOL, id))completion{

    NSString * url = [NSString stringWithFormat:@"%@%@",URL_Header,Account_Login];
    
    NSString * jsonString = [NSObject jsonTypeStringWithData:params];
    NSString * encrypt = [KBRSA encryptString:jsonString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
    needsParams[@"username"] = params[@"username"];
    needsParams[@"loginRole"] = params[@"loginRole"];
    needsParams[@"body"] = encrypt;
    
    [[KBHttpTool shareKBHttpToolManager]post:url params:needsParams success:^(id response) {
        
        BaseModel * baseModel = [BaseModel mj_objectWithKeyValues:response];
        
        if (baseModel.code == ResponseSuccess) {
            
            //save info
            [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel = [CLSHLoginInfoModel mj_objectWithKeyValues:baseModel.content];
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin = YES;
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogined"];
            CLSHLoginModel * model = [CLSHLoginModel mj_objectWithKeyValues:baseModel.content];;
            NSLog(@"----------%@",response);
            completion(YES,model);
        }else{
        
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
    
}

@end


@implementation CLSHCertificationModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"shopID":@"id"};
}

@end
