//
//  MBProgressHUD+KBExtension.h
//  ClshUser
//
//  Created by kobe on 16/6/7.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (KBExtension)

/**
 *  提示成功
 *
 *  @param success success
 *  @param view    视图
 */
+(void)showSuccess:(NSString *)success
             toView:(UIView *)view;
/**
 *  提示失败
 *
 *  @param error error
 *  @param view  视图
 */
+(void)showError:(NSString *)error
          toView:(UIView *)view;

/**
 *  提示成功
 *
 *  @param success success
 */
+(void)showSuccess:(NSString *)success;

/**
 *  提示失败
 *
 *  @param error error
 */
+(void)showError:(NSString *)error;

/**
 *  隐藏视图
 *
 *  @param view 视图
 */
+(void)hideHUDForView:(UIView *)view;

/**
 *  影藏视图
 */
+(void)hideHUD;
/**
 *  提示
 *
 *  @param message 文本内容
 *  @param view    视图
 *
 *  @return        MBProgressHUD
 */
+(MBProgressHUD *)showMessage:(NSString *)message
                       toView:(UIView *)view;
/**
 *  提示
 *
 *  @param message 文本内容
 *
 *  @return       MBProgressHUD
 */
+(MBProgressHUD *)showMessage:(NSString *)message;

@end
