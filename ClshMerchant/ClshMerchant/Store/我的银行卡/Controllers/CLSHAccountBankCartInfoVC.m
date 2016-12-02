//
//  CLSHAccountBankCartInfoVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/23.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHAccountBankCartInfoVC.h"
#import "CLSHBankCartInfoView.h"
#import "CLSHAccountCardBankModel.h"
#import "CLSHMyBankFooterView.h"
#import "CLSHInputCheckCodeVC.h"

@interface CLSHAccountBankCartInfoVC ()<UIActionSheetDelegate>
{
    CLSHAccountCardBankModel *deleteBankCartModel;  ///<删除银行卡数据模型
    NSMutableDictionary *params;    ///<银行卡ID参数
}

@property (nonatomic, strong) CLSHBankCartInfoView *bankCartInfoView;   ///<银行卡信息


@end

@implementation CLSHAccountBankCartInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"银行卡信息"];
    self.view.backgroundColor = backGroundColor;
    deleteBankCartModel = [[CLSHAccountCardBankModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    self.bankCartInfoView = [[CLSHBankCartInfoView alloc] initWithFrame:CGRectMake(0, 74, SCREENWIDTH, 303*AppScale)];
    self.bankCartInfoView.accountCardBankListModel = self.accountCardBankListModel;
    [self.view addSubview:self.bankCartInfoView];
    CLSHMyBankFooterView *footer = [[CLSHMyBankFooterView alloc] initWithFrame:CGRectMake(0, 377*AppScale, SCREENWIDTH, 100*AppScale)];
    
    footer.addBankCartBlock = ^(){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles: nil];
        [sheet showInView:self.view];
    };
    [footer.addBankCart setTitle:@"删除" forState:UIControlStateNormal];
    [self.view addSubview:footer];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        CLSHInputCheckCodeVC *checkVC = [[CLSHInputCheckCodeVC alloc] init];
        checkVC.name = @"删除银行卡";
        checkVC.bankAcountID = self.accountCardBankListModel.bankAccountId;
        [self.navigationController pushViewController:checkVC animated:YES];
        
//        params[@"bankAccountId"] = self.accountCardBankListModel.bankAccountId;
//        [deleteBankCartModel fetchAccountDelectCardBankModel:params callBack:^(BOOL isSuccess, id result) {
//            if (isSuccess) {
////                [MBProgressHUD showSuccess:@"删除成功！"];
//               
//                
//            }else
//            {
//                [MBProgressHUD showError:result];
//            }
//        }];
    }
}

#pragma mark - setter getter

-(void)setAccountCardBankListModel:(CLSHAccountCardBankListModel *)accountCardBankListModel
{
    _accountCardBankListModel = accountCardBankListModel;
}

@end
