//
//  CLSHUpLoadImgCell.m
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


#import "CLSHUpLoadImgCell.h"

@interface CLSHUpLoadImgCell ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CLSHUpLoadImgCell

#pragma mark <lazyLoad>
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[UIScrollView new];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.scrollEnabled=YES;
        _scrollView.bounces=NO;
    }
    return _scrollView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=backGroundColor;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.scrollView];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark <getter setter>
-(void)setImgArr:(NSArray *)imgArr{
    _imgArr=imgArr;
    
    for (UIImageView *imgView in _scrollView.subviews) {
        if ([imgView isKindOfClass:[UIImageView class]]) {
            [imgView removeFromSuperview];
        }
    }
    
    for (int i=0; i<imgArr.count; i++) {
        
        //create ImgageView
        UIImageView *imgView=[UIImageView new];
        imgView.frame=CGRectMake(10+i*80+i*5, 10, 80, 80);
        imgView.image=imgArr[i];
        imgView.userInteractionEnabled=YES;
        if (i==imgArr.count-1) {
            
            UITapGestureRecognizer *chooseImgTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImg:)];
            [imgView addGestureRecognizer:chooseImgTap];
        }else{
            
            UIButton *delectImg=[UIButton buttonWithType:0];
            delectImg.frame=CGRectMake(80-18, 0, 18, 18);
            [delectImg setImage:[UIImage imageNamed:@"delete"] forState:0];
            delectImg.tag=i;
            [delectImg addTarget:self action:@selector(deleteImgTap:) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview:delectImg];
            
        }
        
        [_scrollView addSubview:imgView];
    }
    _scrollView.pagingEnabled=YES;
    _scrollView.contentSize=CGSizeMake(80*imgArr.count+(imgArr.count-1)*5+20, 80);
}


-(void)setIsUrl:(BOOL)isUrl{
    _isUrl=isUrl;
}

#pragma mark <otherResponse>
-(void)deleteImgTap:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImgBtn:)]) {
        [self.delegate deleteImgBtn:_imgArr[btn.tag]];
    }
    
}
-(void)chooseImg:(UITapGestureRecognizer *)gesture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickUpLoadImgBtn)]) {
        [self.delegate clickUpLoadImgBtn];
    }
}

@end
