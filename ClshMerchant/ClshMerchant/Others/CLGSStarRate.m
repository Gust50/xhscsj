//
//  CLGSStarRate.m
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLGSStarRate.h"

@interface CLGSStarRate()

/** 前景星星视图 */
@property(nonatomic,strong)UIView *foregroundStarView;
/** 背景星星视图 */
@property(nonatomic,strong)UIView *backgroundStarView;
/** 星星的个数 */
@property(nonatomic,assign)NSInteger numberOfStars;

@end

@implementation CLGSStarRate

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars{
    if (self=[super initWithFrame:frame]) {
        _numberOfStars=numberOfStars;
    }
    [self setUI];
    return self;
}

//设置UI
-(void)setUI{
    
    //设置默认的数据
    _scorePercent=1;
    _iSAnimation=NO;
    _iSAllowInCompleteStar=NO;
    
    //创建评星视图
    self.foregroundStarView=[self createStarViewWithImage:@"ScoreStar_select"];
    self.backgroundStarView=[self createStarViewWithImage:@"ScoreStar_normal"];
    
    //注意顺序
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    //添加手势识别
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick:)];
    //触摸时候手指的数
    tapGesture.numberOfTapsRequired=1;
    [self addGestureRecognizer:tapGesture];
}

//手势识别的响应
-(void)tapGestureClick:(UITapGestureRecognizer *)tapGesture{
    //获取触摸点的位置
    CGPoint tapPoint=[tapGesture locationInView:self];
    //获取x的坐标位置
    CGFloat offset=tapPoint.x;
    //获取星星位置
    CGFloat currentStartScore=offset/(self.bounds.size.width/self.numberOfStars);
    //是否使用整星评价
    CGFloat starScore=self.iSAllowInCompleteStar ? currentStartScore:ceilf(currentStartScore);
    //计算星星的百分比
    self.scorePercent=starScore/self.numberOfStars;
    if (self.getStarPercent) {
        self.getStarPercent(starScore/self.numberOfStars);
    }
}


//使用图片创建评星视图
-(UIView *)createStarViewWithImage:(NSString *)imageName{
    UIView *starView=[[UIView alloc]initWithFrame:self.bounds];
    //裁剪超出父视图多余的部分
    starView.clipsToBounds=YES;
    starView.backgroundColor=[UIColor clearColor];
    //添加星星
    for (NSInteger i=0; i<self.numberOfStars; i++) {
        UIImageView *star=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        star.frame=CGRectMake(i*(self.bounds.size.width/self.numberOfStars), 0, self.bounds.size.width/self.numberOfStars, self.bounds.size.height);
        star.contentMode=UIViewContentModeScaleAspectFit;
        [starView addSubview:star];
    }
    return starView;
}

//重新布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //避免循环引用
    __weak CLGSStarRate *weakSelf=self;
    CGFloat animationTime=self.iSAnimation ? 0.3:0;
    [UIView animateWithDuration:animationTime animations:^{
        weakSelf.foregroundStarView.frame=CGRectMake(0, 0, weakSelf.bounds.size.width*weakSelf.scorePercent, weakSelf.bounds.size.height);
    }];
    
}

//重写set的方法，设置星的分数，满星是1
-(void)setScorePercent:(CGFloat)scorePercent{
    if (_scorePercent==scorePercent) {
        return;
    }
    if (scorePercent<0) {
        _scorePercent=0;
    }else if (scorePercent>1){
        _scorePercent=1;
    }else{
        _scorePercent=scorePercent;
    }
    if ([self.delegate respondsToSelector:@selector(starRateView:scorePercentChange:)]) {
        [self.delegate starRateView:self scorePercentChange:scorePercent];
    }
    //刷新布局子控件
    [self setNeedsLayout];
}

@end
