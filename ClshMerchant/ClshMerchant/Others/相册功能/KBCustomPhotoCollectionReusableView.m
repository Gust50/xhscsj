//
//  KBCustomPhotoCollectionReusableView.m
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


#import "KBCustomPhotoCollectionReusableView.h"
#import <QuartzCore/QuartzCore.h>

@interface KBCustomPhotoCollectionReusableView()

@property(nonatomic,strong)UILabel *showPhotoNum;

@end

@implementation KBCustomPhotoCollectionReusableView

#pragma mark-initWithFrame
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UILabel *showPhotoNum=[[UILabel alloc]initWithFrame:CGRectZero];
        showPhotoNum.font=[UIFont systemFontOfSize:16];
        showPhotoNum.textColor=[UIColor blackColor];
        showPhotoNum.textAlignment=NSTextAlignmentCenter;
        [self addSubview:showPhotoNum];
        self.showPhotoNum=showPhotoNum;
    }
    return self;
}

#pragma mark-layoutSubviews
-(void)layoutSubviews{
    [super layoutSubviews];
    self.showPhotoNum.frame=CGRectMake(0, (self.bounds.size.height-20)/2, self.bounds.size.width, 20);
}


#pragma mark-Getter Setter
-(void)setPhotoNumbers:(NSInteger)photoNumbers{
    NSString *numberString=[NSString stringWithFormat:@"%ld Photos",photoNumbers];
    self.showPhotoNum.text=numberString;
}
@end
