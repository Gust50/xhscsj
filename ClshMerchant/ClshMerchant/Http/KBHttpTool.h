//
//  KBHttpTool.h
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


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,KBHttpToolRequsetCachePolicy){
    
    KBHttpToolReturnCacheThenLoad=0,      //if have cache first return cache then synchronization data
    KBHttpToolReloadIgnoringLocalCache,   //ingnor local cache to load
    KBHttpToolReturnCacheElseLoad,        //if have cache first return cache,else load
    KBHttpToolReturnCacheDontLoad,        //if have cache return cache,else dont load
};

extern  NSString *const KBHttpToolRequestCacheName;  //Cache Name



@interface KBHttpTool : NSObject

/**
 *  Get
 *
 *  @param url     URL
 *  @param params  Params
 *  @param success Success
 *  @param failure Failure
 */
+(void)get:(NSString *)url params:(NSDictionary *)params
   success:(void(^)(id response))success
   failure:(void(^)(NSError *error))failure;

/**
 *  Post
 *
 *  @param url     URL
 *  @param params  Params
 *  @param success Success
 *  @param failure Failure
 */
-(void)post:(NSString *)url
     params:(NSDictionary *)params
    success:(void(^)(id response))success
    failure:(void(^)(NSError *error))failure;

/**
 *  Get Cache
 *
 *  @param url         URL
 *  @param params      Params
 *  @param timeout     timeout
 *  @param cachePolicy KBHttpToolRequsetCachePolicy
 *  @param success     Success
 *  @param failure     Failure
 */
+(NSURLSessionDataTask *)get:(NSString *)url
                      params:(id)params
                     timeout:(NSTimeInterval)timeout
                 cachePolicy:(KBHttpToolRequsetCachePolicy)cachePolicy
                     success:(void(^)(NSURLSessionDataTask *task,id response))success
                     failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;

/**
 *  Post Cache
 *
 *  @param url         URL
 *  @param params      Params
 *  @param timeout     timeout
 *  @param cachePolicy KBHttpToolRequsetCachePolicy
 *  @param success     Success
 *  @param failure     Failure
 */
+(NSURLSessionDataTask *)post:(NSString *)url
                       params:(id)params
                      timeout:(NSTimeInterval)timeout
                  cachePolicy:(KBHttpToolRequsetCachePolicy)cachePolicy
                      success:(void(^)(NSURLSessionDataTask *task,id response))success
                      failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;



-(void)postNoJson:(NSString *)url
         postData:(id)postString
          success:(void(^)(id response))success
          failure:(void(^)(NSError *error))failure;

/**
 *  singleton
 *
 *  @return id
 */
+(id)shareKBHttpToolManager;

/**
 *  Network Status
 */
+(void)reachability;

@end
