//
//  CLSHDataStatisticVC.m
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


#import "CLSHDataStatisticVC.h"
#import "CLSHDataStatisticCell.h"
#import "CLSHDataStatisticVisitorVC.h"
#import "CLSHDataStatisticIncomeVC.h"
#import "CLSHDataStaticModel.h"

@interface CLSHDataStatisticVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CLSHDataStaticModel *staticModel;   ///<统计首页数据模型
    MBProgressHUD *hud;
}
@property (nonatomic, strong)NSArray *iconArray;
@property (nonatomic, strong)NSArray *nameArray;
@property (nonatomic, strong)NSArray *totalArray;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CLSHDataStatisticVC
static NSString *const dataID = @"CLSHDataStatisticCell";

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSArray *)iconArray
{
    if (!_iconArray) {
        _iconArray = [NSArray arrayWithObjects:@"DataVisitorIcon", @"DataIncomeIcon", @"DataSaleIcon", @"DataWalletIcon", @"DataCouponIcon", nil];
    }
    return _iconArray;
}

-(NSArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = [NSArray arrayWithObjects:@"访客", @"收入", @"销量", @"红包", @"优惠券", nil];
    }
    return _nameArray;
}

-(NSArray *)totalArray
{
    if (!_totalArray) {
        _totalArray = [NSArray arrayWithObjects:@"累计访客", @"累计交易额", @"累计交易完成", @"累计发放", @"累计发出", nil];
    }
    return _totalArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"数据统计"];
    staticModel = [[CLSHDataStaticModel alloc] init];
    
    //注册cell
    [self.tableView registerClass:[CLSHDataStatisticCell class] forCellReuseIdentifier:dataID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color=[UIColor clearColor];
    hud.backgroundColor=backGroundColor;
    hud.activityIndicatorColor=systemColor;
    
    [self loadData];
}

#pragma mark - loadData
- (void)loadData
{
    [staticModel fetchDataStaticData:nil callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            staticModel = result;
            [hud hide:YES];
            [self.tableView reloadData];
            
        }else{
        
            [MBProgressHUD showError:result];
        }
        
    }];
}



-(void)dealloc{
    [hud hide:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHDataStatisticCell *dataCell = [tableView dequeueReusableCellWithIdentifier:dataID];
    if (!dataCell) {
        dataCell = [[CLSHDataStatisticCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dataID];
    }
    dataCell.selectionStyle = UITableViewCellSelectionStyleNone;
    dataCell.icon.image = nil;
    dataCell.name.text = nil;
    dataCell.total.text = nil;
//    dataCell.count.text = nil;
    dataCell.icon.image = [UIImage imageNamed:self.iconArray[indexPath.section]];
    dataCell.name.text = self.nameArray[indexPath.section];
    dataCell.total.text = self.totalArray[indexPath.section];
    switch (indexPath.section) {
        case 0:
            dataCell.count.text = [NSString stringWithFormat:@"%ld人",staticModel.visitorCount];
            break;
        case 1:
            dataCell.count.text = [NSString stringWithFormat:@"%.2f元",staticModel.income];
            break;
        case 2:
            dataCell.count.text = [NSString stringWithFormat:@"%ld单",staticModel.sales];
            break;
        case 3:
            dataCell.count.text = [NSString stringWithFormat:@"%ld个",staticModel.luckyDraw];
            break;
        case 4:
            dataCell.count.text = [NSString stringWithFormat:@"%ld张",staticModel.coupon];
        default:
            break;
    }
    [NSString labelString:dataCell.count font:[UIFont systemFontOfSize:20*AppScale] range:NSMakeRange(0, dataCell.count.text.length - 1) color:[UIColor redColor]];
    return dataCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*AppScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CLSHDataStatisticVisitorVC *dataStatisticVisitorVC = [[CLSHDataStatisticVisitorVC alloc] init];
        [self.navigationController pushViewController:dataStatisticVisitorVC animated:YES];
    }else if (indexPath.section == 1)
    {
        CLSHDataStatisticIncomeVC *dataStatisticIncomeVC = [[CLSHDataStatisticIncomeVC alloc] init];
        dataStatisticIncomeVC.name = @"收入统计";
        [self.navigationController pushViewController:dataStatisticIncomeVC animated:YES];
    }else if (indexPath.section == 2)
    {
        CLSHDataStatisticIncomeVC *dataStatisticIncomeVC = [[CLSHDataStatisticIncomeVC alloc] init];
        dataStatisticIncomeVC.name = @"销量统计";
        [self.navigationController pushViewController:dataStatisticIncomeVC animated:YES];
    }else if (indexPath.section == 3)
    {
        CLSHDataStatisticIncomeVC *dataStatisticIncomeVC = [[CLSHDataStatisticIncomeVC alloc] init];
        dataStatisticIncomeVC.name = @"红包统计";
        [self.navigationController pushViewController:dataStatisticIncomeVC animated:YES];
    }else if (indexPath.section == 4)
    {
        CLSHDataStatisticIncomeVC *dataStatisticIncomeVC = [[CLSHDataStatisticIncomeVC alloc] init];
        dataStatisticIncomeVC.name = @"优惠券统计";
        [self.navigationController pushViewController:dataStatisticIncomeVC animated:YES];
    }
}

@end
