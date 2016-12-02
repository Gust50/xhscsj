//
//  CLSHWithdrawalsRecordVC.m
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


#import "CLSHWithdrawalsRecordVC.h"
#import "CLSHWithdrawalsRecordCell.h"
#import "CLSHWithdrawalsRecordDetailVC.h"
#import "CLSHWithdrawalsRecordModel.h"

@interface CLSHWithdrawalsRecordVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CLSHWithdrawalsRecordModel *recordModel;    ///<提现记录数据模型
    NSMutableDictionary *params;    ///<参数
    NSInteger pageNum;  ///<当前页码
}

@property(nonatomic,strong)NSMutableArray *dataSource;      ///<数据源
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CLSHWithdrawalsRecordVC

static NSString *const ID = @"CLSHWithdrawalsRecordCell";

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

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"提现记录"];
    recordModel = [[CLSHWithdrawalsRecordModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    //注册cell
    [self.tableView registerClass:[CLSHWithdrawalsRecordCell class] forCellReuseIdentifier:ID];
    
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    pageNum = 1;
}

- (void)loadNewData
{
    params[@"pageSize"] = @(10);
    params[@"pageNumber"] =@(pageNum);
    
    [recordModel fetchWithdrawalsRecordData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            recordModel = result;
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:recordModel.withdrawLogs];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (recordModel.withdrawLogs.count<10)
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
    if (recordModel.totalPages > pageNum) {
        pageNum++;
        params[@"pageNumber"]=@(pageNum);
        [recordModel fetchWithdrawalsRecordData:params callBack:^(BOOL isSuccess, id result) {
        
            if (isSuccess)
            {
                [self.dataSource addObjectsFromArray:((CLSHWithdrawalsRecordModel *)result).withdrawLogs];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
                
                if ((((CLSHWithdrawalsRecordModel *)result).withdrawLogs.count)<10)
                {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.tableView.mj_footer endRefreshing];
                }
            }
        }];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHWithdrawalsRecordCell *withdrawalsRecordCell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!withdrawalsRecordCell) {
        withdrawalsRecordCell = [[CLSHWithdrawalsRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    withdrawalsRecordCell.listModel = [_dataSource objectAtIndexCheck:indexPath.row];
    withdrawalsRecordCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return withdrawalsRecordCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*AppScale;
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
    CLSHWithdrawalsRecordDetailVC *recordDetailVC = [[CLSHWithdrawalsRecordDetailVC alloc] init];
    CLSHWithdrawalsRecordListModel *listModel = [_dataSource objectAtIndexCheck:indexPath.row];
    recordDetailVC.withDrawLogId = listModel.itemID;
    [self.navigationController pushViewController:recordDetailVC animated:YES];
}

@end
