//
//  CLSHMyBankCartVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHMyBankCartVC.h"
#import "CLSHNullCategoryView.h"
#import "CLSHMyBankCartCell.h"
#import "CLSHAddBankCartVC.h"
#import "CLSHAccountBankCartInfoVC.h"
#import "CLSHAccountCardBankModel.h"
#import "CLSHMyBankFooterView.h"
#import "CLSHCertificationVC.h"

@interface CLSHMyBankCartVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CLSHAccountCardBankModel *accountCardBankModel;                     ///<银行卡数据模型
    CLSHNullCategoryView *nullBankCartList;        ///<没有银行卡显示
    
    NSString *bankCartID;   ///<银行卡ID

}
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation CLSHMyBankCartVC

static NSString *const ID = @"cell";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"我的银行卡"];
    accountCardBankModel=[[CLSHAccountCardBankModel alloc]init];
    
    //注册cell
    [self.tableView registerClass:[CLSHMyBankCartCell class] forCellReuseIdentifier:ID];
    [self.view addSubview:self.tableView];

    CLSHMyBankFooterView *footer = [[CLSHMyBankFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*AppScale)];
    //添加银行卡
    footer.addBankCartBlock = ^(){
        CLSHAddBankCartVC *addBankCart = [[CLSHAddBankCartVC alloc] init];
        [self.navigationController pushViewController:addBankCart animated:YES];
    };
    self.tableView.tableFooterView = footer;
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    [self loadFooter];
    
    //默认选择第一个
    if ([self.name isEqualToString:@"申请提现"]) {
        if (accountCardBankModel.bankAccountList.count != 0) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar  lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    [self loadData];
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.navigationController.navigationBar lt_reset];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

#pragma mark <loadFooter>
- (void)loadFooter
{
    nullBankCartList = [[CLSHNullCategoryView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
    nullBankCartList.icon.image = [UIImage imageNamed:@"NullBankListIcon"];
    nullBankCartList.describe.text = @"您还没有添加银行卡";
    [nullBankCartList.addCategory setTitle:@"添加" forState:UIControlStateNormal];

    WS(weakSelf);
    nullBankCartList.addCategoryBlock = ^(){
        
        NSString * status = [[NSUserDefaults standardUserDefaults] objectForKey:@"certification"];
        if ([status isEqualToString:@"success"]) {
            
            CLSHAddBankCartVC *addBankCart = [[CLSHAddBankCartVC alloc] init];
            [weakSelf.navigationController pushViewController:addBankCart animated:YES];
            
        }else if([status isEqualToString:@"reviewing"]){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message: @"您的身份验证正在审核中，请耐心等待!" preferredStyle:1];
            UIAlertAction *viewCancle = [UIAlertAction actionWithTitle:@"确定" style:1 handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:viewCancle];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        else{
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您的身份尚未验证，请先实名认证" message: @"是否修改或编辑实名认证" preferredStyle:1];
            UIAlertAction *viewCancle = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *viewSure =  [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
                CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
                certificationVC.isFaildCertification = YES;
                [weakSelf.navigationController pushViewController:certificationVC animated:YES];
            }];
            
            [alert addAction:viewCancle];
            [alert addAction:viewSure];
            
            [weakSelf presentViewController:alert animated:YES completion:nil];
            
        }

    };
    [self.view addSubview:nullBankCartList];
    
}

#pragma mark <loadData>
-(void)loadData{
    [accountCardBankModel fetchAccountCardBankModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            accountCardBankModel = result;
            
            if (!accountCardBankModel.bankAccountList.count) {
                [self loadFooter];
            }else
            {
                [nullBankCartList removeFromSuperview];
            }
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return accountCardBankModel.bankAccountList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHMyBankCartCell *bankCartCell = [tableView dequeueReusableCellWithIdentifier:ID];
    bankCartCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!bankCartCell) {
        bankCartCell = [[CLSHMyBankCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    bankCartCell.name = self.name;
    if (indexPath.row == 0) {
        bankCartCell.selected = YES;
    }
    bankCartCell.accountCardBankListModel = accountCardBankModel.bankAccountList[indexPath.row];
    return bankCartCell;
}

#pragma mark - tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110*AppScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHAccountCardBankListModel *listModel = accountCardBankModel.bankAccountList[indexPath.row];
    if ([self.name isEqualToString:@"个人中心"]) {
        CLSHAccountBankCartInfoVC *bankCartInfo = [[CLSHAccountBankCartInfoVC alloc] init];
        
            bankCartInfo.accountCardBankListModel = listModel;
        
        [self.navigationController pushViewController:bankCartInfo animated:YES];
    }else
    {
        CLSHMyBankCartCell *cell=(CLSHMyBankCartCell *)[tableView cellForRowAtIndexPath:indexPath];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"bankCartID"] = listModel.bankAccountId;
        params[@"bankCategory"] = listModel.bankCategory;
        params[@"bankAccountImg"] = listModel.bankAccountImg;
        params[@"bankAccountNumber"] = listModel.bankAccountNumber;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bankCartID" object:nil userInfo:params];
        cell.selected=YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.name isEqualToString:@"个人中心"]) {
        
    }else
    {
        CLSHMyBankCartCell *cell=(CLSHMyBankCartCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selected=NO;
    }
}

#pragma mark <otherResponse>
////设置导航栏
//- (void)setNavigationBar
//{
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalImage:@"AddBankCartIconWhite" selectImage:@"AddBankCartIconWhite" target:self action:@selector(addBankCartEven)];
//}
////添加银行卡
//- (void)addBankCartEven
//{
//    CLSHAddBankCartVC *addBankCart = [[CLSHAddBankCartVC alloc] init];
//    [self.navigationController pushViewController:addBankCart animated:YES];
//}

//setter getter
-(void)setBankCartCount:(NSInteger)bankCartCount
{
    _bankCartCount = bankCartCount;
    
}

-(void)setName:(NSString *)name
{
    _name = name;
}

@end
