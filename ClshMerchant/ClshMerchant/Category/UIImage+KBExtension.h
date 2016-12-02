//
//  UIImage+KBExtension.h
//  KBCustomPhoto
//
//  Created by kobe on 16/4/22.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface UIImage (KBExtension)
+(UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

+(UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;
+(UIImage *)imageWithColor:(UIColor *)color;


+(UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;

@end
