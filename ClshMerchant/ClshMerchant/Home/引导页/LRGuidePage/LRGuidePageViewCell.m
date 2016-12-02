//
//  LRGuidePageViewCell.m
//  ClshMerchant
//
//  Created by arom on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "LRGuidePageViewCell.h"

@implementation LRGuidePageViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageviewbg = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:self.imageviewbg];
    }
    return self;
}

@end
