//
//  KBCatchAppCrashLog.m
//  ClshMerchant
//
//  Created by kobe on 16/8/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBCatchAppCrashLog.h"

@implementation KBCatchAppCrashLog

void uncaughtExceptionHandler(NSException *exception){
    
    NSArray *stackArray=[exception callStackSymbols];
    NSString *reason=[exception reason];
    NSString *name=[exception name];
    NSString *exceptionInfo=[NSString stringWithFormat:@"exception name:%@\n exception reason:%@\n exception stack:%@",name,reason,stackArray];
    NSLog(@"%@",exceptionInfo);
    
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:stackArray];
    [tempArray insertObject:tempArray atIndex:0];
    
    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end
