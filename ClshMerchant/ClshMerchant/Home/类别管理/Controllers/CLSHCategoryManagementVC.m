//
//  CLSHCategoryManagementVC.m
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


#import "CLSHCategoryManagementVC.h"
#import "CLSHNullCategoryView.h"
#import "CLSHAddCategoryVC.h"
#import "CLSHCategoryManagementCell.h"
#import "CLSHCategoryFooterView.h"
#import "CLSHEditCategoryManagementVC.h"
#import "CLSHCategoryManagementEditCell.h"
#import "CLSHManagerGoodsVC.h"
#import "CLSHCategoryManageModel.h"

@interface CLSHCategoryManagementVC ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL isAddCategory; ///<判断是否添加了类别
    BOOL isEdit;    ///<判断是否是编辑
    CLSHCategoryManageModel * categoryManageModel;
    
    MBProgressHUD *hud;
}

@property (nonatomic, strong)CLSHNullCategoryView *nullCategoryView;
@property (nonatomic, strong)CLSHCategoryFooterView *footerView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;       ///<数据源数组

@end

static NSString *const ID = @"CLSHCategoryManagementCell";
static NSString *const editID = @"CLSHCategoryManagementEditCell";
@implementation CLSHCategoryManagementVC

#pragma mark - lazyLoad
-(CLSHNullCategoryView *)nullCategoryView
{
    if (!_nullCategoryView) {
        _nullCategoryView = [[CLSHNullCategoryView alloc] initWithFrame:self.view.bounds];
    }
    return _nullCategoryView;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

-(CLSHCategoryFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[CLSHCategoryFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*AppScale)];
    }
    return _footerView;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self loadData];
    self.editing = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"类别管理"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //注册cell
    [self.tableView registerClass:[CLSHCategoryManagementCell class] forCellReuseIdentifier:ID];
    [self.tableView registerClass:[CLSHCategoryManagementEditCell class] forCellReuseIdentifier:editID];
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
    hud.activityIndicatorColor=systemColor;
}

- (void)loadFooter
{
    WS(weakSelf);
    if (isAddCategory) {
        [self.nullCategoryView removeFromSuperview];
        [self.view addSubview:self.tableView];
        self.navigationItem.rightBarButtonItem = [self EditBarButton];
        self.tableView.tableFooterView = self.footerView;
        self.footerView.addCategoryBlock = ^(){
            CLSHAddCategoryVC *addCategoryVC = [[CLSHAddCategoryVC alloc] init];
            [weakSelf.navigationController pushViewController:addCategoryVC animated:YES];
        };
    }else
    {
        [self.tableView removeFromSuperview];
        [self.view addSubview:self.nullCategoryView];
        self.nullCategoryView.addCategoryBlock = ^(){
            CLSHAddCategoryVC *addCategoryVC = [[CLSHAddCategoryVC alloc] init];
            [weakSelf.navigationController pushViewController:addCategoryVC animated:YES];
        };
    }
}



-(void)dealloc{
    [hud hide:YES];
}
#pragma mark -- 加载数据
- (void)loadData{

    categoryManageModel =[[CLSHCategoryManageModel alloc] init];
    [categoryManageModel fetchCategoryManageData:nil callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            [hud hide:YES];
            [self.dataArray removeAllObjects];
            categoryManageModel = result;
            if (categoryManageModel.classification.count) {
                isAddCategory = YES;
            }else
            {
                isAddCategory = NO;
            }
            [self loadFooter];
            self.dataArray = [NSMutableArray arrayWithArray:categoryManageModel.classification];
            [self.tableView reloadData];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHCategoryManagementCell *categoryManagementCell = [tableView dequeueReusableCellWithIdentifier:ID];
    CLSHCategoryManagementEditCell *categoryManagementEditCell = [tableView dequeueReusableCellWithIdentifier:editID];
    if (!categoryManagementCell) {
        categoryManagementCell = [[CLSHCategoryManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (!categoryManagementEditCell) {
        categoryManagementEditCell = [[CLSHCategoryManagementEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:editID];
    }
    categoryManagementCell.selectionStyle = UITableViewCellSelectionStyleNone;
    categoryManagementCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    categoryManagementEditCell.selectionStyle = UITableViewCellSelectionStyleNone;
    categoryManagementEditCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    CLSHCategoryListModel * categoryListModel = [[CLSHCategoryListModel alloc] init];
    categoryListModel = [_dataArray objectAtIndexCheck:indexPath.row];
    categoryManagementCell.model = categoryListModel;
    categoryManagementEditCell.model = categoryListModel;
    WS(weakSelf);
    if (self.editing) {
        categoryManagementEditCell.editCategoryBlock = ^(){
            CLSHEditCategoryManagementVC *editCategoryManagementVC = [[CLSHEditCategoryManagementVC alloc] init];
            editCategoryManagementVC.categoryID = [NSString stringWithFormat:@"%zi", categoryListModel.categoryID];
            editCategoryManagementVC.name = categoryListModel.name;
            [weakSelf.navigationController pushViewController:editCategoryManagementVC animated:YES];
            
        };
        return categoryManagementEditCell;
    }else
    {
        return categoryManagementCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        CLSHCategoryManagementEditCell *cell = (CLSHCategoryManagementEditCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selected = YES;
    }else
    {
        CLSHCategoryListModel * categoryListModel = [[CLSHCategoryListModel alloc] init];
        categoryListModel = [_dataArray objectAtIndexCheck:indexPath.row];
        CLSHManagerGoodsVC *managerGoodsVC = [[CLSHManagerGoodsVC alloc] init];
        managerGoodsVC.categoryId = [NSString stringWithFormat:@"%ld",categoryListModel.categoryID];
        [self.navigationController pushViewController:managerGoodsVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing) {
        CLSHCategoryManagementEditCell *cell = (CLSHCategoryManagementEditCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
    }
}

//完成状态
-(UIBarButtonItem*)EditBarButton{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40*AppScale, 20);
    
    [backBtn addTarget:self action:@selector(editButton) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

-(UIBarButtonItem*)EditBarButtonFlish{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40*AppScale, 20);
    
    [backBtn addTarget:self action:@selector(editButton) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"完成" forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor whiteColor]];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

//编辑
- (void)editButton
{
    self.editing = !self.editing;
    if (self.editing) {
        self.navigationItem.rightBarButtonItem = [self EditBarButtonFlish];
        self.tableView.tableFooterView = [[UIView alloc] init];
    }else
    {
        self.navigationItem.rightBarButtonItem = [self EditBarButton];
        self.tableView.tableFooterView = self.footerView;
    }
    [self.tableView reloadData];
}

@end
