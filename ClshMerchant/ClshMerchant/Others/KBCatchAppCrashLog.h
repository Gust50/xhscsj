//
//  KBCatchAppCrashLog.h
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


#import <Foundation/Foundation.h>

@interface KBCatchAppCrashLog : NSObject
void uncaughtExceptionHandler(NSException *exception);         ///<C Function
@end
