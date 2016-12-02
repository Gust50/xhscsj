//
//  CLSHSelectUserVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSelectUserVC.h"
#import "KBDropDownMenu.h"
#import "CLSHSelectUserView.h"
#import "CLSHSelectUserCell.h"
#import "CLSHSetupMassInformationVC.h"
#import "CLSHAdManagerModel.h"

@interface CLSHSelectUserVC ()<KBDropDownMenuDelegate,KBDropDownMenuDataSource, UITableViewDelegate, UITableViewDataSource>
{
    NSArray *consumptionAmount; ///<消费金额数组
    NSArray *consumptionCount;  ///<消费次数数组
    NSArray *distance;    ///<距离筛选数组
    KBDropDownMenu * dropMenu;
    CLSHAddAdSelectUsersModel *cLSHAddAdSelectUsersModel;   ///<选择用户数据模型
    NSMutableDictionary *needParam; ///<传入需要的参数
    NSInteger pageNum;                    ///<当前页码
    
}

@property (nonatomic, strong) NSMutableArray *dataSource;     ///<数据源
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *setupInfo;   ///<设置群发信息

@end

static NSString *const ID = @"CLSHSelectUserCell";
static NSString *const infoCellID = @"Cell";
@implementation CLSHSelectUserVC
#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40*AppScale, SCREENWIDTH, SCREENHEIGHT-40*AppScale-40*AppScale) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = backGroundColor;
    }
    return _tableView;
}

- (UIButton *)setupInfo
{
    if (!_setupInfo) {
        _setupInfo = [[UIButton alloc] init];
        _setupInfo.frame = CGRectMake(0, SCREENHEIGHT-40*AppScale, SCREENWIDTH, 40*AppScale);
        _setupInfo.backgroundColor = systemColor;
        _setupInfo.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_setupInfo setTitle:@"设置群发信息" forState:UIControlStateNormal];
        [_setupInfo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _setupInfo;
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
    [self.view addSubview:self.setupInfo];
    needParam=[NSMutableDictionary dictionary];
    cLSHAddAdSelectUsersModel=[CLSHAddAdSelectUsersModel new];
    [self.setupInfo addTarget:self action:@selector(massInformation) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"选择用户"];
    [self setDropMenu];
    
    //注册cell
    [self.tableView registerClass:[CLSHSelectUserCell class] forCellReuseIdentifier:ID];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    pageNum = 1;
    needParam[@"type"] = @"";
    needParam[@"value"] = @"";
    needParam[@"distance"] = @(1000);
}


-(void)loadNewData{
    
    needParam[@"pageSize"] = @(10);
    needParam[@"pageNumber"] =@(pageNum);
    [cLSHAddAdSelectUsersModel fetchSelectUsersData:needParam callBack:^(BOOL isSuccess, id result) {
        if (isSuccess)
        {
            cLSHAddAdSelectUsersModel = result;
            [_dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:cLSHAddAdSelectUsersModel.items];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (cLSHAddAdSelectUsersModel.items.count<10)
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
        if (isSuccess) {
            cLSHAddAdSelectUsersModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//加载更多数据
-(void)loadMoreData
{
    
    pageNum++;
    needParam[@"pageNumber"]=@(pageNum);
    [cLSHAddAdSelectUsersModel fetchSelectUsersData:needParam callBack:^(BOOL isSuccess, id result){
        
        if (isSuccess)
        {
            [self.dataSource addObjectsFromArray:cLSHAddAdSelectUsersModel.items];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
            if ((cLSHAddAdSelectUsersModel.items.count)<10)
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }];
}

#pragma mark 设置下拉菜单
- (void)setDropMenu{
    
    consumptionAmount = @[@"消费金额",@"消费金额升序",@"消费金额降序"];
    consumptionCount = @[@"消费次数",@"消费次数升序",@"消费次数降序"];
    distance = @[@"距离1km以内",@"距离3km以内",@"距离5km以内"];
    
    dropMenu = [[KBDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) height:40*AppScale];
    dropMenu.delegate = self;
    dropMenu.dataSource = self;
    
    [self.view addSubview:dropMenu];
}

#pragma mark KBDropMenu delegate datasource
- (NSString *)menu:(KBDropDownMenu *)menu titleForRowAtIndexPath:(KBIndexPath *)indexPath{
    
    switch (indexPath.column) {
        case 0:
            return consumptionAmount[indexPath.row];
            break;
        case 1:
            return consumptionCount[indexPath.row];
            break;
        case 2:
            return distance[indexPath.row];
            break;
        default:
            return nil;
            break;
    }
}

- (NSInteger)numberOfColumnsInMenu:(KBDropDownMenu *)menu{
    
    return 3;
}

- (NSInteger)menu:(KBDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    
    return 3;
}

-(void)menu:(KBDropDownMenu *)menu didSelectRowAtIndexPath:(KBIndexPath *)indexPath{
    if (indexPath.column == 0) {
        switch (indexPath.row) {
            case 0:
                needParam[@"type"] = @"amount";
                needParam[@"value"] = @"";
                [self.tableView.mj_header beginRefreshing];
                break;
            case 1:
                needParam[@"type"] = @"amount";
                needParam[@"value"] = @"asc";
                [self.tableView.mj_header beginRefreshing];
                break;
            case 2:
                needParam[@"type"] = @"amount";
                needParam[@"value"] = @"desc";
                [self.tableView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }else if (indexPath.column == 1){
        
        switch (indexPath.row) {
            case 0:
                needParam[@"type"] = @"others";
                needParam[@"value"] = @"";
                [self.tableView.mj_header beginRefreshing];
                break;
            case 1:
               
                needParam[@"type"] = @"others";
                needParam[@"value"] = @"asc";
                [self.tableView.mj_header beginRefreshing];
                break;
            case 2:
                needParam[@"type"] = @"others";
                needParam[@"value"] = @"desc";
                [self.tableView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }else if (indexPath.column == 2){
        
        switch (indexPath.row) {
            case 0:
                needParam[@"distance"] = @(1000);
                [self.tableView.mj_header beginRefreshing];
                break;
            case 1:
                needParam[@"distance"] = @(3000);
                [self.tableView.mj_header beginRefreshing];
                break;
            case 2:
                needParam[@"distance"] = @(5000);
                [self.tableView.mj_header beginRefreshing];
                break;
            default:
                break;
        }
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHSelectUserCell *selectUserCell = [tableView dequeueReusableCellWithIdentifier:ID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!selectUserCell) {
        selectUserCell = [[CLSHSelectUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    selectUserCell.userListModel = [_dataSource objectAtIndexCheck:indexPath.row];
    selectUserCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        CLSHSelectUserView *selectUserView = [[CLSHSelectUserView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 140*AppScale)];
        selectUserView.selectUsersModel = cLSHAddAdSelectUsersModel;
        [cell addSubview:selectUserView];
        return cell;
    }else
    {
        return selectUserCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140*AppScale;
    }
    return 100*AppScale;
}

//设置群发信息
- (void)massInformation
{
    if (cLSHAddAdSelectUsersModel.totalCount == 0) {
        [MBProgressHUD showError:@"当前无用户！"];
    }else
    {
        CLSHSetupMassInformationVC *setupMassInformationVC = [[CLSHSetupMassInformationVC alloc] init];
        setupMassInformationVC.needParams = self.needParams;
        setupMassInformationVC.selectUsersModel = cLSHAddAdSelectUsersModel;
        setupMassInformationVC.userParams = needParam;
        [self.navigationController pushViewController:setupMassInformationVC animated:YES];
    }
}

#pragma mark <getter setter>

-(void)setNeedParams:(NSDictionary *)needParams{
    _needParams=needParams;
}
@end
