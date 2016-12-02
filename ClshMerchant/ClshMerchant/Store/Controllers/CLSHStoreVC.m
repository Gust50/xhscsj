//
//  CLSHStoreVC.m
//  ClshMerchant
//
//  Created by kobe on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHStoreVC.h"
#import "CLSHStoreSetupCell.h"
#import "CLSHStoreDescribeCell.h"
#import "CLSHStoreSwitchBtnCell.h"
#import "CLSHStoreSwitchCell.h"
#import "CLSHStoreTimeCell.h"
#import "CLSHStoreDeliveryCell.h"
#import "CLSHMyBankCartVC.h"
#import "CLSHPersonalSettingViewController.h"
#import "CLSHLoginViewController.h"
#import "CLSHSetupMyNickNameVC.h"
#import "CLSHStoreIntroduceViewController.h"
#import "CLSHStoreModel.h"
#import "CLSHStoreUpdateModel.h"
#import "CLSHStoreAddressVC.h"
#import "AppDelegate.h"

//@2
#import "CLSHShareMoneyVC.h"///我的推广（分享赚钱）

@interface CLSHStoreVC ()<UITableViewDelegate,UITableViewDataSource,CLSHStoreDeliveryCellDelegate>
{
    CLSHStoreModel *storeModel;                                 ///<店铺管理数据模型
    CLSHStoreUpdateCloseStateModel *updateCloseStateModel;      ///<营业状态数据模型
    CLSHAcountupdateSupportDeliveryModel *supportDeliveryModel; ///<修改配送方式
    CLSHAcountUpdateIsJoinPromotionModel *isJoinPromotionModel; ///<是否参加折扣活动
    
    BOOL isOpen;                                                ///<判断是否营业
    BOOL isJoinPromotion;                                       ///<判断是否参加折扣
    NSMutableDictionary *deliveryParams;                        ///<传入配送方式后参数
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CLSHStoreVC
static NSString * const setupCellID= @"setupCellID";
static NSString * const describeCellID = @"describeCellID";
static NSString * const switchBtnCellID = @"switchBtnCellID";
static NSString * const switchCellID = @"switchCellID";
static NSString * const timeCellID = @"timeCellID";
static NSString * const deliveryCellID = @"deliveryCellID";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-49-64) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.showsVerticalScrollIndicator=NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=backGroundColor;
    self.navigationItem.title=@"店铺管理";
     self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.tableView];
   
    updateCloseStateModel = [[CLSHStoreUpdateCloseStateModel alloc] init];
    supportDeliveryModel = [[CLSHAcountupdateSupportDeliveryModel alloc] init];
    deliveryParams = [NSMutableDictionary dictionary];
    isJoinPromotionModel = [[CLSHAcountUpdateIsJoinPromotionModel alloc] init];
    
    [_tableView registerClass:[CLSHStoreSetupCell class] forCellReuseIdentifier:setupCellID];
    [_tableView registerClass:[CLSHStoreDescribeCell class] forCellReuseIdentifier:describeCellID];
    [_tableView registerClass:[CLSHStoreSwitchBtnCell class] forCellReuseIdentifier:switchBtnCellID];
    [_tableView registerClass:[CLSHStoreSwitchCell class] forCellReuseIdentifier:switchCellID];
    [_tableView registerClass:[CLSHStoreTimeCell class] forCellReuseIdentifier:timeCellID];
    [_tableView registerClass:[CLSHStoreDeliveryCell class] forCellReuseIdentifier:deliveryCellID];
}

#pragma mark - loadData
//店铺首页
- (void)loadData
{
    storeModel = [[CLSHStoreModel alloc] init];
    [storeModel fetchStoreData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            storeModel = result;
            isJoinPromotion = storeModel.modelMap.isJoinPromotion;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//修改营业状态
- (void)updateStateData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"shopId"] = storeModel.modelMap.shopId;
    if (isOpen) {
        params[@"isClose"] = @"false";
    }else
    {
        params[@"isClose"] = @"true";
    }
    [updateCloseStateModel fetchStoreUpdateCloseStateData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//商家折扣
- (void)merchantDiscount
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"shopId"] = storeModel.modelMap.shopId;
    if (isJoinPromotion) {
        params[@"isJoinPromotion"] = @"true";
    }else
    {
        params[@"isJoinPromotion"] = @"false";
    }
    [isJoinPromotionModel fetchAcountUpdateIsJoinPromotionData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//配送方式
- (void)updateSupportDelivery
{
    [supportDeliveryModel fetchAcountUpdateSupportDeliveryData:deliveryParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self loadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //RGBColor(0, 149, 68)
    
    [self hideNavBlackLine];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(255, 255, 255) colorWithAlphaComponent:1]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGBColor(51, 51, 51)};
    
    [self loadData];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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

#pragma mark <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
//        return 8;
        return 7;
    }else if (section==2){
//        return 2;
        return 3;
    }
    return 0;
};

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
         CLSHStoreSetupCell *setupCell=[tableView dequeueReusableCellWithIdentifier:setupCellID forIndexPath:indexPath];
        setupCell.selectionStyle = UITableViewCellSelectionStyleNone;
        setupCell.nickNameContent=storeModel.modelMap.name;
        setupCell.phoneContent=storeModel.modelMap.phone;
        setupCell.iconUrl=storeModel.modelMap.avatar;
        return setupCell;
    }else if (indexPath.section==1){
        
        switch (indexPath.row) {
            case 0:
            {
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                describeCell.titleContent=@"店铺名称";
                describeCell.describeContent=storeModel.modelMap.name;
                describeCell.iconUrl=@"shopName";
                return describeCell;
            }
            case 1:
            {
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                describeCell.titleContent=@"店铺地址";
                describeCell.describeContent=storeModel.modelMap.address1;
                describeCell.iconUrl=@"shopAddress";
                return describeCell;
            }
            case 2:
            {
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                describeCell.titleContent=@"联系电话";
                describeCell.describeContent=storeModel.modelMap.phoneNumber;
                describeCell.iconUrl=@"phone";
                return describeCell;
            }
                
            case 3:
            {
                CLSHStoreSwitchBtnCell *switchBtnCell=[tableView dequeueReusableCellWithIdentifier:switchBtnCellID forIndexPath:indexPath];
                switchBtnCell.selectionStyle = UITableViewCellSelectionStyleNone;
                switchBtnCell.shopState=@"营业状态";
                switchBtnCell.iconUrl=@"shopState";
                switchBtnCell.model = storeModel.modelMap;
                switchBtnCell.selectOpenBlock = ^(BOOL isBusiness){
                    isOpen = isBusiness;
                    [self updateStateData];
                    
                };
                return switchBtnCell;
            }
                break;
//            case 4:
//            {
//                CLSHStoreTimeCell *timeCell=[tableView dequeueReusableCellWithIdentifier:timeCellID forIndexPath:indexPath];
//                timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                timeCell.startContent=storeModel.modelMap.dailyOpenTime;
//                timeCell.endContent=storeModel.modelMap.dailyClosedTime;
//                timeCell.iconUrl=@"shopTime";
//                timeCell.titleContent=@"营业时间";
//                return timeCell;
//            }
//                break;
            case 4:
            {
                CLSHStoreDeliveryCell *deliveryCell = [tableView dequeueReusableCellWithIdentifier:deliveryCellID forIndexPath:indexPath];
                deliveryCell.selectionStyle = UITableViewCellSelectionStyleNone;
                deliveryCell.titleContent=@"配送方式";
                deliveryCell.delegate=self;
                deliveryCell.iconUrl=@"delivery";
                if (storeModel.modelMap.isSupportSelfPickUp) {
                    deliveryCell.isSupportSelfPickUp=YES;
                }else{
                    deliveryCell.isSupportSelfPickUp=NO;
                }
                
                
                if (storeModel.modelMap.isSupportDelivery) {
                    deliveryCell.isSupportDelivery=YES;
                }else{
                    deliveryCell.isSupportDelivery=NO;
                }
                return deliveryCell;
            }
            case 5:
            {
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                describeCell.titleContent=@"店铺简介";
                describeCell.describeContent=storeModel.modelMap.introduction;
                describeCell.iconUrl=@"introduce";
                return describeCell;
            }
            case 6:
            {
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                describeCell.titleContent=@"商家广告语";
                describeCell.describeContent=storeModel.modelMap.adMessage;
                describeCell.iconUrl=@"advertise";
                return describeCell;
            }
                
//                //推广专区
//            case 8:{
//                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
//                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                describeCell.titleContent=@"推广专区";
//                //图片的名字要改
//                describeCell.iconUrl=@"advertise";
//                describeCell.imageView.image = nil;
//                return describeCell;
// 
//            }
//                break;
            default:
            {
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return describeCell;
            }
                break;
        }
        
    }else{
        
        switch (indexPath.row) {
            case 0:
            {
                CLSHStoreSwitchCell *switchCell=[tableView dequeueReusableCellWithIdentifier:switchCellID forIndexPath:indexPath];
                switchCell.selectionStyle = UITableViewCellSelectionStyleNone;
                switchCell.iconUrl=@"discount";
                switchCell.titleContent=@"商家折扣";
                switchCell.discountLabel.text = storeModel.modelMap.isJoinPromotion;
                return switchCell;
            }
                break;
            case 1:
            {
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                describeCell.titleContent=@"我的银行卡";
                describeCell.describeContent=[NSString stringWithFormat:@"%zi张", storeModel.modelMap.bankAccounts];
                describeCell.iconUrl=@"card";

                return describeCell;
            }
                break;
                
                //推广专区
            case 2:{
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                describeCell.titleContent=@"分享赚钱";
                //图片的名字要改
                describeCell.iconUrl=@"shareMoney";
                describeCell.imageView.image = nil;
                return describeCell;
                
            }
                break;

            default:
            {
                CLSHStoreDescribeCell *describeCell=[tableView dequeueReusableCellWithIdentifier:describeCellID forIndexPath:indexPath];
                describeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                return describeCell;
            }
                break;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        CLSHPersonalSettingViewController * personalSettingVC = [[CLSHPersonalSettingViewController alloc] init];
        [self.navigationController pushViewController:personalSettingVC animated:YES];
        
    }else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:{
                CLSHSetupMyNickNameVC * StoreNameVC = [[CLSHSetupMyNickNameVC alloc] init];
                StoreNameVC.isStoreName = YES;
                StoreNameVC.storeName = @"小二黑妹来了";
                StoreNameVC.titleString = @"店铺名称";
                StoreNameVC.storeName = storeModel.modelMap.name;
                StoreNameVC.shopId = storeModel.modelMap.shopId;
                [self.navigationController pushViewController:StoreNameVC animated:YES];
            }
                break;
            case 1:{
//                CLSHLoginViewController * loginVC = [[CLSHLoginViewController alloc] init];
//                [self presentViewController:loginVC animated:YES completion:nil];
                
                CLSHStoreAddressVC *storeAddressVC = [[CLSHStoreAddressVC alloc] init];
                storeAddressVC.address1 = storeModel.modelMap.address1;
                storeAddressVC.address = storeModel.modelMap.address;
                [self.navigationController pushViewController:storeAddressVC animated:YES];
            }
                break;
            case 2:{
            
                CLSHSetupMyNickNameVC * storeTelVC = [[CLSHSetupMyNickNameVC alloc] init];
                storeTelVC.isStoreTel = YES;
                storeTelVC.storeTel = storeModel.modelMap.phoneNumber;
                storeTelVC.titleString = @"联系电话";
                storeTelVC.shopId = storeModel.modelMap.shopId;
                [self.navigationController pushViewController:storeTelVC animated:YES];
            }
                break;
            case 5:{
                CLSHStoreIntroduceViewController * storeIntroduceVC = [[CLSHStoreIntroduceViewController alloc] init];
                storeIntroduceVC.intro = storeModel.modelMap.introduction;
                storeIntroduceVC.shopId = storeModel.modelMap.shopId;
                [self.navigationController pushViewController:storeIntroduceVC animated:YES];
            }
                break;
            case 6:{
                
                CLSHSetupMyNickNameVC * StoreNameVC = [[CLSHSetupMyNickNameVC alloc] init];
                StoreNameVC.isStoreADV = YES;
                StoreNameVC.storeADV = storeModel.modelMap.adMessage;
                StoreNameVC.titleString = @"商家广告语";
                StoreNameVC.shopId = storeModel.modelMap.shopId;
                [self.navigationController pushViewController:StoreNameVC animated:YES];
            }
                break;
//            case 8:{
//                //跳转要换
//                CLSHShareMoneyVC *shareMoneyVC = [[CLSHShareMoneyVC alloc] init];
//                [self.navigationController pushViewController:shareMoneyVC animated:YES];
//
//            }
//                break;
//  
                
                
            default:
                break;
        }
        
    }else{
        switch (indexPath.row) {
            case 0:
            {
               
            }
                break;
            case 1:
            {
                CLSHMyBankCartVC *myBankVC = [[CLSHMyBankCartVC alloc] init];
                myBankVC.name = @"个人中心";
                [self.navigationController pushViewController:myBankVC animated:YES];
            }
                break;
                
            case 2:{
                //跳转要换
                CLSHShareMoneyVC *shareMoneyVC = [[CLSHShareMoneyVC alloc] init];
                [self.navigationController pushViewController:shareMoneyVC animated:YES];
                
            }
                break;
                

            default:
                break;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 80*AppScale;
    }
    return 44.0*AppScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }
    return 10*AppScale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }
    return 10*AppScale;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0) {
//        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    }else{
//        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    }
}
//商家折扣
#pragma mark <CLSHStoreSwitchCellDelegate>
-(void)clickSwitch:(BOOL)isUse{
 
    isJoinPromotion = isUse;
    [self merchantDiscount];
}
//配送方式
#pragma mark <CLSHStoreDeliveryCellDelegate>
-(void)chooseDelivery:(BOOL)delivery take:(BOOL)take{
    
    if (delivery && take) {
        deliveryParams[@"isSupportDelivery"] = @"true";
        deliveryParams[@"isSupportSelfPickUp"] = @"true";
    }else if (delivery && !take)
    {
        deliveryParams[@"isSupportDelivery"] = @"true";
        deliveryParams[@"isSupportSelfPickUp"] = @"false";
    }else if (!delivery && take)
    {
        deliveryParams[@"isSupportDelivery"] = @"false";
        deliveryParams[@"isSupportSelfPickUp"] = @"true";
    }
    [self updateSupportDelivery];
}
@end
