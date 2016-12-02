//
//  CLSHNeighbourhoodMerchantVC.m
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighbourhoodMerchantVC.h"
#import "CLSHNeighbourhoodMerchantTopView.h"
#import "CLSHNeightbourhoodShopLeftCell.h"
#import "CLSHNeightbourhoodShopRightCell.h"
#import "KBSegmentView.h"
#import "UINavigationBar+Awesome.h"
#import "CLGSDetailCommentCell.h"
#import "CLSHIntroduceTableViewCell.h"
#import "CLSHIntroduceWebViewTableViewCell.h"
#import "CLSHNeighborhoodMerchantToolBar.h"
#import "CLSHNeighbourhoodMerchantDetailVC.h"
#import "CLSHNeighborhoodModel.h"
#import "KBCircleSegmentView.h"
#import "CLSHNeighborhoodShopCartView.h"
#import "CLSHConfirmOrderVC.h"
#import "CLSHNeighborhoodModel.h"
#import "CLSHHomeRemarkModel.h"
#import "KBButton.h"
#import <MapKit/MapKit.h>

#define kLeftTableViewWidth    [UIScreen mainScreen].bounds.size.width/4
#define kRightTableViewWidth   ([UIScreen mainScreen].bounds.size.width/4)*3
#define kTopViewHeight         190*AppScale
#define kMiddleViewHeight      40*AppScale

@interface CLSHNeighbourhoodMerchantVC ()<UITableViewDataSource,UITableViewDelegate,KBSegmentViewDelegate,NeightbourhoodShopRightCellDelegate>{
    
    NSArray * segmentArr;
    NSArray * leftArr; //左侧导航条数据源
    NSMutableArray * rightArr; //右侧商品列表数据源
    
    NSInteger SelectRow;//选中的行
    NSArray * CommentArray;//好评，差评数组
    KBCircleSegmentView * CircleSegment; //好评选择控件
    
    NSMutableArray * remarkArr;//评论数组
    
    CLSHNeighborhoodMerchantLeftModel * leftmodel;//页面基model
    CLSHNeighborhoodMerchantLeftCategoryListModel * leftListModel;//左侧导航栏model
    CLSHNeighborhoodMerchantRightModel * rightListModel;//右侧商品数组model
    CLSHNeighborhoodMerchantRightGoodsListModel * rightGoodsListModel; //右侧商品列表model
    CLSHNeighborhoodMerchantRemarkModel * remarkModel;//评论基model
    CLSHNeighborhoodMerchantRemarkListModel * remarkListModel;//评论model
    CLSHNeighborhoodMerchantIntroductModel * introduceModel;//店铺简介model
    CLSHHomeProductPraisekModel * cLSHHomeProductPraisekModel;//点赞model
    
    NSMutableDictionary *saveMerchantGoodsDict;     ///<存储商家购物车
    CLSHNeighborhoodMerchantToolBar *merchantYoolBar;
    
    NSInteger pageNum;
    NSInteger pageNum1;
    
    NSMutableDictionary * params;
    NSMutableDictionary * remarkParams;
}

//商品
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *rightTableView;
@property (nonatomic,strong)KBSegmentView * segmentVeiw;
@property (nonatomic,strong)CLSHNeighbourhoodMerchantTopView * topView;
@property (nonatomic,strong)UITableView * commentTableView;  //评价view
@property (nonatomic,strong)UITableView * introduceTableView; //简介view

@property (nonatomic, strong) CLSHNeighborhoodShopCartView *neighborhoodShopCartView;   ///<附近商家购物车
@property (nonatomic, strong) UIButton *removeBackViewButton;   ///<购物车背景图层
@property (nonatomic, assign) BOOL isShowCart;     ///<是否显示购物车
@property (nonatomic, assign) BOOL isReset;



@property (nonatomic, assign) CGFloat totalPrice;       ///<总价格
@property (nonatomic, assign) NSInteger totalAmount;    ///<总数量
@end

@implementation CLSHNeighbourhoodMerchantVC
static NSString *const leftID=@"leftCellID";
static NSString *const rightID=@"rightCellID";
static NSString *const commentDtailID = @"CommentDetailID";
static NSString *const introduceID = @"introduceID";
static NSString *const introduceID2 = @"introduceID2";

#pragma mark <lazyLoad>

-(UIButton *)removeBackViewButton
{
    if (!_removeBackViewButton) {
        _removeBackViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, -64, SCREENWIDTH, SCREENHEIGHT + 64 -49)];
        _removeBackViewButton.backgroundColor = [UIColor blackColor];
        _removeBackViewButton.alpha = 0.5;
        [_removeBackViewButton addTarget:self action:@selector(cancelMerchantShopCart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBackViewButton;
}

-(UITableView *)leftTableView{
    
    if (!_leftTableView) {
        _leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, kTopViewHeight+kMiddleViewHeight+1, kLeftTableViewWidth,SCREENHEIGHT-kTopViewHeight-kMiddleViewHeight-1-49) style:UITableViewStylePlain];
        _leftTableView.delegate=self;
        _leftTableView.dataSource=self;
        _leftTableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(kLeftTableViewWidth, kTopViewHeight+kMiddleViewHeight+1, kRightTableViewWidth,SCREENHEIGHT-kTopViewHeight-kMiddleViewHeight-1-49) style:UITableViewStylePlain];
        _rightTableView.delegate=self;
        _rightTableView.dataSource=self;
        _rightTableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _rightTableView;
}

- (KBSegmentView *)segmentVeiw{
    
    if (!_segmentVeiw) {
        _segmentVeiw = [KBSegmentView createSegmentFrame:CGRectMake(0, kTopViewHeight, SCREENWIDTH, kMiddleViewHeight) segmentTitleArr:segmentArr backgroundColor:[UIColor whiteColor] titleColor:RGBColor(102, 102, 102) selectTitleColor:RGBColor(0, 149, 68) titleFont:[UIFont systemFontOfSize:14*pro] bottomLineColor:RGBColor(0, 149, 68) isVerticleBar:YES delegate:self];
    }
    return _segmentVeiw;
}

- (CLSHNeighbourhoodMerchantTopView *)topView{
    
    if (!_topView) {
        _topView = [[CLSHNeighbourhoodMerchantTopView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kTopViewHeight)];
    }
    return _topView;
}

- (UITableView *)commentTableView{
    
    if (!_commentTableView) {
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopViewHeight+kMiddleViewHeight, SCREENWIDTH, SCREENHEIGHT-kTopViewHeight-kMiddleViewHeight) style:(UITableViewStylePlain)];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
        _commentTableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    }
    return _commentTableView;
}

- (UITableView *)introduceTableView{
    
    if (!_introduceTableView) {
        _introduceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopViewHeight+kMiddleViewHeight, SCREENWIDTH, SCREENHEIGHT-kTopViewHeight-kMiddleViewHeight) style:(UITableViewStylePlain)];
        _introduceTableView.delegate = self;
        _introduceTableView.dataSource = self;
    }
    return _introduceTableView;
}

-(CLSHNeighborhoodShopCartView *)neighborhoodShopCartView
{
    if (!_neighborhoodShopCartView) {
        //初始化高度
        _neighborhoodShopCartView = [[CLSHNeighborhoodShopCartView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 40*pro)];
    }
    return _neighborhoodShopCartView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self caculatorPrice:saveMerchantGoodsDict];
    [_rightTableView reloadData];
    //给导航条设置一个空的背景图 使其透明化
    [self.navigationController .navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除导航条透明后导航条下的黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSegment];
    [self initTalbeView];
    [self initTopView];
    [self initCommentTableView];
    [self initIntroduceTableView];
    [self initSegment];
    self.isShowCart=YES;
    
    
    leftmodel = [[CLSHNeighborhoodMerchantLeftModel alloc] init];
    rightListModel = [[CLSHNeighborhoodMerchantRightModel alloc] init];
    remarkListModel = [[CLSHNeighborhoodMerchantRemarkListModel alloc] init];
    cLSHHomeProductPraisekModel=[[CLSHHomeProductPraisekModel alloc]init];
    
    [self loadMenuData];
    [self loadCommentData];
    
    self.rightTableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMenuData)];
    _rightTableView.mj_footer.hidden = YES;
    
    self.commentTableView.mj_footer = [KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    _commentTableView.mj_footer.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.view.backgroundColor = backGroundColor;
    
    saveMerchantGoodsDict=[NSMutableDictionary dictionary];
    
    //底部工具栏
    merchantYoolBar = [[CLSHNeighborhoodMerchantToolBar alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    merchantYoolBar.userInteractionEnabled = YES;
    [self.view addSubview:merchantYoolBar];
    
    WS(weakSelf);
    //购物车
    merchantYoolBar.cartblock = ^{
        
        if (saveMerchantGoodsDict.count>0){
            
            if (weakSelf.isShowCart) {
                
                [weakSelf.view addSubview:weakSelf.removeBackViewButton];
                weakSelf.neighborhoodShopCartView.cartDataSourceDict=saveMerchantGoodsDict;
                weakSelf.neighborhoodShopCartView.merchantName = leftmodel.name;
                [weakSelf.view addSubview:weakSelf.neighborhoodShopCartView];
                
                //购物车frame
                weakSelf.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-49-40*pro, SCREENWIDTH, 40*pro);
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    
                    if (saveMerchantGoodsDict.count>6) {
                        
                        weakSelf.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-40*pro-49-50*6*pro, SCREENWIDTH, 40*pro+50*6*pro);
                    }else{
                        weakSelf.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-40*pro-49-50*saveMerchantGoodsDict.count*pro, SCREENWIDTH,40*pro+50*saveMerchantGoodsDict.count*pro);
                    }
                }];
                self.isShowCart=NO;
                
            }else{
                
                [self cancelMerchantShopCart];
                self.isShowCart=YES;
            }
            
            
        }else{
            [MBProgressHUD showError:@"暂时还没商品"];
        }
        
        
    };
    
        //选择好了数量
        merchantYoolBar.selectFinishBlock = ^(){
            if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin) {
                if (saveMerchantGoodsDict.count>0) {
                    
                    [weakSelf createPostDict:saveMerchantGoodsDict];
                    
                    CLSHConfirmOrderVC *confirmOrder = [[CLSHConfirmOrderVC alloc] init];
                    confirmOrder.postArr=[self createPostDict:saveMerchantGoodsDict];
                    confirmOrder.shopId=_shopID;
                    [self.navigationController pushViewController:confirmOrder animated:YES];
                    
                    [UIView animateWithDuration:0.2 animations:^{
                        weakSelf.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-49-40*pro, SCREENWIDTH, 40*pro);
                    }completion:^(BOOL finished) {
                        [weakSelf.neighborhoodShopCartView removeFromSuperview];
                        [weakSelf.removeBackViewButton removeFromSuperview];
                    }];
                    
                }else{
                    [MBProgressHUD showError:@"暂时还没商品"];
                }
            }else
            {
                [MBProgressHUD showError:@"您还没有登录！"];
            }
        };
    
    
    
    //通知改变购物车的大小
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateFrame) name:@"UpdateFrame" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetAllModel) name:@"ResetAllModel" object:nil];
    
}


-(void)updateFrame{
    
    if (saveMerchantGoodsDict.count>6) {
        self.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-40*pro-49-50*6*pro, SCREENWIDTH,40+50*6*pro);
    }else{
        
        
        if (saveMerchantGoodsDict.count==0) {
            [self cancelMerchantShopCart];
        }else{
            self.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-40*pro-49-50*saveMerchantGoodsDict.count*pro, SCREENWIDTH,40*pro+50*saveMerchantGoodsDict.count*pro);
        }
    }
    [self caculatorPrice:saveMerchantGoodsDict];
    [self.rightTableView reloadData];
}

-(void)resetAllModel{
    for ( CLSHNeighborhoodMerchantRightGoodsListModel *model in [saveMerchantGoodsDict allValues]) {
        
        model.selectCounts=0;
        
        
        NSLog(@">>>>>>>>>>>购物车>>>>>>>>>>>%ld",model.selectCounts);
    }
    [self caculatorPrice:saveMerchantGoodsDict];
    //    self.isReset=YES;
    [self.rightTableView reloadData];
}

- (void)loadMenuData{
    
    
    pageNum = 1;
    //左侧导航栏数据加载
    NSMutableDictionary * needsparams = [NSMutableDictionary dictionary];
    needsparams[@"shopId"] =_shopID;
    leftArr = [NSArray array];
    
    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    [leftmodel fetchNeighborhoodMerchantLeftData:needsparams callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            leftmodel = result;
            leftArr = leftmodel.shopCategories;
            self.topView.NeighbourhoodMerchantTopModel = leftmodel;
            if (leftmodel.giftTitle == 0) {
                self.topView.frame = CGRectMake(0, 0, SCREENWIDTH, kTopViewHeight-20*pro);
                self.segmentVeiw.frame = CGRectMake(0, kTopViewHeight-20*pro, SCREENWIDTH, kMiddleViewHeight);
                self.leftTableView.frame = CGRectMake(0, kTopViewHeight+kMiddleViewHeight+1-20*pro, kLeftTableViewWidth,SCREENHEIGHT-kTopViewHeight-kMiddleViewHeight-1-49+20*pro);
                self.rightTableView.frame = CGRectMake(kLeftTableViewWidth, kTopViewHeight+kMiddleViewHeight+1-20*pro, kRightTableViewWidth,SCREENHEIGHT-kTopViewHeight-kMiddleViewHeight-1-49+20*pro);
            }
            [_leftTableView reloadData];
            [self loadFirstRightData];
            NSInteger selectedIndex = 0;
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [_leftTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }];
    
    
    
    //店铺简介
    introduceModel = [[CLSHNeighborhoodMerchantIntroductModel alloc] init];
    NSMutableDictionary * introduceParams = [NSMutableDictionary dictionary];
    introduceParams[@"shopId"] = _shopID;
    [introduceModel fetchNeighborhoodMerchantIntroductData:introduceParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            introduceModel = result;
            [_introduceTableView reloadData];
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
    
}

- (void)loadFirstRightData{

    //右侧默认菜单
    
    rightArr = [NSMutableArray array];
    params = [NSMutableDictionary dictionary];
    
    if (leftArr.count==0) {
        [MBProgressHUD showError:@"该店铺还没有商品!"];
    }else{
        
        
        params[@"shopCategoryId"] = [leftArr[0] leftCategoryID];
        params[@"shopId"] = _shopID;
        params[@"pageSize"]=@(10);
        params[@"pageNumber"]=@(pageNum);
        
        [rightListModel fetchNeighborhoodMerchantRightData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                rightListModel = result;
                
                [rightArr addObjectsFromArray:rightListModel.goodsList];
                [_rightTableView reloadData];
                if (rightListModel.goodsList.count<10)
                {
                    _rightTableView.mj_footer.hidden=YES;
                    [_rightTableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    _rightTableView.mj_footer.hidden=NO;
                    [_rightTableView.mj_footer resetNoMoreData];
                }
                
            }else{
                
                [MBProgressHUD showError:result];
            }
        }];
    }
}

- (void)loadMoreMenuData{
    
    pageNum++;
    params[@"pageNumber"]=@(pageNum);
    [rightListModel fetchNeighborhoodMerchantRightData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            rightListModel = result;
            [rightArr addObjectsFromArray:rightListModel.goodsList];
            [_rightTableView reloadData];
            
            if (rightListModel.goodsList.count<10)
            {
                [_rightTableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [_rightTableView.mj_footer endRefreshing];
            }
            
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
}

- (void)loadCommentData{
    
    //评价列表
    pageNum1 = 1;
    remarkModel = [[CLSHNeighborhoodMerchantRemarkModel alloc] init];
    remarkArr = [NSMutableArray array];
    remarkParams = [NSMutableDictionary dictionary];
    remarkParams[@"shopId"] = _shopID;
    remarkParams[@"pageSize"] = @(10);
    remarkParams[@"pageNumber"] = @(pageNum1);
    
    [remarkModel fetchNeighborhoodMerchantRemarkData:remarkParams callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            remarkModel = result;
            [remarkArr addObjectsFromArray:remarkModel.assessments];
            [_commentTableView reloadData];
            
            if (remarkModel.assessments.count<10)
            {
                _commentTableView.mj_footer.hidden=YES;
                [_commentTableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                _commentTableView.mj_footer.hidden=NO;
                [_commentTableView.mj_footer resetNoMoreData];
            }
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
    
}

- (void)loadMoreComment{
    
    if (pageNum1 < remarkModel.totalPages) {
        pageNum1++;
        remarkParams[@"pageNumber"] = @(pageNum1);
        
        [remarkModel fetchNeighborhoodMerchantRemarkData:remarkParams callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                remarkModel = result;
                [remarkArr addObjectsFromArray:remarkModel.assessments];
                [_commentTableView reloadData];
                if (remarkModel.assessments.count<10)
                {
                    [_commentTableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [_commentTableView.mj_footer endRefreshing];
                }
            }else{
                
//                [MBProgressHUD showError:result];
            }
        }];
    }else
    {
        [_commentTableView.mj_footer endRefreshing];
    }
    
}

- (void)initCommentTableView{
    
    [self.commentTableView registerClass:[CLGSDetailCommentCell class] forCellReuseIdentifier:commentDtailID];
}

- (void)initIntroduceTableView{
    
    self.introduceTableView.backgroundColor = backGroundColor;
    [self.introduceTableView registerNib:[UINib nibWithNibName:@"CLSHIntroduceTableViewCell" bundle:nil] forCellReuseIdentifier:introduceID];
    [self.introduceTableView registerNib:[UINib nibWithNibName:@"CLSHIntroduceWebViewTableViewCell" bundle:nil] forCellReuseIdentifier:introduceID2];
}

- (void)initTopView{
    
    [self.view addSubview:self.topView];
}

-(void)initSegment{
    
    segmentArr = @[@"商品",@"评价",@"简介"];
    [self.view addSubview:self.segmentVeiw];
}

-(void)initTalbeView{
    SelectRow =0;
    [_leftTableView registerClass:[CLSHNeightbourhoodShopLeftCell class] forCellReuseIdentifier:leftID];
    [_rightTableView registerClass:[CLSHNeightbourhoodShopRightCell class] forCellReuseIdentifier:rightID];
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
}

#pragma mark - 移除图层
- (void)cancelMerchantShopCart
{
    self.isShowCart=YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.neighborhoodShopCartView.frame=CGRectMake(0, SCREENHEIGHT-49-40*pro, SCREENWIDTH, SCREENHEIGHT-300*pro);
    }completion:^(BOOL finished) {
        [self.neighborhoodShopCartView removeFromSuperview];
        [self.removeBackViewButton removeFromSuperview];
        [self.rightTableView reloadData];
    }];
}

#pragma mark table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == _leftTableView) {
        return 1;
    }else if(tableView == _introduceTableView){
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _introduceTableView) {
        return 1;
    }else if (tableView == _leftTableView){
        
        return leftArr.count;
    }else if (tableView == _rightTableView){
        
        return rightArr.count;
    }else if (tableView == _commentTableView){
        
        return remarkArr.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTableView) {
        return 44*pro;
    }else if(tableView == _rightTableView){
        
        return 80*pro;
    }else if(tableView == _commentTableView){
        
        remarkListModel = remarkArr[indexPath.row];
        CGSize size = [NSString sizeWithStr:remarkListModel.content font:[UIFont systemFontOfSize:12*pro] width:SCREENWIDTH-20*pro];
        if (remarkListModel.image.count == 0) {
            return 80*pro + size.height*pro;
        }else
        {
            return 80*pro + size.height*pro + (SCREENWIDTH-50*pro)/4 + 10*pro;
        }
    }else if(tableView == _introduceTableView){
        
        if (indexPath.section == 0) {
            return 135;
        }
        return 200;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHNeightbourhoodShopLeftCell * leftCell = [tableView dequeueReusableCellWithIdentifier:leftID];
    CLSHNeightbourhoodShopRightCell * rightCell = [tableView dequeueReusableCellWithIdentifier:rightID];
    rightCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLGSDetailCommentCell * detaiCommentCell = [tableView dequeueReusableCellWithIdentifier:commentDtailID];
    detaiCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLSHIntroduceTableViewCell * introduceCell = [tableView dequeueReusableCellWithIdentifier:introduceID];
    introduceCell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLSHIntroduceWebViewTableViewCell * introduceWebViewCell = [tableView dequeueReusableCellWithIdentifier:introduceID2];
    if (tableView == _leftTableView) {
        if (!leftCell) {
            leftCell = [[CLSHNeightbourhoodShopLeftCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:leftID];
        }
        leftCell.selectionStyle = UITableViewCellSelectionStyleGray;
        leftListModel = [[CLSHNeighborhoodMerchantLeftCategoryListModel alloc] init];
        leftListModel = leftArr[indexPath.row];
        leftCell.NeighborhoodMerchantLeftCategoryListModel = leftListModel;
        return leftCell;
    }else if(tableView == _rightTableView){
        if (!rightCell) {
            rightCell = [[CLSHNeightbourhoodShopRightCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:rightID];
        }
        rightCell.selectionStyle = UITableViewCellSelectionStyleNone;
        rightGoodsListModel = [[CLSHNeighborhoodMerchantRightGoodsListModel alloc] init];
        rightGoodsListModel = rightArr[indexPath.row];
        if (rightGoodsListModel.deliveryFee == 0) {
            merchantYoolBar.deliveryPrice.text = @"免配送费";
        }else
        {
            merchantYoolBar.deliveryPrice.text = [NSString stringWithFormat:@"配送费%.f元", rightGoodsListModel.deliveryFee];
        }
        //选择规格
        WS(weakSelf);
        //        rightCell.selectSpecificationBlock = ^(){
        //            CLSHNeighbourhoodMerchantDetailVC * MerchantDetailVC = [[CLSHNeighbourhoodMerchantDetailVC alloc] init];
        //            rightGoodsListModel = rightArr[indexPath.row];
        //            MerchantDetailVC.goodsId =rightGoodsListModel.goodsId;
        //            [weakSelf.navigationController pushViewController:MerchantDetailVC animated:YES];
        //        };
        
        rightCell.model = rightGoodsListModel;
        if (self.isReset) {
            rightCell.isReset=YES;
        }else{
            rightCell.isReset=NO;
        }
        rightCell.delegate=self;
        return rightCell;
    }else if(tableView == _commentTableView){
        
        if (!detaiCommentCell) {
            detaiCommentCell = [[CLGSDetailCommentCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:commentDtailID];
        }
        detaiCommentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        __weak __typeof(&*detaiCommentCell)weakSelf = detaiCommentCell;
        detaiCommentCell.model = remarkArr[indexPath.row];
        detaiCommentCell.praiseblock = ^(){
            
            NSMutableDictionary *needsparams=[NSMutableDictionary dictionary];
            remarkListModel = remarkArr[indexPath.row];
            if (remarkListModel.supportCount == 1) {
                [MBProgressHUD showError:@"已经点过赞了！"];
            }else
            {
                needsparams[@"assessmentId"]=@(remarkListModel.remarkId);
                [cLSHHomeProductPraisekModel fetchHomeDetailPraiseData:needsparams callBack:^(BOOL isSuccess, id result) {
                    if (isSuccess) {
                        cLSHHomeProductPraisekModel = result;
                        [self loadCommentData];
                        [weakSelf.praiseButton setImage:[UIImage imageNamed:@"Praise_select"] forState:UIControlStateNormal];
                        [MBProgressHUD showSuccess:@"点赞成功！"];
                    }else{
                        
                        [MBProgressHUD showError:@"点赞失败！"];
                    }
                }];
            }
            
            
        };
        return detaiCommentCell;
    }else{
        
        if (indexPath.section == 0) {
            if (!introduceCell) {
                introduceCell = [[CLSHIntroduceTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:introduceID];
            }
            introduceCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            introduceCell.model = introduceModel;
            
            introduceCell.callblock = ^(){
                
                UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"联系商家" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
                UIAlertAction * action1 = [UIAlertAction actionWithTitle:introduceModel.phoneNumber style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",introduceModel.phoneNumber]]];
                }];
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                [alertVC addAction:action1];
                [alertVC addAction:action2];
                [self presentViewController:alertVC animated:YES completion:nil];
                
            };
            
            introduceCell.navigationblock =^(){
                
                CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake(_latitude,_longitude);
                CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(introduceModel.latitude,introduceModel.longitude);
                
                UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"选择地图导航" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
                UIAlertAction * Action1 = [[UIAlertAction alloc] init];
                UIAlertAction * Action2 = [[UIAlertAction alloc] init];
                UIAlertAction * Action3 = [[UIAlertAction alloc] init];
                UIAlertAction * Action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                NSLog(@"%@",[self checkHasOwnApp].mj_JSONData);
                
                Action1 = [UIAlertAction actionWithTitle:@"苹果原生地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:startCoor addressDictionary:nil]];
                    currentLocation.name = @"我的位置";
                    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
                    toLocation.name = introduceModel.name;
                    
                    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
                    NSDictionary *options = @{
                                              MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                              MKLaunchOptionsMapTypeKey:
                                                  [NSNumber numberWithInteger:MKMapTypeStandard],
                                              MKLaunchOptionsShowsTrafficKey:@YES
                                              };
                    
                    //打开苹果自身地图应用
                    [MKMapItem openMapsWithItems:items launchOptions:options];
                    
                }];
                if([self checkHasOwnApp].count == 2){
                    
                    if ([[self checkHasOwnApp][1] isEqualToString:@"高德地图"]) {
                        Action2 = [UIAlertAction actionWithTitle:@"高德地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                            
                            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",_latitude,_longitude,@"我的位置",introduceModel.latitude,introduceModel.longitude,introduceModel.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            NSURL *Amap = [NSURL URLWithString:urlString];
                            [[UIApplication sharedApplication] openURL:Amap];
                        }];
                        
                        
                    }else{
                        
                        Action2 = [UIAlertAction actionWithTitle:@"百度地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                            
                            NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",_latitude,_longitude,introduceModel.latitude,introduceModel.longitude];
                            NSURL *url = [NSURL URLWithString:stringURL];
                            [[UIApplication sharedApplication] openURL:url];
                        }];
                        
                    }
                }else if ([self checkHasOwnApp].count == 3){
                    
                    if ([[self checkHasOwnApp][2] isEqualToString:@"高德地图"]){
                        
                        Action3 = [UIAlertAction actionWithTitle:@"高德地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                            
                            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",_latitude,_longitude,@"我的位置",introduceModel.latitude,introduceModel.longitude,introduceModel.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            NSURL *Amap = [NSURL URLWithString:urlString];
                            [[UIApplication sharedApplication] openURL:Amap];
                        }];
                        
                        Action2 = [UIAlertAction actionWithTitle:@"百度地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                            
                            NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",_latitude,_longitude,introduceModel.latitude,introduceModel.longitude];
                            NSURL *url = [NSURL URLWithString:stringURL];
                            [[UIApplication sharedApplication] openURL:url];
                        }];
                        
                    }else{
                        
                        Action3 = [UIAlertAction actionWithTitle:@"百度地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                            NSString *stringURL = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&&mode=driving",_latitude,_longitude,introduceModel.latitude,introduceModel.longitude];
                            NSURL *url = [NSURL URLWithString:stringURL];
                            [[UIApplication sharedApplication] openURL:url];
                        }];
                        
                        Action2 = [UIAlertAction actionWithTitle:@"高德地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action){
                            
                            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",_latitude,_longitude,@"我的位置",introduceModel.latitude,introduceModel.longitude,introduceModel.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            NSURL *Amap = [NSURL URLWithString:urlString];
                            [[UIApplication sharedApplication] openURL:Amap];
                        }];
                    }
                }
                
                if ([self checkHasOwnApp].count == 1) {
                    
                    [alertVC addAction:Action1];
                    [alertVC addAction:Action4];
                }else if ([self checkHasOwnApp].count == 2){
                    
                    [alertVC addAction:Action4];
                    [alertVC addAction:Action1];
                    [alertVC addAction:Action2];
                }else if ([self checkHasOwnApp].count == 3){
                    
                    [alertVC addAction:Action4];
                    [alertVC addAction:Action1];
                    [alertVC addAction:Action2];
                    [alertVC addAction:Action3];
                }
                
                [self presentViewController:alertVC animated:YES completion:nil];
            };
            
            
            return introduceCell;
        }else{
            if (!introduceWebViewCell) {
                introduceWebViewCell = [[CLSHIntroduceWebViewTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:introduceID2];
            }
            introduceWebViewCell.model = introduceModel;
            
            
            return introduceWebViewCell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == _leftTableView) {
        
        if (SelectRow == indexPath.row) {
            
            //不刷新右侧UI
            return;
        }
        
        //点击改变左侧线的颜色
        CLSHNeightbourhoodShopLeftCell * leftCell = [_leftTableView cellForRowAtIndexPath:indexPath];
        leftCell.indicatorLine.backgroundColor = systemColor;
        
        SelectRow = (NSInteger)indexPath.row;
        // NSMutableDictionary * params = [NSMutableDictionary dictionary];
        
        // [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        leftListModel = leftArr[indexPath.row];
        params[@"shopCategoryId"] = leftListModel.leftCategoryID;
        params[@"shopId"] = _shopID;
        params[@"pageSize"]=@(10);
        params[@"pageNumber"]=@(1);
        [rightArr removeAllObjects];
        [MBProgressHUD showMessage:@"加载中..." toView:self.view];
        [rightListModel fetchNeighborhoodMerchantRightData:params callBack:^(BOOL isSuccess, id result) {
            
            if (isSuccess) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                rightListModel = result;
                [rightArr addObjectsFromArray:rightListModel.goodsList];
                [_rightTableView reloadData];
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                sleep(1);
                [MBProgressHUD showError:result];
            }
        }];
    }
    
    //点击rightTableViewCell 跳转商品详情
    if (tableView == _rightTableView) {
        CLSHNeighbourhoodMerchantDetailVC * MerchantDetailVC = [[CLSHNeighbourhoodMerchantDetailVC alloc] init];
        rightGoodsListModel = rightArr[indexPath.row];
        MerchantDetailVC.goodsId =rightGoodsListModel.goodsId;
        MerchantDetailVC.cartModel=rightGoodsListModel;
        MerchantDetailVC.saveShopDict=saveMerchantGoodsDict;
        MerchantDetailVC.shopId=_shopID;
        MerchantDetailVC.shopCartMerchantName = leftmodel.name;
        MerchantDetailVC.hasMoreProduct = rightGoodsListModel.hasMoreProduct;
        [self.navigationController pushViewController:MerchantDetailVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _leftTableView) {
        
        //改回颜色
        CLSHNeightbourhoodShopLeftCell * leftCell = [_leftTableView cellForRowAtIndexPath:indexPath];
        leftCell.indicatorLine.backgroundColor = backGroundColor;
    }
    
}

#pragma mark KBsegment delegate
-(void)selectSegment:(NSInteger)index{
    
    switch (index) {
        case 0:
            [self.view addSubview:self.leftTableView];
            [self.view addSubview:self.rightTableView];
            //刷新数据源
            //[self.rightTableView reloadData];
            [_commentTableView removeFromSuperview];
            [_introduceTableView removeFromSuperview];
            break;
        case 1:
            [self.view addSubview:self.commentTableView];
            //[self addselectView];
            //[_commentTableView reloadData];
            [_leftTableView removeFromSuperview];
            [_rightTableView removeFromSuperview];
            [_introduceTableView removeFromSuperview];
            break;
        case 2:
            [self.view addSubview:self.introduceTableView];
            
            //[_introduceTableView reloadData];
            [_leftTableView removeFromSuperview];
            [_rightTableView removeFromSuperview];
            [_commentTableView removeFromSuperview];
            break;
        default:
            break;
    }
    
}


- (void)addselectView{
    
    CommentArray  = @[@"全部(60)",@"好评(60)",@"中评(0)",@"差评(0)"];
    
    CircleSegment = [KBCircleSegmentView createCircleSegmentFrame:CGRectMake(0, kTopViewHeight+kMiddleViewHeight, SCREENWIDTH, 40*pro) titleArr:CommentArray titleColor:[UIColor blackColor] selectTitleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:12*pro] unselectIcon:nil selectIcon:nil backgroundColor:[UIColor whiteColor] delegate:self];
    [self.view addSubview:CircleSegment];
}

#pragma mark KBCircleSegmentView delegate
-(void)selectCircleSegment:(NSInteger)index{
    
    switch (index) {
        case 0:
            NSLog(@"00000");
            [_commentTableView reloadData];
            break;
        case 1:
            NSLog(@"11111");
            [_commentTableView reloadData];
            break;
        case 2:
            NSLog(@"22222");
            [_commentTableView reloadData];
            break;
        case 3:
            NSLog(@"33333");
            [_commentTableView reloadData];
            break;
            
        default:
            break;
    }
}


//设置tableView分割线从顶端开始 适配ios7和ios8
- (void)viewDidLayoutSubviews{
    
    if ([_leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_leftTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_leftTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark <NeightbourhoodShopRightCellDelegate>
-(void)addMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{
    
    //    CLSHNeighborhoodMerchantRightGoodsListProductsModel *product=mode;
    saveMerchantGoodsDict[model.goodsId]=model;
    [self caculatorPrice:saveMerchantGoodsDict];
    [self.rightTableView reloadData];
}

-(void)deleteMerchantGoods:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{
    [saveMerchantGoodsDict removeObjectForKey:model.goodsId];
    [self caculatorPrice:saveMerchantGoodsDict];
    [self.rightTableView reloadData];
}

//new cart
-(void)addMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model{
    saveMerchantGoodsDict[model.productsId]=model;
    [self caculatorPrice:saveMerchantGoodsDict];
    [self.rightTableView reloadData];
}

-(void)deleteMerchantProductModel:(CLSHNeighborhoodMerchantRightGoodsListProductsModel *)model{
    [saveMerchantGoodsDict removeObjectForKey:model.productsId];
    [self caculatorPrice:saveMerchantGoodsDict];
    [self.rightTableView reloadData];
}


//提交订单的数组计算
-(NSArray *)createPostDict:(NSMutableDictionary *)dict{
    NSMutableArray *postArray=[NSMutableArray array];
    //    for (CLSHNeighborhoodMerchantRightGoodsListModel *model in [dict allValues]) {
    //
    //        NSMutableDictionary *tempMutalbeDict=[NSMutableDictionary dictionary];
    //        tempMutalbeDict[@"quantity"]=@(model.selectCounts);
    //        //修改
    //        tempMutalbeDict[@"productId"]=model.defaultProductId;
    //        [postArray addObject:tempMutalbeDict];
    //    }
    
    
    for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *model in [dict allValues]) {
        NSMutableDictionary *tempMutalbeDict=[NSMutableDictionary dictionary];
        tempMutalbeDict[@"quantity"]=@(model.selectCounts);
        //修改
        tempMutalbeDict[@"productId"]=model.productsId;
        [postArray addObject:tempMutalbeDict];
        
    }
    
    return postArray;
}

//计算价格
-(void)caculatorPrice:(NSMutableDictionary *)dict{
    self.totalPrice=0.0;
    self.totalAmount=0;
    
    //    for (CLSHNeighborhoodMerchantRightGoodsListModel *model in [dict allValues]) {
    //        self.totalPrice+=model.selectCounts * model.price;
    //        self.totalAmount+=model.selectCounts;
    //    }
    
    
    for (CLSHNeighborhoodMerchantRightGoodsListProductsModel *model in [dict allValues]) {
        self.totalPrice+=model.selectCounts * model.price;
        self.totalAmount+=model.selectCounts;
    }
    
    NSLog(@">>>>>>>>总数量%ld,总价格%lf",self.totalAmount,self.totalPrice);
    merchantYoolBar.cart.dot.text=[NSString stringWithFormat:@"%ld",self.totalAmount];
    NSString *totalPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:self.totalPrice]];
    merchantYoolBar.totalPrice.text = totalPriceStr; 
}


-(void)setShopID:(NSString *)shopID{
    _shopID=shopID;
}


//判断手机上有哪些地图app
-(NSArray *)checkHasOwnApp{
    NSArray *mapSchemeArr = @[@"iosamap://navi",@"baidumap://map/"];
    
    NSMutableArray *appListArr = [[NSMutableArray alloc] initWithObjects:@"苹果原生地图", nil];
    
    for (int i = 0; i < [mapSchemeArr count]; i++) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[mapSchemeArr objectAtIndex:i]]]]) {
            if (i == 0) {
                [appListArr addObject:@"高德地图"];
            }else if (i == 1){
                [appListArr addObject:@"百度地图"];
            }
        }
    }
    
    return appListArr;
}



@end
