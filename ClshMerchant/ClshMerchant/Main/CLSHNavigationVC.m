//
//  CLSHNavigationVC.m
//  ClshUser
//
//  Created by kobe on 16/5/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHNavigationVC.h"

@interface CLSHNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation CLSHNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate=self;
    [self hideNavBlackLine];
    
}

#pragma mark <重写导航控制的方法>
/**
 *  拦截导航控制器
 *
 *  @param viewController 控制器
 *  @param animated       是否使用动画
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
        
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem normalTitle:@"返回" selectTitle:@"返回" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:@"arrowWhite" selectImage:@"arrowWhite" target:self action:@selector(back) size:CGSizeMake(50*AppScale, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
    }
    
    [super pushViewController:viewController animated:YES];
}

/**
 *  该方法只初始化一次
 */
+(void)initialize{
    //设置导航栏字体的颜色
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:16*AppScale]}];
    //设置导航栏的背景色
    [[UINavigationBar appearance] setBarTintColor:systemColor];
}


#pragma mark <UIGestureRecognizerDelegate>
/**
 *  每当用户触发时都会调用一次这个方法
 *
 *  @param gestureRecognizer  gestureRecognizer
 *
 *  @return 返回YES则手势有效
 */
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    //防止出现黑边情况
    return self.childViewControllers.count>1;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
    }
    
    return  YES;
}


#pragma mark <otherResponse>
/**
 *  控制器出栈
 */
-(void)back{
    
    [self popViewControllerAnimated:YES];
}


/**
 *  隐藏黑线
 */
-(void)hideNavBlackLine{
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id object in list) {
            if ([object isKindOfClass:[UIImageView class]]) {
                UIImageView *imageViews=(UIImageView *)object;
                imageViews.hidden=YES;
            }
        }
    }
}
@end
