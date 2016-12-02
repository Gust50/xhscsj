//
//  CLGSBalanceIncomeVC.m
//  ClshMerchant
//
//  Created by kobe on 16/9/12.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLGSBalanceIncomeVC.h"
#import "CLGSBalanceSecondTableViewCell.h"
#import "CLSHAccountBalanceModel.h"

#import "CLSHSingleIncomeController.h"
@interface CLGSBalanceIncomeVC ()<UITableViewDataSource,UITableViewDelegate>
{
    CLSHIncomeModel * incomeModel;
    NSInteger pageNum;                                      ///<当前页码
    NSMutableDictionary *params;                            ///<分页加载参数
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end
//static NSString *const IncomeCellID  = @"IncomeCell";
static NSString *const secondCellID = @"secondCell";
@implementation CLGSBalanceIncomeVC


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH , SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.view.backgroundColor = backGroundColor;
    self.navigationItem.title = self.title;

    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSBalanceSecondTableViewCell" bundle:nil] forCellReuseIdentifier:secondCellID];
    self.tableView.mj_header = [KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.tableFooterView =[[UIView alloc] init];
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}


- (void)initUI{
    [self.view addSubview:self.tableView];
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    
    incomeModel = [[CLSHIncomeModel alloc] init];
    pageNum=1;
    params = [NSMutableDictionary dictionary];
    params[@"pageSize"] = @(10);
    params[@"pageNumber"] =@(pageNum);
    params[@"isTransferred"] = @"false";
    [incomeModel fetchIncomeData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            incomeModel = result;
            
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:incomeModel.items];
            
            NSLog(@"self.dataSource的数据。。。%@",self.dataSource);
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (self.dataSource.count<10)
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
    if ([incomeModel.totalPages integerValue] > pageNum) {
        pageNum++;
        params[@"pageNumber"]=@(pageNum);
        [incomeModel fetchIncomeData:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess)
                
            {
                incomeModel = result;
                [_dataSource addObjectsFromArray:incomeModel.items];

                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
                
                if (self.dataSource.count<10)
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return _dataSource.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLGSBalanceSecondTableViewCell *secondTableViewCell = [tableView dequeueReusableCellWithIdentifier:secondCellID];

        if (!secondTableViewCell) {
        secondTableViewCell = [[CLGSBalanceSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellID];

        }
        secondTableViewCell.incomeDetailModel = _dataSource[indexPath.row];
        return secondTableViewCell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*AppScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

//这块最后再处理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHSingleIncomeController *incomeVC = [[CLSHSingleIncomeController alloc] init];
    incomeVC.AccountincomeDetailModel = _dataSource[indexPath.row];
    [self.navigationController pushViewController:incomeVC animated:YES];
    

}

@end
