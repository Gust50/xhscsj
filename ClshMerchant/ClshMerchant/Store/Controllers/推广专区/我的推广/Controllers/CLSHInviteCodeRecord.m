//
//  CLSHInviteCodeRecord.m
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHInviteCodeRecord.h"
#import "CLSHInviteCodeRecordHeader.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHInviteRecordModel.h"
#import "CLSHNonInvitateRecordView.h"
#import "CLSHInviteRecordCell.h"
//#import "CLSHNeighbourhoodMerchantVC.h"

//@2商家店铺
//#import "CLSHNeighbourhoodMerchantVC.h"

@interface CLSHInviteCodeRecord ()<UITableViewDataSource, UITableViewDelegate>
{
    CLSHInviteRecordModel *inviteRecordModel;   ///<邀请记录数据模型
    NSMutableDictionary *params;          ///<分页加载参数
    NSInteger pageNum;                    ///<当前页码
    
}

/** 设置tag值 */
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;     ///<数据源
@end

@implementation CLSHInviteCodeRecord

static NSString *const ID = @"CLSHInviteRecordCell";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 105*AppScale, SCREENWIDTH, SCREENHEIGHT-105*AppScale)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = backGroundColor;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc]init];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"邀请记录"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    
    //设置segment
    CLSHInviteCodeRecordHeader *header=[[CLSHInviteCodeRecordHeader alloc]initWithFrame:CGRectMake(0, 65, SCREENWIDTH, 50*AppScale)];
    WS(weakSelf);
    header.userOrMerchantBlock = ^(NSInteger tag)
    {
        weakSelf.tag = tag;
        [self loadNewData];
    };
    [self.view addSubview:header];
    [self.view addSubview:self.tableView];
    
    //注册cell
    [self.tableView registerClass:[CLSHInviteRecordCell class] forCellReuseIdentifier:ID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadNewData];
}

#pragma mark <loadFooter>
-(void)loadFooter
{
    //判断邀请记录是否为空
    if (inviteRecordModel.items.count != 0)
    {
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.scrollEnabled = YES;
        self.tableView.mj_header.hidden = NO;
    }else
    {
        CLSHNonInvitateRecordView *invitateRecordView = [[CLSHNonInvitateRecordView alloc] initWithFrame:CGRectMake(0, 114, SCREENWIDTH, SCREENHEIGHT-114)];
        self.tableView.scrollEnabled = NO;
        self.tableView.mj_header.hidden = YES;
        self.tableView.tableFooterView = invitateRecordView;
    }
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    
    inviteRecordModel = [[CLSHInviteRecordModel alloc] init];
    params = [NSMutableDictionary dictionary];
    pageNum = 1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    if (self.tag == 0) {
        params[@"type"] = @"c";
    }else
    {
        params[@"type"] = @"b";
    }
    
    [inviteRecordModel fetchAccountInviteRecordModel:params callBack:^(BOOL isSuccess, id result) {
        NSLog(@"=====这个model的数据======%@",inviteRecordModel);
        NSLog(@"=====这个result的数据======%@",result);

        if (isSuccess) {
            inviteRecordModel = result;
            
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:inviteRecordModel.items];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self loadFooter];
            
            if (inviteRecordModel.items.count<10)
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
            [MBProgressHUD showError:result];
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
}

//加载更多数据
-(void)loadMoreData
{
    if (inviteRecordModel.totalPages > pageNum) {
        pageNum++;
        params[@"pageNumber"]=@(pageNum);
        [inviteRecordModel fetchAccountInviteRecordModel:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [self.dataSource addObjectsFromArray:((CLSHInviteRecordModel *)result).items];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
                
                if ((((CLSHInviteRecordModel *)result).items.count)<10)
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

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"model的数量%lu",(unsigned long)inviteRecordModel.items.count);
    CLSHInviteRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[CLSHInviteRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.listModel = _dataSource[indexPath.row];
    return cell;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80*AppScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.tag ==1) {
        
        //@2222222
        
//        CLSHNeighbourhoodMerchantVC * bussiessShopVC = [CLSHNeighbourhoodMerchantVC new];
//        CLSHInviteRecordListModel * listModel = [[CLSHInviteRecordListModel alloc] init];
//        listModel = _dataSource[indexPath.row];
//        bussiessShopVC.shopID = listModel.shopId;
//        bussiessShopVC.latitude = [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude;
//        bussiessShopVC.longitude = [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude;
//        [self.navigationController pushViewController:bussiessShopVC animated:YES];
    }
}

@end
