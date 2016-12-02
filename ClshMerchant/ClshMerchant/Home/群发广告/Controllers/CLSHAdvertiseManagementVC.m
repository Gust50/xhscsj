//
//  CLSHAdvertiseManagementVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHAdvertiseManagementVC.h"
#import "CLSHAdvertiseManagementCell.h"
#import "CLSHAdvertisingDetailVC.h"
#import "CLSHAdvertisePreviewVC.h"
#import "CLSHAddAdvertisementVC.h"
#import "CLSHAdManagerModel.h"

@interface CLSHAdvertiseManagementVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CLSHAdManagerModel * adManagerModel;
    NSMutableDictionary *params;    ///<参数
    NSInteger pageNum;  ///<当前页码
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * dataArray;
@end

@implementation CLSHAdvertiseManagementVC
static NSString *const ID = @"CLSHAdvertiseManagementCell";

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"广告管理"];
    params = [NSMutableDictionary dictionary];
    adManagerModel = [[CLSHAdManagerModel alloc] init];
    
    //注册cell
    [self.tableView registerClass:[CLSHAdvertiseManagementCell class] forCellReuseIdentifier:ID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    pageNum = 1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadNewData];
}

- (void)loadNewData
{
    params[@"pageSize"] = @(10);
    params[@"pageNumber"] =@(pageNum);
    
    [adManagerModel fetchAdManagerData:nil callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess)
        {
            adManagerModel = result;
            [_dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:adManagerModel.sliderAd];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (adManagerModel.sliderAd.count<10)
            {
                self.tableView.mj_footer.hidden=YES;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                self.tableView.mj_footer.hidden=NO;
                [self.tableView.mj_footer resetNoMoreData];
            }
            
        }else
        {
            
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

//加载更多数据
-(void)loadMoreData
{
    pageNum++;
    params[@"pageNumber"]=@(pageNum);
    [adManagerModel fetchAdManagerData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            [self.dataArray addObjectsFromArray:adManagerModel.sliderAd];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
            if ((adManagerModel.sliderAd.count)<10)
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHAdvertiseManagementCell *advertiseManagementCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!advertiseManagementCell) {
        advertiseManagementCell = [[CLSHAdvertiseManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    advertiseManagementCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLSHAdListModel * adListModel = [[CLSHAdListModel alloc] init];
    adListModel = [self.dataArray objectAtIndexCheck:indexPath.section];
    advertiseManagementCell.model = adListModel;
    WS(weakSelf);
    //查看广告详情
    advertiseManagementCell.lookAdvertiseDetailBlock = ^(){
        CLSHAdvertisingDetailVC *advDetailVC = [[CLSHAdvertisingDetailVC alloc] init];
        advDetailVC.adId = adListModel.adId;
        [weakSelf.navigationController pushViewController:advDetailVC animated:YES];
    };

    return advertiseManagementCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 166*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"添加广告" selectTitle:@"添加广告" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(addAdvertising) size:CGSizeMake(80, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}

//添加广告
- (void)addAdvertising
{
    CLSHAddAdvertisementVC *cLSHAddAdvertisementVC=[CLSHAddAdvertisementVC new];
    
    [self.navigationController pushViewController:cLSHAddAdvertisementVC animated:YES];
}

@end
