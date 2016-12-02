//
//  CLSHSelectIndustryVC.m
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


#import "CLSHSelectIndustryVC.h"
#import "CLSHSelectIndustryCell.h"
#import "CLSHMerchantJoinModel.h"

@interface CLSHSelectIndustryVC ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    int selectRow;//选中tableView行
    int selectItem;    ///<选中collectionView行
    
    BOOL isSelect;  ///<判断右边collectionView是否被选中
    
    CLSHMerchantJoinModel *merchantJoinModel;   ///<行业列表数据模型
    CLSHMerchantJoinListModel *merchantJoinListModel;   ///<一级菜单列表
    
    NSString *selectName;   ///<选中的行业
    NSInteger selectId;     ///<选择行业ID
    
    MBProgressHUD *hud;
}

@property (nonatomic, strong) UITableView *leftTableView;   ///<左边tableView
@property (nonatomic, strong)UICollectionView *rightCollectionView; ///<右边collectionView
@property (nonatomic, strong)UIButton *footerView;  ///<尾部视图

@end

@implementation CLSHSelectIndustryVC
static NSString *const ID = @"Cell";
static NSString *const selectIndustryID = @"CLSHSelectIndustryCell";

#pragma mark - lazyLoad
-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/4+10*AppScale, SCREENHEIGHT-100*AppScale) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = backGroundColor;
        _leftTableView.showsVerticalScrollIndicator=NO;
        _leftTableView.tableFooterView = [[UIView alloc] init];
    
    }
    return _leftTableView;
}

-(UICollectionView *)rightCollectionView
{
    if (!_rightCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREENWIDTH/4, 64, SCREENWIDTH*3/4, SCREENHEIGHT-100*AppScale-64) collectionViewLayout:layout];
        _rightCollectionView.delegate = self;
        _rightCollectionView.dataSource = self;
        _rightCollectionView.backgroundColor = [UIColor whiteColor];
        _rightCollectionView.showsVerticalScrollIndicator = NO;
    }
    return _rightCollectionView;
}

-(UIButton *)footerView
{
    if (!_footerView) {
        _footerView = [[UIButton alloc] initWithFrame:CGRectMake(10*AppScale, SCREENHEIGHT-50*AppScale, SCREENWIDTH-20*AppScale, 40*AppScale)];
        _footerView.layer.cornerRadius = 5*AppScale;
        _footerView.layer.masksToBounds = YES;
        _footerView.backgroundColor = systemColor;
        [_footerView setTitle:@"确定" forState:UIControlStateNormal];
        [_footerView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _footerView.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_footerView addTarget:self action:@selector(selectIndustry) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightCollectionView];
    [self.view addSubview:self.footerView];
    self.leftTableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"选择您的行业"];
    merchantJoinModel = [[CLSHMerchantJoinModel alloc] init];
    merchantJoinListModel = [[CLSHMerchantJoinListModel alloc] init];
    //注册cell
    [self.rightCollectionView registerClass:[CLSHSelectIndustryCell class] forCellWithReuseIdentifier:selectIndustryID];
    //左侧默认选中第一行
    selectRow = 0;
   
    //右侧默认选中第一个
    selectItem = 0;
    NSIndexPath *selectedCollectionIndexPath = [NSIndexPath indexPathForRow:selectItem inSection:0];
    [_rightCollectionView selectItemAtIndexPath:selectedCollectionIndexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    isSelect = YES;
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color=[UIColor clearColor];
    hud.backgroundColor=backGroundColor;
    hud.activityIndicatorColor=systemColor;
    [self loadData];
}

- (void)loadData
{
    [merchantJoinModel fetchMerchantJoinData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            merchantJoinModel = result;
            
            [hud hide:YES];
            [self.leftTableView reloadData];
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectRow inSection:0];
            [_leftTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            
            //右边菜单的分类数组
            merchantJoinListModel = merchantJoinModel.industry[selectRow];
            CLSHMerchantJoinListListModel *model = merchantJoinListModel.childen[0];
            selectName = model.name;
            selectId = model.industryListID;
            [self.rightCollectionView reloadData];
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}



-(void)dealloc{
    
    [hud hide:YES];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return merchantJoinModel.industry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = nil;
    cell.backgroundColor = backGroundColor;
    cell.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:13*AppScale];
    merchantJoinListModel = merchantJoinModel.industry[indexPath.row];
    cell.textLabel.text = merchantJoinListModel.name;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*AppScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (selectRow == indexPath.row) {
//        return;
//    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    selectRow = (int)indexPath.row;
    merchantJoinListModel = merchantJoinModel.industry[selectRow];
    [self.rightCollectionView reloadData];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView.backgroundColor = backGroundColor;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return merchantJoinListModel.childen.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHSelectIndustryCell *selectIndustryCell = [collectionView dequeueReusableCellWithReuseIdentifier:selectIndustryID forIndexPath:indexPath];
    selectIndustryCell.merchantJoinListListModel = merchantJoinListModel.childen[indexPath.item];
    return selectIndustryCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (selectItem == indexPath.item) {
//        return;
//    }
     CLSHSelectIndustryCell *selectIndustryCell = (CLSHSelectIndustryCell *)[collectionView cellForItemAtIndexPath:indexPath];

    selectItem = (int)indexPath.item;
    selectIndustryCell.selected = isSelect;
    CLSHMerchantJoinListListModel *model = merchantJoinListModel.childen[indexPath.item];
    selectName = model.name;
    selectId = [model.industryListID integerValue];
    isSelect = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHSelectIndustryCell *selectIndustryCell = (CLSHSelectIndustryCell *)[collectionView cellForItemAtIndexPath:indexPath];
    selectIndustryCell.selected = isSelect;
    isSelect = YES;
    selectIndustryCell.industryName.layer.borderWidth = 0;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREENWIDTH*3/4-20*AppScale)/3, 30*AppScale);
}

//确定
- (void)selectIndustry
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"industryName"] = selectName;
    params[@"industryId"] = @(selectId);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectIndustryName" object:nil userInfo:params];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
