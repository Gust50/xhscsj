//
//  CLSHEditCategoryManagementVC.m
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


#import "CLSHEditCategoryManagementVC.h"
#import "CLSHInputCategoryCell.h"
#import "CLSHSelectPriorityCell.h"
#import "CLSHCategoryFooterView.h"
#import "CLSHDeleteCategoryView.h"
#import "CLSHCategoryManageModel.h"

@interface CLSHEditCategoryManagementVC (){

//    NSString * name;
    NSMutableDictionary * params;
}

@end

static NSString *const inputID = @"CLSHInputCategoryCell";
static NSString *const selectID = @"CLSHSelectPriorityCell";

@implementation CLSHEditCategoryManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"编辑"];
    [self setNavigationBar];
    DLog(@"-----%@",self.categoryID);
    params = [NSMutableDictionary dictionary];
    
    //注册cell
    [self.tableView registerClass:[CLSHInputCategoryCell class] forCellReuseIdentifier:inputID];
    [self.tableView registerClass:[CLSHSelectPriorityCell class] forCellReuseIdentifier:selectID];
    
    CLSHCategoryFooterView *footerView = [[CLSHCategoryFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*AppScale)];
    [footerView.addCategory setTitle:@"保  存" forState:UIControlStateNormal];
    self.tableView.tableFooterView = footerView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPriority:) name:@"getPriority" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCategoryName:) name:@"getCategoryName" object:nil];
    
    
    WS(weakSelf);
    footerView.addCategoryBlock = ^(){
        DLog(@"%@", params);
        //保存
        if ([params[@"name"] length]) {
            params[@"shopInternalCategoryId"] = self.categoryID;
            CLSHEditCategoryKeepModel * editCategoryKeepModel = [[CLSHEditCategoryKeepModel alloc] init];
            [editCategoryKeepModel fetchEditCategoryKeepData:params callBack:^(BOOL isSuccess, id result) {
               
                if (isSuccess) {
                    [MBProgressHUD showSuccess:@"保存成功!"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)1*(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    
                    [MBProgressHUD showError:result];
                }
            }];
        }else{
        
            [MBProgressHUD showError:@"请输入分类名称"];
        }
        
    };
}

//获得优先级
- (void)getPriority:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    params[@"priority"] = dic[@"priority"];
    
}

//获得分类名
- (void)getCategoryName:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    params[@"name"] = dic[@"categoryName"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHInputCategoryCell *inputCategoryCell = [tableView dequeueReusableCellWithIdentifier:inputID];
    CLSHSelectPriorityCell *selectPriorityCell = [tableView dequeueReusableCellWithIdentifier:selectID];
    if (!inputCategoryCell) {
        inputCategoryCell = [[CLSHInputCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inputID];
    }
    if (!selectPriorityCell) {
        selectPriorityCell = [[CLSHSelectPriorityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectID];
    }
    inputCategoryCell.name = self.name;
    inputCategoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
    selectPriorityCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        return inputCategoryCell;
    }else
    {
        return selectPriorityCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*AppScale;
    }
    return 35*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor = backGroundColor;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*AppScale, 15*AppScale, SCREENWIDTH-20*AppScale, 15*AppScale)];
        label.text = @"选择类别优先级";
        label.font = [UIFont systemFontOfSize:12*AppScale];
        label.textColor = RGBColor(158, 158, 158);
        [view addSubview:label];
        return view;
    }
    return nil;
}

//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"删除" selectTitle:@"删除" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(deleteCategory) size:CGSizeMake(40, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}

//删除
- (void)deleteCategory
{
    __block CLSHDeleteCategoryView *deleteCategoryView = [[[NSBundle mainBundle] loadNibNamed:@"CLSHDeleteCategoryView" owner:self options:nil] lastObject];
    deleteCategoryView.frame = CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT+64);
    deleteCategoryView.center = self.view.center;
    WS(weakSelf);
    deleteCategoryView.deleteCategoryBlock = ^(){
        DLog(@"删除");
        CLSHEditCategoryDeleteModel * editCategoryDeleteModel = [[CLSHEditCategoryDeleteModel alloc] init];
        NSMutableDictionary * needParams = [NSMutableDictionary dictionary];
        needParams[@"shopInternalCategoryId"] = weakSelf.categoryID;
        [editCategoryDeleteModel fetchEditCategoryDeleteData:needParams callBack:^(BOOL isSuccess, id result) {
           
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
            
                [MBProgressHUD showError:result];
            }
        }];
        
    };
    __weak __typeof(&*deleteCategoryView)weakDeleteView = deleteCategoryView;
    deleteCategoryView.noDeleteCategoryBlock = ^(){
        DLog(@"不删除");
        [weakDeleteView removeFromSuperview];
    };
    [[[UIApplication sharedApplication]keyWindow]addSubview:deleteCategoryView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
