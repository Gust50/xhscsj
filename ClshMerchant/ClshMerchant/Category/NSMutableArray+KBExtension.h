//
//  NSMutableArray+KBExtension.h
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


#import <Foundation/Foundation.h>

@interface NSMutableArray (KBExtension)
/**
 *  IndexOutOfBoundsException
 *
 *  @param index index
 *
 *  @return id
 */
-(id)objectAtIndexCheck:(NSUInteger)index;
@end
