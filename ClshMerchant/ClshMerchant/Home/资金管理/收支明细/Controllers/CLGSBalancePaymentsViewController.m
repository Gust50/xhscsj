//
//  CLGSBalancePaymentsViewController.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSBalancePaymentsViewController.h"
#import "CLGSBalanceFirstCell.h"
#import "CLGSBalanceSecondTableViewCell.h"
#import "CLGSPaymentOrderController.h"
#import "CLSHAccountBalanceModel.h"
#import "KBSegmentView.h"

@interface CLGSBalancePaymentsViewController ()<UITableViewDelegate, UITableViewDataSource,KBSegmentViewDelegate>
{
    
    CLSHAccountIncomeModel *incomeAndExpendModel;       ///<收支数据模型
    NSInteger pageNum;                                      ///<当前页码
    NSMutableDictionary *params;                            ///<分页加载参数
}

@property(nonatomic,strong)NSMutableArray *dataSource;      ///<数据源
@property (nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)KBSegmentView *segment;         ///<segment控件
@end

@implementation CLGSBalancePaymentsViewController

static NSString *const firstCellID = @"firstCell";
static NSString *const secondCellID = @"secondCell";

#pragma mark <lazyLoad>
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40*AppScale+64, SCREENWIDTH, SCREENHEIGHT-40*AppScale-64) style:UITableViewStyleGrouped];
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

-(KBSegmentView *)segment
{
    if (!_segment) {
        _segment = [KBSegmentView createSegmentFrame:CGRectMake(0, 64, SCREENWIDTH, 40*AppScale)
                                     segmentTitleArr:@[@"现金账户",@"奖励账户"]
                                     backgroundColor:[UIColor whiteColor]
                                          titleColor:RGBColor(102, 102, 102)
                                    selectTitleColor:systemColor
                                           titleFont:[UIFont systemFontOfSize:14*AppScale]
                                     bottomLineColor:systemColor
                                       isVerticleBar:YES
                                            delegate:self];
        _segment.delegate = self;
    }
    return _segment;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"系统版本的名字%@%@",[[UIDevice currentDevice] systemVersion],[[UIDevice currentDevice] systemName]);
     params = [NSMutableDictionary dictionary];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = backGroundColor;
    self.navigationItem.title = self.title;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSBalanceFirstCell" bundle:nil] forCellReuseIdentifier:firstCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLGSBalanceSecondTableViewCell" bundle:nil] forCellReuseIdentifier:secondCellID];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    
    self.segment.selectNum = 0;
    params[@"amountType"] = nil;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma mark <loadData>
//加载最新数据
-(void)loadNewData
{
    incomeAndExpendModel = [[CLSHAccountIncomeModel alloc] init];
    pageNum=1;
    params[@"pageSize"] = @(10);
    params[@"pageNumber"] =@(pageNum);
    
    [incomeAndExpendModel fetchAccountIncomeData:params callBack:^(BOOL isSuccess, id result) {
    
        if (isSuccess)
        {
            incomeAndExpendModel = result;
            [_dataSource removeAllObjects];
            
            [self.dataSource addObjectsFromArray:incomeAndExpendModel.items];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (incomeAndExpendModel.items.count<10)
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

    NSLog(@"000000000______%@",incomeAndExpendModel.totalPages);
    if ([incomeAndExpendModel.totalPages integerValue] > pageNum) {
        pageNum++;
        params[@"pageNumber"]=@(pageNum);
        [incomeAndExpendModel fetchAccountIncomeData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess)
            {
             
                CLSHAccountIncomeModel * incomeModel = [[CLSHAccountIncomeModel alloc] init];
                incomeModel = result;
                [self.dataSource addObjectsFromArray:incomeModel.items];

                //[self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
                
                if ((((CLSHAccountIncomeModel *)result).items.count)<10)
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

#pragma mark -- segmentView delegate
- (void)selectSegment:(NSInteger)index{

    if (index == 1) {
        params[@"amountType"] = @"freezed_gift";
    }else{
     
        params[@"amountType"] = nil;
    }
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark - tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return _dataSource.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLGSBalanceFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellID];
    CLGSBalanceSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellID];
    firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        
        if (!firstCell) {
            firstCell = [[CLGSBalanceFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellID];
        }
        firstCell.incomeAndExpendModel = incomeAndExpendModel;
        firstCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return firstCell;
    }else if(indexPath.section == 1)
    {
        if (!cell) {
            cell = [[CLGSBalanceSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellID];
        }
       cell.incomeAndExpendListModel = _dataSource[indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark-tableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100*AppScale;
    }
    return 70*AppScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        CLGSPaymentOrderController *order = [[CLGSPaymentOrderController alloc] init];
        CLSHAccountIncomeListModel *listModel = _dataSource[indexPath.row];
        order.typeID = listModel.incomeID;
        order.type = listModel.amountType;
        order.amount = [listModel.amount floatValue];
        [self.navigationController pushViewController:order animated:YES];
    }
}

@end
