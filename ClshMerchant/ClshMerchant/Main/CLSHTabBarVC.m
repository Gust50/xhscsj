//
//  CLSHTabBarVC.m
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


#import "CLSHTabBarVC.h"
#import "CLSHNavigationVC.h"
#import "CLSHHomeVC.h"
#import "CLSHStoreVC.h"
#import "CLSHLoginViewController.h"
@interface CLSHTabBarVC ()<UITabBarControllerDelegate>
@property (nonatomic, strong) CLSHHomeVC *cLSHHomeVC;
@property (nonatomic, strong) CLSHStoreVC *cLSHStoreVC;
@property (nonatomic, strong) CLSHLoginViewController *cLSHLoginViewController;
@end

@implementation CLSHTabBarVC


#pragma mark <lazyLoad>

-(CLSHHomeVC *)cLSHHomeVC{
    if (!_cLSHHomeVC) {
        _cLSHHomeVC=[CLSHHomeVC new];
    }
    return _cLSHHomeVC;
}

-(CLSHStoreVC *)cLSHStoreVC{
    if (!_cLSHStoreVC) {
        _cLSHStoreVC=[CLSHStoreVC new];
    }
    return _cLSHStoreVC;
}

-(CLSHLoginViewController *)cLSHLoginViewController{
    if (!_cLSHLoginViewController) {
        _cLSHLoginViewController=[CLSHLoginViewController new];
    }
    return _cLSHLoginViewController;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    [self setupTabbarBackground];
    [self initWithTabbar];
    
}

#pragma mark <setup tabbar background color>
-(void)setupTabbarBackground{
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent=NO;
}

#pragma mark <initTabbar>
-(void)initWithTabbar{
    
    [self addSubviews:self.cLSHHomeVC title:@"首页" imageName:@"Home_normal" selectImageName:@"Home_select"];
    [self addSubviews:self.cLSHStoreVC title:@"店铺" imageName:@"Store_normal" selectImageName:@"Store_select"];
//    [self addSubviews:self.categoryVC title:@"分类" imageName:@"Category_normal" selectImageName:@"Category_select"];
//    [self addSubviews:self.discoverVC title:@"发现" imageName:@"Discover_normal" selectImageName:@"Discover_select"];
//    [self addSubviews:self.neighborhoodVC title:@"附近" imageName:@"Circle_normal" selectImageName:@"Circle_select"];
//    [self addSubviews:self.accountTableVC title:@"我的" imageName:@"Account_normal" selectImageName:@"Account_select"];
}

//添加子控制器
-(void)addSubviews:(UIViewController *)subviews title:(NSString *)title imageName:(NSString *)imagename selectImageName:(NSString *)selectimagename{
    
    subviews.tabBarItem.title=title;
    UIImage *img=[UIImage imageNamed:imagename];
    img=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    subviews.tabBarItem.image=img;
    UIImage *select_img=[UIImage imageNamed:selectimagename];
    //不对图形进行渲染，ios7会自动对图形进行渲染
    select_img=[select_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    subviews.tabBarItem.selectedImage=select_img;
    //包装导航控制器
    CLSHNavigationVC *mnavigation=[[CLSHNavigationVC alloc]initWithRootViewController:subviews];
    //设置普通状态下的颜色
    NSMutableDictionary *TextAttribute=[NSMutableDictionary dictionary];
    TextAttribute[NSFontAttributeName]=[UIFont systemFontOfSize:11];
    TextAttribute[NSForegroundColorAttributeName]=systemFontColor;
    [subviews.tabBarItem setTitleTextAttributes:TextAttribute forState:UIControlStateNormal];
    //设置选中状态下的颜色
    NSMutableDictionary *SelectedTextAttribute=[NSMutableDictionary dictionary];
    SelectedTextAttribute[NSFontAttributeName]=[UIFont systemFontOfSize:11];
    SelectedTextAttribute[NSForegroundColorAttributeName]=systemColor;
    [subviews.tabBarItem setTitleTextAttributes:SelectedTextAttribute forState:UIControlStateSelected];
    //添加子控器
    [self addChildViewController:mnavigation];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
//    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin==NO) {
//        if ([viewController.tabBarItem.title isEqualToString:@"店铺"]) {
//            [self presentViewController:self.cLSHLoginViewController animated:YES completion:nil];
//            return NO;
//        }
//    }
    return YES;
}
@end
