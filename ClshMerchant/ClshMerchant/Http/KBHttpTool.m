//
//  KBHttpTool.m
//  KBNetworkAndCache
//
//  Created by kobe on 16/3/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBHttpTool.h"
#import <AFNetworking.h>
#import <YYCache.h>
#import "AppDelegate.h"

static NSTimeInterval const KBHttpToolRequestTimeoutInterval=30;
NSString *const KBHttpToolRequestCacheName=@"KBHttpToolRequestCacheName";

typedef NS_ENUM(NSInteger,KBHttpToolRequestType){
    KBHttpToolRequestTypeGet=0,
    KBHttpToolRequestTypePost,
};



@implementation KBHttpTool


/**
 *  Get
 *
 *  @param url     URL
 *  @param params  Parmas
 *  @param success Scucess
 *  @param failure Failure
 */
+(void)get:(NSString *)url
    params:(NSDictionary *)params
   success:(void (^)(id))success
   failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    //Request timed out
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = KBHttpToolRequestTimeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  Post
 *
 *  @param url
 *  @param params  Params
 *  @param success Success
 *  @param failure Failure
 */
-(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    //Request timed out
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval=KBHttpToolRequestTimeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"multipart/form-data",@"charset=UTF-8", nil];
    [manager.requestSerializer setValue:@"3.0" forHTTPHeaderField:@"app_version"];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
        
        if (baseModel.code==ResponseSuccess) {
            success(responseObject);

        }else if (baseModel.code==ResponseUnLogin){
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=NO;
            [FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey=nil;
            [ShareApp againLogin];
        }else if (baseModel.code==ResponseUpdateKey){
            [FetchAppPublicKeyModel shareAppPublicKeyManager].publicKey=nil;
             [ShareApp updatePublicKey];
        }
        else{
            success(responseObject);
            
            //bug 发送日志
            NSMutableDictionary *appDebugParams=[NSMutableDictionary dictionary];
            
            if (baseModel.code==ResponseSystemError) {
                 appDebugParams[@"code"]=@(16);
            }else if (baseModel.code==ResponseWarmMessage){
                appDebugParams[@"code"]=@(4);
            }else if (baseModel.code==ResponseOperaError){
                appDebugParams[@"code"]=@(8);
            }
            
            appDebugParams[@"url"]=url;
            appDebugParams[@"params"]=params;
//            [baseModel postAppDebug:appDebugParams callBack:^(BOOL isSuccess, id result) {
//               
//                
//            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  Get And Cache
 *
 *  @param url         URL *  @param params      Params
 *  @param timeout     timeout
 *  @param cachePolicy KBHttpToolRequsetCachePolicy
 *  @param success     Success
 *  @param failure     Failure
 *
 *  @return            NSURLSessionDataTask
 */
+(NSURLSessionDataTask *)get:(NSString *)url
                      params:(id)params
                     timeout:(NSTimeInterval)timeout
                 cachePolicy:(KBHttpToolRequsetCachePolicy)cachePolicy
                     success:(void (^)(NSURLSessionDataTask *, id))success
                     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *cacheKey=url;
    if ([NSJSONSerialization isValidJSONObject:params]){
        
        NSData *data=[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey=[url stringByAppendingString:paramStr];
    }
    
    YYCache *cache=[[YYCache alloc]initWithName:KBHttpToolRequestCacheName];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning=YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground=YES;
    
    id object=[cache objectForKey:cacheKey];
    switch (cachePolicy) {
        case KBHttpToolReturnCacheThenLoad:{
            if (object) {
                success(nil,object);
            }
            break;
        }
        case KBHttpToolReloadIgnoringLocalCache:{
            break;
        }
        case KBHttpToolReturnCacheElseLoad:{
            if (object) {
                success(nil,object);
                return nil;
            }
            break;
        }
        case KBHttpToolReturnCacheDontLoad:{
            if (object) {
                success(nil,object);
                return nil;
            }
            break;
        }
            
        default:
            break;
    }
    
    return [self requestType:KBHttpToolRequestTypeGet url:url params:params timeout:timeout cache:cache cacheKey:cacheKey success:success failure:failure];
}


/**
 *  Post And Cache
 *
 *  @param url         URL
 *  @param params      Params
 *  @param timeout     timeout
 *  @param cachePolicy KBHttpToolRequsetCachePolicy
 *  @param success     Success
 *  @param failure     Failure
 *
 *  @return            NSURLSessionDataTask
 */
+(NSURLSessionDataTask *)post:(NSString *)url
                       params:(id)params
                      timeout:(NSTimeInterval)timeout
                  cachePolicy:(KBHttpToolRequsetCachePolicy)cachePolicy
                      success:(void(^)(NSURLSessionDataTask *task,id response))success
                      failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
{
    
    NSString *cacheKey=url;
    if ([NSJSONSerialization isValidJSONObject:params]){
        
        NSData *data=[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey=[url stringByAppendingString:paramStr];
    }
    
    YYCache *cache=[[YYCache alloc]initWithName:KBHttpToolRequestCacheName];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning=YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground=YES;
    
    id object=[cache objectForKey:cacheKey];
    switch (cachePolicy) {
        case KBHttpToolReturnCacheThenLoad:{
            if (object) {
                success(nil,object);
            }
            break;
        }
        case KBHttpToolReloadIgnoringLocalCache:{
            break;
        }
        case KBHttpToolReturnCacheElseLoad:{
            if (object) {
                success(nil,object);
                return nil;
            }
            break;
        }
        case KBHttpToolReturnCacheDontLoad:{
            if (object) {
                success(nil,object);
                return nil;
            }
            break;
        }
            
        default:
            break;
    }
    
    return [self requestType:KBHttpToolRequestTypePost url:url params:params timeout:timeout cache:cache cacheKey:cacheKey success:success failure:failure];
}


+(NSURLSessionDataTask *)requestType:(KBHttpToolRequestType)requestType
                                 url:(NSString *)url params:(id)params
                             timeout:(NSTimeInterval)timeout
                               cache:(YYCache *)cache
                            cacheKey:(NSString *)cacheKey
                             success:(void(^)(NSURLSessionDataTask *task,id response))success
                             failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure
{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval=KBHttpToolRequestTimeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInerval"];
    
    switch (requestType) {
        case KBHttpToolRequestTypeGet:{
           return [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    
                    if ([responseObject isKindOfClass:[NSData class]]) {
                        responseObject=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    }
                    [cache setObject:responseObject forKey:cacheKey];
                    success(task,responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task,error);
                }
                
            }];
            break;
        }
        case KBHttpToolRequestTypePost:{
           return [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    
                    
                    if ([responseObject isKindOfClass:[NSData class]]) {
                        responseObject=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    }
                    [cache setObject:responseObject forKey:cacheKey];
                    success(task,responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task,error);
                }
                
            }];
            break;
        }
        default:
            break;
    }
    
}

-(void)postNoJson:(NSString *)url
         postData:(id)postString
          success:(void (^)(id))success
          failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    //Request timed out
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval=KBHttpToolRequestTimeoutInterval;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"3.0" forHTTPHeaderField:@"app_version"];

    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    NSString *contentType=[NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *postBody=[NSMutableData data];
    [postBody appendData:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postBody];
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            
             failure(error);
            
        }else{
            
            success([NSObject returnJson:responseObject]);
        }
        
    }]resume];
}

/**
 *  singleton
 *
 *  @return shareManager
 */
+(id)shareKBHttpToolManager{
    
    static KBHttpTool *shareManager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager=[[KBHttpTool alloc]init];
    });
    return shareManager;
}

/**
 * reachability
 */
+(void)reachability{
    
    AFNetworkReachabilityManager *manager=[AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusUnknown:
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}

@end
