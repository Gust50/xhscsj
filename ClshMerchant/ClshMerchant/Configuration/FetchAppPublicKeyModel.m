//
//  FetchAppPublicKey.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "FetchAppPublicKeyModel.h"

@implementation FetchAppPublicKeyModel
static FetchAppPublicKeyModel *publicKeyModel=nil;

+(instancetype)shareAppPublicKeyManager{
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publicKeyModel=[[FetchAppPublicKeyModel alloc]init];
    });
    return publicKeyModel;
}

-(instancetype)init{
    if (self==[super init]) {
        //Returns an empty string.估计是起到分配内存的作用(通过打印确实是起到内存分配的作用，如果不使用这个方法，那么指针指向的地址是0x0（即是指向的内容没有内存分配，这里是单例设计模式，数据将会一直共享，除非程序关闭，所以我们在初始化的时候给予一个内存分配的地址）)
        self.publicKey=[NSString string];
    }
    
    return self;
}

-(void)fetchAppPublicKey:(NSDictionary *)params
                callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,App_PublicKey];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:nil success:^(id response) {

        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,[NSObject returnJson:baseModel.content][@"publicKey"]);
        }else{
            completion(NO,baseModel.message);
        }
        
    } failure:^(NSError *error) {
        completion(NO,@"服务器出错啦!");
    }];
}

-(NSDictionary *)fetchEncryptParams
{
    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
    NSString *postencryString =  [NSObject jsonTypeStringWithData:encryptDic];
    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    
    NSLog(@"%@",encryptDic);
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.timestamp;
    needParams[@"body"]=string;

    NSLog(@"%@",needParams);
    return needParams;
}

-(NSDictionary *)fetchEncryptParams:(NSDictionary *)needEncryptParams{
    
    NSDictionary *encryptDic = @{@"userid":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId,@"token":[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.token};
    
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:encryptDic];
    [params addEntriesFromDictionary:needEncryptParams];

    
    NSString *postencryString =  [NSObject jsonTypeStringWithData:params];
    NSString *string = [KBRSA encryptString:postencryString publicKey:[FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey];
    
    //返回字典
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"userid"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    needParams[@"timestamp"]=[FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.timestamp;
    needParams[@"body"]=string;
    
    return needParams;
}
@end
