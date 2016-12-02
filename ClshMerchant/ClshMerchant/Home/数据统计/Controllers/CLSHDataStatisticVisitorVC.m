//
//  CLSHDataStatisticVisitorVC.m
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


#import "CLSHDataStatisticVisitorVC.h"
#import "CLSHDataStatisticHeadView.h"
#import "CLSHDataVisitorCell.h"
#import "CLSHDataStatsticFooterView.h"
#import "CLSHDataStaticModel.h"

@interface CLSHDataStatisticVisitorVC ()<UITableViewDelegate, UITableViewDataSource>{

    CLSHVisitorStaticModel * visitorModel;
    MBProgressHUD *hud;
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)CLSHDataStatisticHeadView *headView;
@property (nonatomic, strong)NSArray *nameArray;

@end

@implementation CLSHDataStatisticVisitorVC
static NSString *const ID = @"CLSHDataVisitorCell";

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 210*AppScale, SCREENWIDTH, SCREENHEIGHT-210*AppScale) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(CLSHDataStatisticHeadView *)headView
{
    if (!_headView) {
        _headView = [[CLSHDataStatisticHeadView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 210*AppScale)];
    }
    return _headView;
}

-(NSArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = [NSArray arrayWithObjects:@"今日访客量", @"7天访客量", @"30天访客量", nil];
    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"访客统计"];
    //加载数据
    [self loadData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headView];
    
    //注册cell
    [self.tableView registerClass:[CLSHDataVisitorCell class] forCellReuseIdentifier:ID];
    
    CLSHDataStatsticFooterView *footerView = [[CLSHDataStatsticFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*AppScale)];
    self.tableView.tableFooterView = footerView;
    
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color=[UIColor clearColor];
    hud.backgroundColor=backGroundColor;
    hud.activityIndicatorColor=systemColor;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //RGBColor(0, 149, 68)
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(255, 255, 255) colorWithAlphaComponent:1]];
    [self hideNavBlackLine];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:RGBColor(51, 51, 51),NSFontAttributeName:[UIFont systemFontOfSize:15*AppScale]};
     self.navigationItem.leftBarButtonItem=[UIBarButtonItem normalTitle:@"返回" selectTitle:@"返回" normalColor:systemColor selectColor:systemColor normalImage:@"arrow" selectImage:@"arrow" target:self action:@selector(back) size:CGSizeMake(50*AppScale, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}

- (void)loadData{

    visitorModel = [[CLSHVisitorStaticModel alloc] init];
    [visitorModel fetchVisitorStaticData:nil callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            visitorModel = result;
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


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[systemColor colorWithAlphaComponent:1]];
    [self hideNavBlackLine];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15*AppScale]};
}

-(void)hideBar{
    
    //给导航条设置一个空的背景图 使其透明化
    [self.navigationController .navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

/**
 *  隐藏黑线
 */
-(void)hideNavBlackLine{
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id object in list) {
            if ([object isKindOfClass:[UIImageView class]]) {
                UIImageView *imageViews=(UIImageView *)object;
                imageViews.hidden=YES;
            }
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHDataVisitorCell *visitorCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!visitorCell) {
        visitorCell = [[CLSHDataVisitorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    visitorCell.selectionStyle = UITableViewCellSelectionStyleNone;
    visitorCell.name.text = nil;
    visitorCell.name.text = self.nameArray[indexPath.row];
    _headView.count.text = [NSString stringWithFormat:@"%ld人",visitorModel.visitorCount];
    [NSString labelString:_headView.count font:[UIFont systemFontOfSize:30*AppScale] range:NSMakeRange(0, _headView.count.text.length-1) color:[UIColor whiteColor]];
    switch (indexPath.row) {
        case 0:
//            visitorCell.countUV.text = [NSString stringWithFormat:@"%ld",visitorModel.todayUV];
            visitorCell.countPV.text = [NSString stringWithFormat:@"%ld人",visitorModel.today];
            break;
        case 1:
//            visitorCell.countUV.text = [NSString stringWithFormat:@"%ld",visitorModel.todayUV];
            visitorCell.countPV.text = [NSString stringWithFormat:@"%ld人",visitorModel.sevenDays];
            break;
        case 2:
//            visitorCell.countUV.text = [NSString stringWithFormat:@"%ld",visitorModel.todayUV];
            visitorCell.countPV.text = [NSString stringWithFormat:@"%ld人",visitorModel.thirtyDays];
            break;
        default:
            break;
    }
    [NSString labelString:visitorCell.countPV font:[UIFont systemFontOfSize:18*AppScale] range:NSMakeRange(0, visitorCell.countPV.text.length-1) color:[UIColor redColor]];
    return visitorCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70*AppScale;
}

@end
