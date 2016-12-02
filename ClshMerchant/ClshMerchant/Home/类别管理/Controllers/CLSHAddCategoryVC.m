//
//  CLSHAddCategoryVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHAddCategoryVC.h"
#import "CLSHCategoryManageModel.h"

@interface CLSHAddCategoryVC ()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;


@property (strong, nonatomic) IBOutlet UITextField *inputCategoryName;
@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UIButton *add;

@end

@implementation CLSHAddCategoryVC

- (void)modify
{
    self.inputTop.constant = 64+20*AppScale;
    self.inputHeight.constant = 40*AppScale;
    self.describeTop.constant = 10*AppScale;
    self.describeHeight.constant = 20*AppScale;
    self.addTop.constant = 30*AppScale;
    self.addHeight.constant = 40*AppScale;
    self.inputCategoryName.font = [UIFont systemFontOfSize:12*AppScale];
    self.describe.font = [UIFont systemFontOfSize:10*AppScale];
    self.describe.textColor = RGBColor(96, 96, 96);
    self.add.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    [self.add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.add.backgroundColor = systemColor;
    self.add.layer.cornerRadius = 5.0;
    self.add.layer.masksToBounds = YES;
    self.inputCategoryName.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"添加分类"];
}

//确认添加
- (IBAction)confirmAddCategory:(UIButton *)sender {
    if (self.inputCategoryName.text.length) {
        
        CLSHAddCategoryModel * addCategoryModel = [[CLSHAddCategoryModel alloc] init];
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"name"] = self.inputCategoryName.text;
        [addCategoryModel fetchAddCategoryData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                [MBProgressHUD showSuccess:@"添加成功"];
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [MBProgressHUD showError:@"添加失败"];
            }
        }];
    }else{
    
        [MBProgressHUD showError:@"请输入类别名称!"];
    }
    
}

@end
