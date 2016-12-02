//
//  CLSHInputNewPasswordVC.m
//  ClshUser
//
//  Created by wutaobo on 16/7/6.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHInputNewPasswordVC.h"
#import "CLSHModifyPasswordModel.h"
#import "CLSHPersonalSettingViewController.h"

@interface CLSHInputNewPasswordVC ()
{
    CLSHModifyPasswordModel *modifyPasswordModel;    ///<修改密码数据模型
    NSMutableDictionary *params;
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewheight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oldPasswordWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *modifyPasswordWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *repeatWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmHeight;


@property (strong, nonatomic) IBOutlet UILabel *oldPasswordLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputOldPassword;
@property (strong, nonatomic) IBOutlet UILabel *modifyPasswordLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputModifyPassword;
@property (strong, nonatomic) IBOutlet UILabel *repeatPasswordLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputRepeatPassword;
@property (strong, nonatomic) IBOutlet UIButton *confirm;

@end

@implementation CLSHInputNewPasswordVC

//修改属性
- (void)modify
{
    self.inputRepeatPassword.borderStyle = UITextBorderStyleNone;
    self.inputModifyPassword.borderStyle = UITextBorderStyleNone;
    self.inputOldPassword.borderStyle = UITextBorderStyleNone;
    self.backViewheight.constant = 152*AppScale;
    self.oldPasswordWidth.constant = 80*AppScale;
    self.modifyPasswordWidth.constant = 80*AppScale;
    self.repeatWidth.constant = 80*AppScale;
    self.confirmHeight.constant = 40*AppScale;
    self.oldPasswordLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.modifyPasswordLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.repeatPasswordLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputOldPassword.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputOldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputModifyPassword.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputModifyPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputRepeatPassword.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputRepeatPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirm.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.confirm.layer.cornerRadius = 5.0;
    self.confirm.layer.masksToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    [self.navigationItem setTitle:@"修改密码"];
    self.view.backgroundColor = backGroundColor;
    modifyPasswordModel = [[CLSHModifyPasswordModel alloc] init];
    params = [NSMutableDictionary dictionary];
}

//确认
- (IBAction)confirmModifyPassword:(UIButton *)sender {
    
    
    if ([self.inputOldPassword.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入旧密码！"];
        return;
    }else if ([self.inputModifyPassword.text isEqualToString:@""]){
        
        [MBProgressHUD showError:@"请输入新密码！"];
        return;
    }else if (self.inputModifyPassword.text.length < 6){
        
        [MBProgressHUD showError:@"请输入至少六位数的密码！"];
        return;
    }else if ([self.inputRepeatPassword.text isEqualToString:@""]){
        [MBProgressHUD showError:@"请确认密码！"];
        return;
    }else if ([self.inputOldPassword.text isEqualToString:self.inputModifyPassword.text]){
        [MBProgressHUD showError:@"新密码和旧密码不能相同！"];
        return;
    }else if (![self.inputModifyPassword.text isEqualToString:self.inputRepeatPassword.text]){
        [MBProgressHUD showError:@"新密码输入不相等！"];
        return;
    }
    
    params[@"oldPassword"] = self.inputOldPassword.text;
    params[@"newPassword"] = self.inputModifyPassword.text;
    params[@"smsToken"] = self.code;
    
    [modifyPasswordModel fetchAccountModifyPasswordModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            [MBProgressHUD showSuccess:@"密码修改成功！"];
            //返回到指定控制器
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[CLSHPersonalSettingViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else
        {
            [MBProgressHUD showError:@"密码修改失败，请重新修改！"];
        }
    }];
    
}

#pragma mark - setter getter
-(void)setCode:(NSString *)code
{
    _code = code;
}

@end
