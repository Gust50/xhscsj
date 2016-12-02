//
//  CLSHMerchantJoinProcessVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMerchantJoinProcessVC.h"
#import "CLSHJoinProgressVC.h"
#import "CLSHCertificationVC.h"

@interface CLSHMerchantJoinProcessVC ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *merchantAdvHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *merchantProgressTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *merchantProgressBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *joinTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *joinHeight;


@property (strong, nonatomic) IBOutlet UIButton *join;


@end

@implementation CLSHMerchantJoinProcessVC

- (void)modify
{
    self.joinHeight.constant = 40*AppScale;
    self.joinTop.constant = 30*AppScale;
    self.merchantProgressBottom.constant = 20*AppScale;
    self.merchantProgressTop.constant = 20*AppScale;
    self.merchantAdvHeight.constant = 120*AppScale;
    self.backViewBottom.constant = 100*AppScale;
    self.join.layer.cornerRadius = 5.0*AppScale;
    self.join.layer.masksToBounds = YES;
    self.join.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = backGroundColor;
//    self.navigationController.navigationBar.backgroundColor = systemColor;
    [self.navigationItem setTitle:@"入驻流程"];
}

//立即入驻
- (IBAction)immediatelyJoin:(UIButton *)sender {
//    CLSHJoinProgressVC *joinProgressVC = [[CLSHJoinProgressVC alloc] init];
//    joinProgressVC.shopId = self.shopId;
//    [self.navigationController pushViewController:joinProgressVC animated:YES];
    
        CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
        certificationVC.shopId = self.shopId;
        certificationVC.isJoinProgress = YES;
        [self.navigationController pushViewController:certificationVC animated:YES];
    
}

#pragma mark - setter getter
-(void)setShopId:(NSString *)shopId
{
    _shopId = shopId;
}
@end
