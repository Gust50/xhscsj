//
//  ViewController.m
//  ClshMerchant
//
//  Created by kobe on 16/7/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 64, 100, 100)];
    btn.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:btn];
    
    DLog(@"输出");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
