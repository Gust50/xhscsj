//
//  CLGSStarRate.h
//  粗粮
//
//  Created by kobe on 16/5/16.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLGSStarRate;
//使用代理获取评价星的百分百比
typedef void(^GetStarPercent)(CGFloat starPercent);
@protocol MStarRateViewDelegate <NSObject>
@optional
-(void)starRateView:(CLGSStarRate *)starRateView scorePercentChange:(CGFloat)newScorePercent;
@end

@interface CLGSStarRate : UIView
/** 得分值，最大是1 */
@property(nonatomic,assign)CGFloat scorePercent;
/** 是否支持动画 */
@property(nonatomic,assign)BOOL iSAnimation;
/** 是否允许不是整星评价 */
@property(nonatomic,assign)BOOL iSAllowInCompleteStar;
/** 代理 */
@property(nonatomic,weak)id<MStarRateViewDelegate>delegate;

/** 声明一个block变量 */
@property(nonatomic,copy)GetStarPercent getStarPercent;
//初始化
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
@end
