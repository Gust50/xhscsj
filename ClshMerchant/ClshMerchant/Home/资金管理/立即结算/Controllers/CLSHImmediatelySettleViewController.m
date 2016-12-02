//
//  CLSHImmediatelySettleViewController.m
//  ClshMerchant
//
//  Created by arom on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHImmediatelySettleViewController.h"
#import "CLSHImmediatelySettleHeadView.h"
#import "CLSHImmedieatelySettleTableViewCell.h"
#import "CLSHBottomView.h"
#import "CLSHMoneyManagerModel.h"

@interface CLSHImmediatelySettleViewController ()<UITableViewDelegate,UITableViewDataSource>{

    BOOL isSelected;
    CLSHSettleImmediatelyModel * settleMoneyModel;
    MBProgressHUD *hud;
    CGFloat sum;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)CLSHBottomView * bottomView;
@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation CLSHImmediatelySettleViewController

static NSString * const immediatelySettleHeadViewID = @"immediatelySettleID";
static NSString * const immediatelySettleCellID = @"immediatelySettleID";
#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10*AppScale, SCREENWIDTH, SCREENHEIGHT-64-50*AppScale) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _tableView;
}

- (CLSHBottomView *)bottomView{

    if (!_bottomView) {
        _bottomView = [[CLSHBottomView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-40*AppScale, SCREENWIDTH, 40*AppScale)];
    }
    return _bottomView;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor colorWithWhite:0.9 alpha:0.2];
    hud.color=[UIColor clearColor];
    hud.activityIndicatorColor=systemColor;
    [self loadData];
}

#pragma mark -- init UI
- (void)initUI{

    self.view.backgroundColor = backGroundColor;
    self.navigationItem.title =@"立即结算";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.allowsMultipleSelection = YES;
    WS(weakSelf);
    self.bottomView.selectAllblock = ^(BOOL isSelect){
        if (isSelect == YES) {
            
            for (int i = 0; i < _dataArray.count; i++) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [weakSelf.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                CLSHSettleBalanceListModel * BalanceListModel = [[CLSHSettleBalanceListModel alloc] init];
                BalanceListModel = [_dataArray objectAtIndexCheck:i];
                sum = sum + BalanceListModel.calAmount;
            }
            _bottomView.sumMoneyLabel.text =[NSString stringWithFormat:@"合计: ￥%.2lf",sum];
        } else {
            
            for (int i = 0; i < _dataArray.count; i++) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [weakSelf.tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
            sum = 0;
             _bottomView.sumMoneyLabel.text =[NSString stringWithFormat:@"合计: ￥0.00"];
        }
    };
    
    self.bottomView.sureSettleblock = ^(){
    
        [weakSelf sureSettle];
    };
    
    [self.tableView registerClass:[CLSHImmedieatelySettleTableViewCell class] forCellReuseIdentifier:immediatelySettleCellID];
    [self.tableView registerClass:[CLSHImmediatelySettleHeadView class] forHeaderFooterViewReuseIdentifier:immediatelySettleHeadViewID];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
    
}

#pragma mark bottomView button click
- (void)sureSettle{

     __block CLSHSettleBalanceListModel * BalanceListModel = [[CLSHSettleBalanceListModel alloc] init];
    NSArray * indexpaths = [_tableView indexPathsForSelectedRows];
    NSMutableArray * marray = [NSMutableArray array];
    [indexpaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        BalanceListModel = _dataArray[indexPath.row];
        [marray addObject:BalanceListModel.date];
    }];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您是否确定结算" message: @"结算后资金会进入账户余额" preferredStyle:1];
    UIAlertAction *viewCancle = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *viewSure =  [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //数据请求
        NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
        CLSHSubmitSettleModel * submitSettleModel = [CLSHSubmitSettleModel new];
        needsParams[@"dateArray"] = marray;
        [submitSettleModel fetchSubmitSettle:needsParams callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [self loadData];
            }else{
            
                [hud hide:YES];
                [MBProgressHUD showError:result];
            }
        }];
    }];
    
    [alert addAction:viewCancle];
    [alert addAction:viewSure];
    
    if (marray.count >0) {
        [self presentViewController:alert animated:YES completion:nil];
    }else{
    
        [MBProgressHUD showError:@"请选择结算日期"];
    }
    
    
}

#pragma mark -- loada data
- (void)loadData{
    
    settleMoneyModel = [[CLSHSettleImmediatelyModel alloc] init];
    [settleMoneyModel fetchSettleBalanceImmediately:nil callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            [hud hide:YES];
            [self.dataArray removeAllObjects];
            self.bottomView.selectBtn.selected = NO;
            _bottomView.sumMoneyLabel.text =[NSString stringWithFormat:@"合计: ￥0.00"];
            settleMoneyModel = result;
            self.dataArray = [NSMutableArray arrayWithArray:settleMoneyModel.items];
            [self.tableView reloadData];
        }else{
            [hud hide:YES];
        
            [MBProgressHUD showError:result];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

- (void)dealloc{

    [hud hide:YES];
    
}

#pragma mark -- table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CLSHImmediatelySettleHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:immediatelySettleHeadViewID];
    if (!headView) {
        headView = [[CLSHImmediatelySettleHeadView alloc] initWithReuseIdentifier:immediatelySettleHeadViewID];
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHImmedieatelySettleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:immediatelySettleCellID];
    if (!cell) {
        cell = [[CLSHImmedieatelySettleTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:immediatelySettleCellID];
    }
    CLSHSettleBalanceListModel * BalanceListModel = [[CLSHSettleBalanceListModel alloc] init];
    BalanceListModel = [_dataArray objectAtIndexCheck:indexPath.row];
    cell.model = BalanceListModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _bottomView.sumMoneyLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",sum];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHSettleBalanceListModel * BalanceListModel = [[CLSHSettleBalanceListModel alloc] init];
    BalanceListModel = [_dataArray objectAtIndexCheck:indexPath.row];
    sum = sum + BalanceListModel.calAmount;
    _bottomView.sumMoneyLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",sum];
    [self isSelectedAll];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHSettleBalanceListModel * BalanceListModel = [[CLSHSettleBalanceListModel alloc] init];
    BalanceListModel = [_dataArray objectAtIndexCheck:indexPath.row];
    sum = sum - BalanceListModel.calAmount;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelSelectAll" object:nil];
    _bottomView.sumMoneyLabel.text = [NSString stringWithFormat:@"合计: ￥%.2f",sum];
}

#pragma mark -- 判断是否全选
- (void)isSelectedAll{

    NSArray * indexpath = [_tableView indexPathsForSelectedRows];
    if (indexpath.count == _dataArray.count) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectAll" object:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
