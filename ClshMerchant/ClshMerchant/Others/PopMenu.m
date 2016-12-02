//
//  PopMenu.m
//  新浪微博
//
//  Created by jose on 15-3-15.
//  Copyright (c) 2015年 jose. All rights reserved.
//

#import "PopMenu.h"
#import "UIView+Extension.h"

//给接口添加自己的变量，只能由该类访问
@interface PopMenu()
//添加要显示的视图
@property(nonatomic,strong)UIView *contentview;
//用来装要显示视图的容器
@property(nonatomic,strong)UIImageView *containerview;
//添加一个button按钮的蒙板，用来相应下拉菜单显示的事件
@property(nonatomic,strong)UIButton *coverbutton;
@end

@implementation PopMenu

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //添加按钮蒙板
        UIButton *cover=[[UIButton alloc]init];
        cover.backgroundColor=[UIColor clearColor];
        [self addSubview:cover];
        [cover addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
        //初始化赋值
        self.coverbutton=cover;
        //添加容器
        UIImageView *container=[[UIImageView alloc]init];
        //设置为可交互的
        container.userInteractionEnabled=YES;
        container.size=CGSizeMake(200, 200);
//        container.image=[UIImage resizedimg:@"popover_background@2x"];
        [self addSubview:container];
        //初始化赋值
        self.containerview=container;
    }
    return self;
}

-(instancetype)initWithContenView:(UIView *)contenview{
    if (self=[super init]) {
        self.contentview=contenview;
    }
    return self;
}
//静态方法
+(instancetype)PopMenuWithContenView:(UIView *)contenview{
    return [[self alloc]initWithContenView:contenview];
}

//设置按钮的大小，让它覆盖全屏
-(void)layoutSubviews{
    [super layoutSubviews];
    self.coverbutton.frame=self.bounds;
}

//设置容器背景图片
-(void)SetBackGroundImg:(UIImage *)backgroundimg{
    self.containerview.image=backgroundimg;
}

//显示菜单
-(void)ShowMenu:(CGRect)rect{
    //获取主窗口
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    self.frame=window.bounds;
    [window addSubview:self];
    //设置容器的大小
    self.containerview.frame=rect;
    //把视图添加到容器上面
    [self.containerview addSubview:self.contentview];
    //设置视图在容器中的显示位置
    CGFloat topmargin=12;
    CGFloat leftmargin=5;
    CGFloat rightmargin=5;
    CGFloat bottommargin=8;
    self.contentview.y=topmargin;
    self.contentview.x=leftmargin;
    self.contentview.width=self.containerview.width-leftmargin-rightmargin;
    self.contentview.height=self.containerview.height-topmargin-bottommargin;
}

//取消菜单显示
-(void)DissMissMenu{
    if([self.delegate respondsToSelector:@selector(PopMenuDissMissed:)]){
        [self.delegate PopMenuDissMissed:self];
    }
    [self removeFromSuperview];
}

//按钮响应事件
-(void)button{
    [self DissMissMenu];
}

//设置下拉菜单箭头的指示方向
//-(void)SetPosition:(Positon)arrowposition{
//    _arrow=arrowposition;
//    switch (_arrow) {
//        case Center:
//            self.containerview.image=[UIImage resizedimg:@"popover_background@2x"];
//            break;
//            case Left:
//            self.containerview.image=[UIImage resizedimg:@"popover_background_left@2x"];
//            break;
//            case Right:
//            self.containerview.image=[UIImage resizedimg:@"popover_background_right@2x"];
//        default:
//            break;
//    }
//}
#pragma mark
//重写set方法
-(void)setDimBackground:(BOOL)dimBackground{
    _dimBackground=dimBackground;
    if(self.isdimBackground){
        self.coverbutton.backgroundColor=[UIColor blackColor];
        self.coverbutton.alpha=0.3;
    }
    else{
        self.coverbutton.backgroundColor=[UIColor clearColor];
        self.coverbutton.alpha=1.0;
    }
}
@end
