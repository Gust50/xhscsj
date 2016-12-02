//
//  CLSHBaseViewVC.m
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


#import "CLSHBaseViewVC.h"

@interface CLSHBaseViewVC ()
@property (nonatomic, copy) leftBarButtonBlock leftBarButtonBlock;
@property (nonatomic, copy) rightBarButtonBlock rightBarButtonBlock;
@end

@implementation CLSHBaseViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}


-(void)configureLeftBarButtonWithTitle:(NSString *)title
                             normalImg:(NSString *)normalImg
                             selectImg:(NSString *)selectImg
                                action:(leftBarButtonBlock)action{
    
    self.leftBarButtonBlock=action;
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem normalTitle:title selectTitle:title normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:normal selectImage:selectImg target:self action:@selector(leftAtion) size:CGSizeMake(50*AppScale, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}




-(void)configureRightBarButtonWithTitle:(NSString *)title
                              normalImg:(NSString *)normalImg
                              selectImg:(NSString *)selectImg
                                 action:(rightBarButtonBlock)action{
    
    self.rightBarButtonBlock=action;
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem normalTitle:title selectTitle:title normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:normal selectImage:selectImg target:self action:@selector(rightAction) size:CGSizeMake(50*AppScale, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}

-(void)leftAtion{
    if (self.leftBarButtonBlock) {
        self.leftBarButtonBlock();
    }
}

-(void)rightAction{
    if (self.rightBarButtonBlock) {
        self.rightBarButtonBlock();
    }
}

@end
