//
//  CLSHApplicationSubmitSucVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHApplicationSubmitSucVC.h"
#import "AppDelegate.h"
#import "CLSHLoginViewController.h"
#import "UIBarButtonItem+KBExtension.h"

@interface CLSHApplicationSubmitSucVC (){

    UIBarButtonItem * oneItem;
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *smallDescribeHeight;


@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UILabel *smallDescribe;

@end

@implementation CLSHApplicationSubmitSucVC

- (void)modify
{
    self.backViewHeight.constant = 250*AppScale;
    self.iconTop.constant = -30*AppScale;
    self.iconWidth.constant = 50*AppScale;
    self.iconHeight.constant = 50*AppScale;
    self.describeTop.constant = 10*AppScale;
    self.describeHeight.constant = 30*AppScale;
    self.smallDescribeHeight.constant = 30*AppScale;
    self.describe.font = [UIFont systemFontOfSize:16*AppScale];
    self.smallDescribe.font = [UIFont systemFontOfSize:10*AppScale];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"提交成功"];
    if (self.fromLogin) {
        [self setNav];
    }
    oneItem = [UIBarButtonItem normalTitle:@"返回" selectTitle:@"返回" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:@"arrowWhite" selectImage:@"arrowWhite" target:self action:@selector(BackTologinVC) size:CGSizeMake(60, 30) titleFont:[UIFont systemFontOfSize:14]];
    self.navigationItem.leftBarButtonItem = oneItem;
}

//设置导航条
- (void)setNav{

//    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithTitle:@"切换账号" style:(UIBarButtonItemStylePlain) target:self action:@selector(BackToLogin)];
    UIBarButtonItem * rightBar = [UIBarButtonItem normalTitle:@"切换账号" selectTitle:@"切换账号" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(BackToLogin) size:CGSizeMake(100, 30) titleFont:[UIFont systemFontOfSize:13*AppScale]];
    self.navigationItem.rightBarButtonItem=rightBar;
}

- (void)BackTologinVC{

    ShareApp.window.rootViewController = [CLSHLoginViewController new];
}

- (void)BackToLogin{

    ShareApp.window.rootViewController = [CLSHLoginViewController new];
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    self.navigationItem.hidesBackButton = NO;
}

@end
