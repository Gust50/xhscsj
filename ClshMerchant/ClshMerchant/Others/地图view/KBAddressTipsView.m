//
//  KBAddressTipsView.m
//  KBAMap3DMapView
//
//  Created by kobe on 16/9/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBAddressTipsView.h"

#define kArrowHeight 12

@interface KBAddressTipsView ()
@property (nonatomic, strong) UILabel *addressLab;
@end

@implementation KBAddressTipsView

#pragma mark <lazyLoad>
-(UILabel *)addressLab{
    if (!_addressLab) {
        _addressLab=[UILabel new];
        
        
    }
    return _addressLab;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        self.addressLab=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.bounds.size.width-15,self.bounds.size.height-kArrowHeight)];
        self.addressLab.font = [UIFont systemFontOfSize:13];
        self.addressLab.textAlignment = NSTextAlignmentCenter;
        self.addressLab.numberOfLines = 0;
        [self addSubview:self.addressLab];
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    [self drawInContext:UIGraphicsGetCurrentContext()];
}

-(void)drawInContext:(CGContextRef)context{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    [self drawTipsViewPath:context];
    CGContextFillPath(context);
}

-(void)drawTipsViewPath:(CGContextRef)context{
    CGRect rect=self.bounds;
    CGFloat radius=6.0;
    CGFloat minX=CGRectGetMinX(rect);
    CGFloat midX=CGRectGetMidX(rect);
    CGFloat maxX=CGRectGetMaxX(rect);
    CGFloat minY=CGRectGetMinY(rect);
    CGFloat maxY=CGRectGetMaxY(rect)-kArrowHeight;
    
    CGContextMoveToPoint(context, midX+kArrowHeight, maxY);
    CGContextAddLineToPoint(context, midX, maxY+kArrowHeight);
    CGContextAddLineToPoint(context, midX-kArrowHeight, maxY);
    
    CGContextAddArcToPoint(context, minX, maxY, minX, minY, radius);
    CGContextAddArcToPoint(context, minX, minY, maxX, minY, radius);
    CGContextAddArcToPoint(context, maxX, minY, maxX, maxY, radius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius);
    
    CGContextClosePath(context);
}

-(void)setName:(NSString *)name{
    _name=name;
    _addressLab.text=name;
}
@end
