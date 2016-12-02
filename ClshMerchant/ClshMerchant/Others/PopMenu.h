//
//  PopMenu.h
//  新浪微博
//
//  Created by jose on 15-3-15.
//  Copyright (c) 2015年 jose. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明这是一个类，因为没先定义所以要先声明，下面的协议才可以使用
@class PopMenu;
//下拉菜单方向
typedef enum{
    Center=0,
    Left=1,
    Right=2,
}Positon;
//定义一个协议
@protocol  MyPopMenuDelegate<NSObject>
@optional
//协议的一个方法
-(void)PopMenuDissMissed:(PopMenu *)popmenu;
@end

@interface PopMenu : UIView

//两个初始化方法
-(instancetype)initWithContenView:(UIView *)contenview;
+(instancetype)PopMenuWithContenView:(UIView *)contenview;
//设置背景图片
-(void)SetBackGroundImg:(UIImage *)backgroundimg;
//显示菜单
-(void)ShowMenu:(CGRect)rect;
//菜单消失
-(void)DissMissMenu;
//设置下拉菜单箭头指示方向
-(void)SetPosition:(Positon)arrowposition;
//声明一个代理变量
@property(nonatomic,strong)id<MyPopMenuDelegate>delegate;
//获取dimBackground
@property(nonatomic,assign,getter=isdimBackground)BOOL dimBackground;
@property(nonatomic,assign)Positon arrow;


@end
