//
//  KBLeftTextRightImgBtn.m
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBLeftTextRightImgBtn.h"

@implementation KBLeftTextRightImgBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.imageView.contentMode=UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted=NO;
        self.titleLabel.textAlignment=NSTextAlignmentRight;
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imgY=0;
    CGFloat imgW=self.height;
    CGFloat imgH=imgW;
    CGFloat imgX=self.width-imgW;
    return CGRectMake(imgX, imgY, imgW, imgH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY=0;
    CGFloat titleX=0;
    CGFloat titleH=self.height;
    CGFloat titleW=self.width-titleH;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
