//
//  KBCustomPhotoCollectionCellOverLayer.m
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


#import "KBCustomPhotoCollectionCellOverLayer.h"
#import "KBCustomPhotoCollectionCellCheckMark.h"
#import <QuartzCore/QuartzCore.h>

@interface KBCustomPhotoCollectionCellOverLayer()

@property(nonatomic,strong)KBCustomPhotoCollectionCellCheckMark *checkMark;

@end

@implementation KBCustomPhotoCollectionCellOverLayer


-(KBCustomPhotoCollectionCellCheckMark *)checkMark{
    if (!_checkMark) {
        _checkMark=[[KBCustomPhotoCollectionCellCheckMark alloc]initWithFrame:CGRectMake(self.bounds.size.width-28, self.bounds.size.height-28, 24, 24)];
        //AutoresizingNone(不自动调整子控件和父控件的位置)
        _checkMark.autoresizingMask=UIViewAutoresizingNone;
        //shadowcolor(阴影颜色)
        _checkMark.layer.shadowColor=[UIColor grayColor].CGColor;
        //shadowoffset(阴影偏移)
        _checkMark.layer.shadowOffset=CGSizeMake(0, 0);
        //shadowopacity(阴影透明度)
        _checkMark.layer.shadowOpacity=0.6;
        //shadowradius(阴影半径)
        _checkMark.layer.shadowRadius=2.0;
    }
    return _checkMark;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.4];
        [self addSubview:self.checkMark];
    }
    return self;
}


@end
