//
//  KBCustomPhotoCollectionViewCell.m
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


#import "KBCustomPhotoCollectionViewCell.h"
#import "KBCustomPhotoCollectionCellOverLayer.h"

@interface KBCustomPhotoCollectionViewCell()

@property(nonatomic,strong)UIImageView *photoImageView;
@property(nonatomic,strong)KBCustomPhotoCollectionCellOverLayer *overLayer;

@end


@implementation KBCustomPhotoCollectionViewCell

-(UIImageView *)photoImageView{
    if (!_photoImageView) {
        _photoImageView=[[UIImageView alloc]initWithFrame:self.bounds];
        _photoImageView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _photoImageView;
}

-(KBCustomPhotoCollectionCellOverLayer *)overLayer{
    if (!_overLayer) {
        _overLayer=[[KBCustomPhotoCollectionCellOverLayer alloc]initWithFrame:self.bounds];
        _overLayer.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    return _overLayer;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoImageView];
    }
    return self;
}

-(void)showOverLayer{
    [self.contentView addSubview:self.overLayer];
}

-(void)hideOverLayer{
    [_overLayer removeFromSuperview];
    _overLayer=nil;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected && self.showOverLayerWhenSelected) {
        [self hideOverLayer];
        [self showOverLayer];
    }else{
        [self hideOverLayer];
    }
}

#pragma mark-Getter Setter
-(void)setThumbImage:(UIImage *)thumbImage{
    if (thumbImage==nil) {
        _photoImageView.image=[UIImage imageNamed:@"compose_photograph"];
    }else{
        _photoImageView.image=thumbImage;
    }
    
}



@end
