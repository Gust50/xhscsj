//
//  CLSHManagerModifyClassfyVC.m
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


#import "CLSHManagerModifyClassfyVC.h"
#import "CLSHModifyClassifyCell.h"
#import "CLSHCategoryManageModel.h"
#import "CLSHHomeShopListModel.h"

@interface CLSHManagerModifyClassfyVC (){

    NSInteger index;
}


@property (nonatomic,strong) NSMutableArray * dataArray;
@end

static NSString *const ID = @"CLSHModifyClassifyCell";
@implementation CLSHManagerModifyClassfyVC

#pragma mark -- 懒加载
- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"修改类别"];
    [self setNavigationBar];
    
    [self loadData];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHModifyClassifyCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)loadData{

    __block CLSHCategoryManageModel * categoryManagerModel = [[CLSHCategoryManageModel alloc] init];
    
    [categoryManagerModel fetchCategoryManageData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            
            categoryManagerModel = result;
            self.dataArray = [NSMutableArray arrayWithArray:categoryManagerModel.classification];
            [self.tableView reloadData];
        }else{
        
            [MBProgressHUD showError:result];
            
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHModifyClassifyCell *classifyCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!classifyCell) {
        classifyCell = [[CLSHModifyClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    CLSHCategoryListModel * categoryListModel = [[CLSHCategoryListModel alloc] init];
    categoryListModel = [_dataArray objectAtIndexCheck:indexPath.row];
    classifyCell.model = categoryListModel;
    classifyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    classifyCell.selected = YES;
    
    return classifyCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35*AppScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHModifyClassifyCell *cell = (CLSHModifyClassifyCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    index = indexPath.row;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHModifyClassifyCell *cell = (CLSHModifyClassifyCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 35*AppScale)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *describe = [[UILabel alloc] initWithFrame:CGRectMake(26*AppScale, 10*AppScale, SCREENWIDTH-26*AppScale, 15*AppScale)];
    describe.font = [UIFont systemFontOfSize:11*AppScale];
    describe.text = @"选择类别";
    describe.textColor = RGBColor(140, 140, 140);
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(26*AppScale, 34*AppScale, SCREENWIDTH-26*AppScale, 1)];
    line.backgroundColor = RGBColor(226, 226, 226);
    [view addSubview:line];
    [view addSubview:describe];
    return view;
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"确认" selectTitle:@"确认" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(confirm) size:CGSizeMake(60, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}

- (void)confirm
{
    CLSHHomeMotifyClassifyModel * motifyClassifyModel = [[CLSHHomeMotifyClassifyModel alloc] init];
    CLSHCategoryListModel * categoryListModel = [_dataArray objectAtIndexCheck:index];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"goodsId"] = _goodsId;
    params[@"categoryId"] = @(categoryListModel.categoryID);
    
    [motifyClassifyModel fetchMotifyClassifyData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"商品类别信息更新成功！"];
             [self.navigationController popViewControllerAnimated:YES];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}
#pragma mark - setter getter
-(void)setGoodsId:(NSString *)goodsId
{
    _goodsId = goodsId;
    
}

@end
