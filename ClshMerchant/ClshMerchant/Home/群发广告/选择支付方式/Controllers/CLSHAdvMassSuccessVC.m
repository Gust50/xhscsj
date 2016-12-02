//
//  CLSHAdvMassSuccessVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHAdvMassSuccessVC.h"

@interface CLSHAdvMassSuccessVC ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;


@property (strong, nonatomic) IBOutlet UILabel *describe;

@end

@implementation CLSHAdvMassSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iconTop.constant = 64+100*AppScale;
    self.iconWidth.constant = 60*AppScale;
    self.iconHeight.constant = 60*AppScale;
    self.describeTop.constant = 10*AppScale;
    self.describeHeight.constant = 20*AppScale;
    self.describe.font = [UIFont systemFontOfSize:14*AppScale];
    
    [self.navigationItem setTitle:@"支付成功"];
    self.view.backgroundColor = backGroundColor;
}

@end
