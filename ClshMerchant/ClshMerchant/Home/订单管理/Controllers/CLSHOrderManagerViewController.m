//
//  CLSHOrderManagerViewController.m
//  ClshMerchant
//
//  Created by arom on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHOrderManagerViewController.h"
#import "KBSegmentView.h"
#import "CLSHNonOrderView.h"
#import "CLSHOrderTableViewCell.h"
#import "CLSHHeaderView.h"
#import "CLSHFooterView.h"
#import "CLSHOrderDetailViewController.h"
#import "CLSHFeedBackCheckViewController.h"
#import "CLSHOrderManageModel.h"
#import "CLSHApplyFeedBackFooterView.h"
#import "CLSHAnswerCommentFooterView.h"
#import "CLSHOtherFooterView.h"
#import "CLSHAnsweredFooterView.h"
#import "CLSHCommentDetailViewController.h"

@interface CLSHOrderManagerViewController ()<UITableViewDelegate,UITableViewDataSource,KBSegmentViewDelegate>{

    NSArray * topArray;//头部菜单数组
    NSMutableDictionary * params;  //参数
    CLSHOrderManageModel * managerModel; //订单列表基model
    
    NSInteger pageNum;
}

@property (nonatomic,strong)UITableView * tableView;     ///<视图
@property (nonatomic,strong)NSMutableArray * dataArray;  ///<数据源数组
@property (nonatomic,strong)CLSHNonOrderView * nonOrederView;///<空视图
@property (nonatomic,strong)NSMutableDictionary * saveIdDict;///<存放头部视图id

@end

@implementation CLSHOrderManagerViewController

static NSString * const orderCellID = @"orderCellID";
static NSString * const hearderViewID = @"headerViewID";
static NSString * const footerViewID = @"footerViewID";
static NSString * const feedBackViewID = @"feedBackFooterID";
static NSString * const answerCommentViewID = @"answerCommentID";
static NSString * const otherFooterViewID = @"otherFooterViewID";
static NSString * const answeredViewID = @"answeredViewID";

#pragma mark --懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40*AppScale, SCREENWIDTH, SCREENHEIGHT-40*AppScale-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (CLSHNonOrderView *)nonOrederView{

    if (!_nonOrederView) {
        _nonOrederView = [[CLSHNonOrderView alloc] initWithFrame:CGRectMake(0, 64+40*AppScale, SCREENWIDTH, SCREENHEIGHT-64-40*AppScale)];
        _nonOrederView.backgroundColor = backGroundColor;
    }
    return _nonOrederView;
}

- (NSMutableDictionary *)saveIdDict{

    if (_saveIdDict) {
        _saveIdDict = [NSMutableDictionary dictionary];
    }
    return _saveIdDict;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //加载数据
    [self.tableView.mj_header beginRefreshing];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    managerModel = [[CLSHOrderManageModel alloc] init];
    params = [NSMutableDictionary dictionary];
    
    //初始化UI
    [self initUI];
}

#pragma mark --初始化UI
- (void)initUI{

    self.view.backgroundColor = backGroundColor;
    self.navigationItem.title = @"订单管理";
    topArray = @[@"已付款",@"配送中",@"退款申请",@"已完成"];
    KBSegmentView * segmentView = [KBSegmentView createSegmentFrame:CGRectMake(0, 65, SCREENHEIGHT, 40*AppScale) segmentTitleArr:topArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] selectTitleColor:systemColor titleFont:[UIFont systemFontOfSize:14*AppScale] bottomLineColor:systemColor isVerticleBar:NO delegate:self];
    [self.view addSubview:segmentView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHOrderTableViewCell" bundle:nil] forCellReuseIdentifier:orderCellID];
    [self.tableView registerClass:[CLSHFooterView class] forHeaderFooterViewReuseIdentifier:footerViewID];
    [self.tableView registerClass:[CLSHApplyFeedBackFooterView class] forHeaderFooterViewReuseIdentifier:feedBackViewID];
    [self.tableView registerClass:[CLSHAnswerCommentFooterView class] forHeaderFooterViewReuseIdentifier:answerCommentViewID];
    [self.tableView registerClass:[CLSHOtherFooterView class] forHeaderFooterViewReuseIdentifier:otherFooterViewID];
    [self.tableView registerClass:[CLSHAnsweredFooterView class] forHeaderFooterViewReuseIdentifier:answeredViewID];
    self.automaticallyAdjustsScrollViewInsets=NO;
    params[@"status"] = @"pendingShipment";
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:self.tableView];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark --加载数据
- (void)loadNewData{
    pageNum = 1;
    params[@"pageNumber"] = @(pageNum);
    params[@"pageSize"] = @(10);
    
    [managerModel fetchOrderData:params callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            managerModel = result;
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:managerModel.orders];
            if (_dataArray.count) {
                [self.nonOrederView removeFromSuperview];
            }else{
                [self.view addSubview:self.nonOrederView];
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
            if (managerModel.orders.count<10) {
                self.tableView.mj_footer.hidden=YES;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                self.tableView.mj_footer.hidden=NO;
                [self.tableView.mj_footer resetNoMoreData];
            }
        }else{
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
}

- (void)loadMoreData{

    pageNum++;
    params[@"pageNumber"] = @(pageNum);
    
    [managerModel fetchOrderData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            managerModel = result;
            [self.dataArray addObjectsFromArray:managerModel.orders];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
            
            if (managerModel.orders.count<10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }else{
            [self.tableView.mj_footer endRefreshing];

        }
    }];
}

#pragma mark --segmentDelegate
- (void)selectSegment:(NSInteger)index{

    switch (index) {
        case 0:
            NSLog(@"已付款");
            params[@"status"] = @"pendingShipment";

            [_tableView.mj_header beginRefreshing];
            break;
        case 1:
            NSLog(@"配送中");
            params[@"status"] = @"shipped";

            [_tableView.mj_header beginRefreshing];
            break;
        case 2:
            params[@"status"] = @"cancelReview";

            [_tableView.mj_header beginRefreshing];
            NSLog(@"退款申请");
            break;
        case 3:
            params[@"status"] = @"completed,customerReviewed,ownerReplied,received";

            [_tableView.mj_header beginRefreshing];
            NSLog(@"已完成");
            break;
            
        default:
            break;
    }
}

#pragma mark --tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    CLSHOderListModel * orderListModel = [[CLSHOderListModel alloc] init];
    orderListModel = _dataArray[section];
    NSMutableArray * arr = [NSMutableArray arrayWithArray:orderListModel.orderItems];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 40*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [_saveIdDict objectForKey:[NSString stringWithFormat:@"%zi", section]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (identifier == nil)
    {
        identifier = [NSString stringWithFormat:@"%@%@", @"headViewID",[NSString stringWithFormat:@"%zi", section]];
        [_saveIdDict setValue:identifier forKey:[NSString stringWithFormat:@"%zi",section]];
        
        [self.tableView registerClass:[CLSHHeaderView class] forHeaderFooterViewReuseIdentifier:identifier];
    }
    
    CLSHHeaderView * headerView = [[CLSHHeaderView alloc] initWithReuseIdentifier:identifier];
    CLSHOderListModel * orderListModel  = [[CLSHOderListModel alloc] init];
    orderListModel = _dataArray[section];
    headerView.model = orderListModel;
    NSLog(@"头部视图");
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UITableViewHeaderFooterView * footerView = [[UITableViewHeaderFooterView alloc] init];
    CLSHOderListModel * orderlistModel = [[CLSHOderListModel alloc] init];
    orderlistModel = [_dataArray objectAtIndexCheck:section];
    
    if ([orderlistModel.status isEqualToString:@"pendingShipment"]) {
         CLSHFooterView * payedView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewID];
        NSString *moneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderlistModel.orderAmount]];
        payedView.moneyLabel.text = moneyStr;
        footerView = payedView;
        
        payedView.stateButtonblock = ^(){
            
            NSLog(@"点击配送");
            NSMutableDictionary * deliveryParams = [NSMutableDictionary dictionary];
            deliveryParams[@"orderId"] = orderlistModel.orderId;
            
            CLSHDeliveryOrderModel * deliveryModel = [[CLSHDeliveryOrderModel alloc] init];
            [deliveryModel fetchDeliveryOrderData:deliveryParams callBack:^(BOOL isSuccess, id result) {
               
                if (isSuccess) {
//                    [MBProgressHUD showSuccess:result];
//                    [self loadNewData];
                    [_tableView.mj_header beginRefreshing];
                }else{
                
                    [MBProgressHUD showError:result];
                }
            }];
        };
    }else if ([orderlistModel.status isEqualToString:@"cancelReview"]){
    
        CLSHApplyFeedBackFooterView * feedBackView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:feedBackViewID];
        NSString *moneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderlistModel.orderAmount]];
        feedBackView.moneyLabel.text = moneyStr;
        footerView = feedBackView;
        feedBackView.stateButtonblock = ^(){
        
            NSLog(@"审核");
            CLSHFeedBackCheckViewController * feedBackCheckVC = [[CLSHFeedBackCheckViewController alloc] init];
            feedBackCheckVC.sn = orderlistModel.sn;
            [self.navigationController pushViewController:feedBackCheckVC animated:YES];
        };
    }else if ([orderlistModel.status isEqualToString:@"customerReviewed"]){
    
        CLSHAnswerCommentFooterView * answerCommentView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:answerCommentViewID];
        NSString *moneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderlistModel.orderAmount]];
        answerCommentView.moneyLabel.text = moneyStr;
        footerView = answerCommentView;
        answerCommentView.stateButtonblock = ^(){
        
            NSLog(@"回复评论");
            CLSHCommentDetailViewController * commentDetailVC = [[CLSHCommentDetailViewController alloc] init];
            commentDetailVC.orderID = orderlistModel.orderId;
            commentDetailVC.isReply = NO;
            
            [self.navigationController pushViewController:commentDetailVC animated:YES];
        };
    }else if ([orderlistModel.status isEqualToString:@"ownerReplied"]){
    
        CLSHAnsweredFooterView * answeredView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:answeredViewID];
        NSString *moneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderlistModel.orderAmount]];
        answeredView.moneyLabel.text = moneyStr;
        footerView = answeredView;
        answeredView.stateButtonblock = ^(){
        
             NSLog(@"查看评论");
            CLSHCommentDetailViewController * commentDetailVC = [[CLSHCommentDetailViewController alloc] init];
            commentDetailVC.orderID = orderlistModel.orderId;
            commentDetailVC.isReply = YES;
            [self.navigationController pushViewController:commentDetailVC animated:YES];
        };
    }else{
    
        CLSHOtherFooterView * otherFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:otherFooterViewID];
        NSString *moneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderlistModel.orderAmount]];
        otherFooterView.moneyLabel.text = moneyStr;
        footerView = otherFooterView;
    }
   
    return footerView;
}

#pragma mark --tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHOrderTableViewCell * orderCell = [tableView dequeueReusableCellWithIdentifier:orderCellID];
    if (!orderCell) {
        orderCell = [[CLSHOrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:orderCellID];
    }
    orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLSHOrderModel * orderModel = [[CLSHOrderModel alloc] init];
    CLSHOderListModel * orderListModel  = [[CLSHOderListModel alloc] init];
    orderListModel = _dataArray[indexPath.section];
    orderModel = orderListModel.orderItems[indexPath.row];
    orderCell.orderListModel = orderModel;
    
    return orderCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHOrderDetailViewController * orderDetailVC = [[CLSHOrderDetailViewController alloc] init];
    CLSHOderListModel * orderListModel  = [[CLSHOderListModel alloc] init];
    orderListModel = [_dataArray objectAtIndexCheck:indexPath.section];
    orderDetailVC.sn = orderListModel.sn;
    orderDetailVC.orderId = orderListModel.orderId;
    if ([orderListModel.status isEqualToString:@"pendingShipment"]) {
        orderDetailVC.isPayed = YES;
    }else if([orderListModel.status isEqualToString:@"pendingReview"]){
        orderDetailVC.isCancelOrder = YES;
    }
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
