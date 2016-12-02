//
//  CLSHInviteCodeRecordHeader.m
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHInviteCodeRecordHeader.h"
#import "KBSegmentView.h"


@interface CLSHInviteCodeRecordHeader ()<KBSegmentViewDelegate>

@property(nonatomic,strong)KBSegmentView *kBSegment;

@end

@implementation CLSHInviteCodeRecordHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor=backGroundColor;
    }
    return self;
}

-(void)initUI{
    
    self.kBSegment=[KBSegmentView createSegmentFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-10)
                                     segmentTitleArr:@[@"用户",@"商家"]
                                     backgroundColor:[UIColor whiteColor]
                                          titleColor:[UIColor blackColor]
                                    selectTitleColor:systemColor
                                           titleFont:[UIFont systemFontOfSize:15*AppScale]
                                     bottomLineColor:systemColor
                                       isVerticleBar:NO
                                            delegate:self];
    self.kBSegment.delegate=self;
    [self addSubview:self.kBSegment];
}

-(void)selectSegment:(NSInteger)index
{
    if (self.userOrMerchantBlock) {
        self.userOrMerchantBlock(index);
    }
}

@end
