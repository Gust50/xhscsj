//
//  CLSHOrderDetailViewController.m
//  ClshMerchant
//
//  Created by arom on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHOrderDetailViewController.h"
#import "CLSHOrderDetailHeadView.h"
#import "CLSHInformationOfOrderTableViewCell.h"
#import "CLSHAddressTableViewCell.h"
#import "CLSHOrderPayTableViewCell.h"
#import "CLSHOrderTableViewCell.h"
#import "CLSHPayedBottomView.h"
#import "CLSHDeliveryBottomView.h"
#import "CLSHCancelOrderView.h"
#import "CLSHOrderManageModel.h"
#import "KBDateFormatter.h"
#import "CLSHFeedBackCheckViewController.h"

@interface CLSHOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,cancelOrderDelagate>{

    CLSHOrderDetailModel * orderDetailModel;   //基model
    CLSHOrderDetailInfoModel * orderDetailInfoModel;  //订单信息model
    
}

@property (nonatomic,strong)UITableView * tableView;                        ///<视图
@property (nonatomic,strong)NSMutableArray * dataArray;                     ///<数据源数组
@property (nonatomic,strong)CLSHPayedBottomView * payedBottomView;          // 已付款底部视图
@property (nonatomic,strong)CLSHDeliveryBottomView * deliveryBottomView;    //配送底部视图
@property (nonatomic,strong)CLSHCancelOrderView * cancelOrderView;          //已付款取消订单视图

@end

@implementation CLSHOrderDetailViewController

static NSString * const headViewID= @"orderDetailHeadViewID";
static NSString * const orderInformationID= @"orderInformationID";
static NSString * const orderDetailAddressID = @"orderDetailAddressID";
static NSString * const orderPayID = @"orderPayID";
static NSString * const orderListID = @"orderCellID";
#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10*AppScale, SCREENWIDTH, SCREENHEIGHT-64-10*AppScale) style:(UITableViewStyleGrouped)];
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

- (CLSHPayedBottomView *)payedBottomView{

    if(!_payedBottomView){
    
        _payedBottomView = [[CLSHPayedBottomView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-50*AppScale, SCREENWIDTH, 50*AppScale)];
        _payedBottomView.backgroundColor = backGroundColor;
    }
    return _payedBottomView;
}

- (CLSHDeliveryBottomView *)deliveryBottomView{

    if (!_deliveryBottomView) {
        _deliveryBottomView = [[CLSHDeliveryBottomView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-50*AppScale, SCREENWIDTH, 50*AppScale)];
        _deliveryBottomView.backgroundColor = backGroundColor;
    }
    return _deliveryBottomView;
}

- (CLSHCancelOrderView *)cancelOrderView{

    if (!_cancelOrderView) {
        _cancelOrderView = [[CLSHCancelOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _cancelOrderView.delegate = self;
    }
    return _cancelOrderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    orderDetailModel = [[CLSHOrderDetailModel alloc] init];
    orderDetailInfoModel = [[CLSHOrderDetailInfoModel alloc] init];
    
    [self initUI];
    
    [self loadData];
    
}

- (void)loadData{

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"sn"] = self.sn;
    
    [orderDetailModel fetchOrderDetailData:params callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            
            orderDetailModel = result;
            orderDetailInfoModel = orderDetailModel.order;
            self.dataArray = [NSMutableArray arrayWithArray:orderDetailInfoModel.orderItems];
            [self.tableView reloadData];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark -- initUI
- (void)initUI{

    self.navigationItem.title = @"订单详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = backGroundColor;

    WS(weakSelf);
    if (_isPayed) {
        [self.view addSubview:self.payedBottomView];
        self.tableView.frame = CGRectMake(0, 64+10*AppScale, SCREENWIDTH, SCREENHEIGHT-64-60*AppScale);
        _payedBottomView.deliveryblock = ^(){
        
            NSLog(@"配送");
            CLSHDeliveryOrderModel * deliveryModel = [[CLSHDeliveryOrderModel alloc] init];
            NSMutableDictionary * deliveryParams = [NSMutableDictionary dictionary];
            deliveryParams[@"orderId"] = weakSelf.orderId;
            [deliveryModel fetchDeliveryOrderData:deliveryParams callBack:^(BOOL isSuccess, id result) {
               
                if (isSuccess) {
                    [MBProgressHUD showSuccess:result];
                    [weakSelf loadData];
                }else{
                
                    [MBProgressHUD showError:result];
                }
            }];
        };
        _payedBottomView.cancelOrderblock =^(){
        
            NSLog(@"取消订单");
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.cancelOrderView];
            
        };
    }
    if (_isCancelOrder) {
        [self.view addSubview:self.deliveryBottomView];
        self.tableView.frame = CGRectMake(0, 64+10*AppScale, SCREENWIDTH, SCREENHEIGHT-64-60*AppScale);
        _deliveryBottomView.applyFeedBackblock = ^(){
        
            NSLog(@"申请退款");
            CLSHFeedBackCheckViewController * feedBackCheckVC = [[CLSHFeedBackCheckViewController alloc] init];
            [weakSelf.navigationController pushViewController:feedBackCheckVC animated:YES];
        };
    }
    //注册headview/cell
//    [self.tableView registerClass:[CLSHOrderDetailHeadView class] forCellReuseIdentifier:headViewID];
    [self.tableView registerClass:[CLSHInformationOfOrderTableViewCell class] forCellReuseIdentifier:orderInformationID];
    [self.tableView registerClass:[CLSHAddressTableViewCell class] forCellReuseIdentifier:orderDetailAddressID];
    [self.tableView registerClass:[CLSHOrderPayTableViewCell class] forCellReuseIdentifier:orderPayID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHOrderTableViewCell" bundle:nil] forCellReuseIdentifier:orderListID];
    
    [self.view addSubview:self.tableView];
}

#pragma mark -- cancelOrder delegate
- (void)cancelOrder{

    //取消订单
    CLSHCancelOrderModel * cancelModel = [[CLSHCancelOrderModel alloc] init];
    NSMutableDictionary * needParams = [NSMutableDictionary dictionary];
    needParams[@"orderId"] = _orderId;
    needParams[@"reason"] = self.cancelOrderView.textFieldView.text;
    
    if (self.cancelOrderView.textFieldView.text.length == 0) {
        [MBProgressHUD showError:@"请填写原因!"];
    }else{
    
        [cancelModel fetchCancelOrderData:needParams callBack:^(BOOL isSuccess, id result) {
           
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                [self loadData];
            }else{
            
                [MBProgressHUD showError:result];
            }
        }];
    }
}

#pragma mark -- tabelView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 4;
    }else if (section == 1){
    
        if (orderDetailInfoModel.consignee.length == 0) {
            return 0;
        }
        return 1;
    }else if (section == 2){
    
        return orderDetailInfoModel.orderItems.count;
    }else{
    
        return 3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 44*AppScale;
    }else if (indexPath.section == 1){
    
        return 70*AppScale;
    }else if (indexPath.section == 2){
    
        return 100*AppScale;
    }else{
    
        return 44*AppScale;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        if (orderDetailInfoModel.consignee.length == 0) {
            return 0.01;
        }
    }
    return 40*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if(section == 1){
    
        if (orderDetailInfoModel.consignee.length == 0) {
            return 0.01;
        }
    }
    
    return 10*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

     CLSHOrderDetailHeadView * headView  = [[CLSHOrderDetailHeadView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    if(section == 0){
    
        headView.icon.image = [UIImage imageNamed:@"OrderInformationIcon"];
        headView.nameLabel.text = @"订单信息";
    }else if (section == 1){
        
        if (orderDetailInfoModel.consignee.length == 0) {
            headView = nil;
        }else{
        
            headView.icon.image = [UIImage imageNamed:@"ConsigneeInfoIcon"];
            headView.nameLabel.text = @"收货人信息";
        }
        
    }else if (section == 2) {
        headView.icon.image = [UIImage imageNamed:@"ProductListIcon"];
        headView.nameLabel.text = @"商品清单";
       }else if (section == 3){
            
        headView.icon.image = [UIImage imageNamed:@"PayDetailIcon"];
        headView.nameLabel.text = @"支付明细";
    }
        return headView;
}

#pragma mark -- tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        CLSHInformationOfOrderTableViewCell * informationOfOrderCell = [tableView dequeueReusableCellWithIdentifier:orderInformationID];
        informationOfOrderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            informationOfOrderCell.leftLabel.text = @"下单时间:";
            NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([orderDetailInfoModel.createTime doubleValue]/1000.0)];
            NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
            informationOfOrderCell.rightLabel.text = timeString;
        }else if(indexPath.row ==1){
            informationOfOrderCell.leftLabel.text = @"订单编号:";
            informationOfOrderCell.rightLabel.text = orderDetailInfoModel.sn;
        }else if (indexPath.row == 2){
        
            informationOfOrderCell.leftLabel.text = @"配送方式:";
            if (orderDetailInfoModel.consignee.length == 0) {
                informationOfOrderCell.rightLabel.text = @"商家配送";
            }else{
            
                informationOfOrderCell.rightLabel.text = @"到店自提";
            }
        }else{
        
            informationOfOrderCell.leftLabel.text = @"订单状态";
            if ([orderDetailInfoModel.status isEqualToString:@"pendingShipment"]) {
                informationOfOrderCell.rightLabel.text = @"已付款";
            }else if ([orderDetailInfoModel.status isEqualToString:@"shipped"]){
                informationOfOrderCell.rightLabel.text = @"配送中";
            }else if ([orderDetailInfoModel.status isEqualToString:@"completed"]){
                informationOfOrderCell.rightLabel.text = @"已完成";
            }else if ([orderDetailInfoModel.status isEqualToString:@"customerReviewed"]){
                informationOfOrderCell.rightLabel.text = @"已回复";
            }else if ([orderDetailInfoModel.status isEqualToString:@"ownerReplied"]){
                informationOfOrderCell.rightLabel.text = @"已回评";
            }else if ([orderDetailInfoModel.status isEqualToString:@"received"]){
                informationOfOrderCell.rightLabel.text = @"已收货";
            }else if ([orderDetailInfoModel.status isEqualToString:@"pendingReview"]){
                informationOfOrderCell.rightLabel.text = @"退款中";
            }
        }
        
        return informationOfOrderCell;
    }else if (indexPath.section == 1){
    
        CLSHAddressTableViewCell * addressCell = [tableView dequeueReusableCellWithIdentifier:orderDetailAddressID];
        addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        addressCell.recieveName.text = orderDetailInfoModel.consignee;
        addressCell.phoneNum.text = orderDetailInfoModel.phone;
        addressCell.address.text = orderDetailInfoModel.address;
        return addressCell;
    }else if (indexPath.section == 2){
    
        CLSHOrderTableViewCell * orderCell = [tableView dequeueReusableCellWithIdentifier:orderListID];
        if (!orderCell) {
            orderCell = [[CLSHOrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:orderListID];
        }
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        CLSHOrderDetailGoodsListModel * goodsListModel = [[CLSHOrderDetailGoodsListModel alloc] init];
        goodsListModel = [orderDetailInfoModel.orderItems objectAtIndexCheck:indexPath.row];
        orderCell.model = goodsListModel;
        return orderCell;
    }else{
    
        CLSHOrderPayTableViewCell * orderPayCell = [tableView dequeueReusableCellWithIdentifier:orderPayID];
        orderPayCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            orderPayCell.leftLabel.text = @"支付方式:";
            DLog(@"%@",orderDetailInfoModel.paymentMethodName);
            orderPayCell.rightLabel.text = orderDetailInfoModel.paymentMethodName;
        }else if (indexPath.row ==1){
            orderPayCell.leftLabel.text = @"支付总额:";
            NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailInfoModel.paymentAmount]];
            orderPayCell.rightLabel.text = rightStr;
            orderPayCell.rightLabel.textColor = RGBColor(241, 72, 36);
        }else if (indexPath.row == 2){
        
            orderPayCell.leftLabel.text = @"运    费:";
            orderPayCell.rightLabel.textColor = RGBColor(241, 72, 36);
            if (orderDetailInfoModel.freight == 0) {
                orderPayCell.rightLabel.text = @"免费";
            }else{
                NSString *rightStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:orderDetailInfoModel.freight]];
                orderPayCell.rightLabel.text = rightStr;
                
            }
            
        }
        return orderPayCell;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
