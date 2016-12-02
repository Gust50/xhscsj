//
//  KBTimer.h
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


#import <Foundation/Foundation.h>
@class KBLabel;

@interface KBTimer : NSObject

/**
 *  倒计时
 *
 *  @param lable 传入Label属性
 */
-(void)countDown:(UILabel *)lable;

@end
