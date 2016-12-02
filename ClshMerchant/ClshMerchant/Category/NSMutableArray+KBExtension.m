//
//  NSMutableArray+KBExtension.m
//  ClshMerchant
//
//  Created by kobe on 16/8/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "NSMutableArray+KBExtension.h"

@implementation NSMutableArray (KBExtension)

-(id)objectAtIndexCheck:(NSUInteger)index{
    if (index>=[self count]) {
        return nil;
    }
    id value=[self objectAtIndex:index];
    if (value==[NSNull null]) {
        return nil;
    }
    return value;
}
@end
