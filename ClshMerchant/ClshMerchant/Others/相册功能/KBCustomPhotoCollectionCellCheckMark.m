//
//  KBCustomPhotoCollectionCellCheckMark.m
//  KBCustomPhoto
//
//  Created by kobe on 16/3/23.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBCustomPhotoCollectionCellCheckMark.h"

@implementation KBCustomPhotoCollectionCellCheckMark

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size{
    return CGSizeMake(24.0, 24.0);
}

-(void)drawRect:(CGRect)rect{
    //get current context(获取上下文)
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //fill ellipse with color(填充一个大的椭圆)
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillEllipseInRect(context, self.bounds);
    
    //fill ellipse with color(填充一个小的椭圆)
    CGContextSetRGBFillColor(context, 20.0/255.0, 111.0/255.0, 233.0/255.0, 1.0);
    CGContextFillEllipseInRect(context, CGRectInset(self.bounds, 1.0, 1.0));
    
    //setup stroke color(设置画笔颜色)
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.2);
    //start point(设置画笔的起始点)
    CGContextMoveToPoint(context, 6.0, 12.0);
    CGContextAddLineToPoint(context, 10.0, 16.0);
    CGContextAddLineToPoint(context, 18.0, 8.0);
    //start path(开始画线)
    CGContextStrokePath(context);
}

@end
