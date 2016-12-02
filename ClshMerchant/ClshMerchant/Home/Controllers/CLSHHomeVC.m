//
//  CLSHHomeVC.m
//  ClshMerchant
//
//  Created by arom on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHHomeVC.h"
#import "CLSHHomeTopViewCell.h"
#import "CLSHHomeBottomViewCell.h"
#import "CLSHHomePublishHeader.h"
#import "CLGSAccountBalanceViewController.h"
#import "CLSHApplicationWithDrawalsVC.h"
#import "CLSHDataStatisticVC.h"
#import "CLSHAdvertiseManagementVC.h"
#import "CLSHCategoryManagementVC.h"
#import "CLSHOrderManagerViewController.h"
#import "CLSHMerchantJoinProcessVC.h"
#import "CLSHUpLoadGoodsVC.h"
#import "CLSHManagerGoodsVC.h"
#import "CLSHHomeModel.h"
#import "CLSHMoneyManagerViewController.h"
#import "AppDelegate.h"
#import "CLSHDiscountView.h"
#import "CLSHStoreModel.h"
#import "CLSHLoginViewController.h"

//@2
#import "CLSHCertificationVC.h"
#import "CLSMerchantJoinSuccessVC.h"
#import "CLSHMerchantJoinModel.h"

//@@
#import "CLSHLoginModel.h"
#import "CLSHOrderDetailViewController.h"




@interface CLSHHomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CLSHHomePublishHeaderDelegate,CLSHHomeTopViewCellDelegate>
{
    CLSHHomeModel *cLSHHomeModel;
    MBProgressHUD *hud;
    
    
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *iconArr;
@property (nonatomic, strong) NSArray *nameArr;

@end

@implementation CLSHHomeVC
static NSString * const topViewCellId = @"topViewCellId";
static NSString * const bottomViewCellId=@"bottomViewCellId";
static NSString * const publishHeaderCellId=@"publishHeaderCellId";

#pragma mark <lazyLoad>

-(NSArray *)iconArr{
    if (!_iconArr) {
        _iconArr=@[@"GoodManager",@"OrderManager",@"CategoryManager",@"DataTotal",@"Advertise",@"FundManager"];
    }
    return _iconArr;
}

-(NSArray *)nameArr{
    if (!_nameArr) {
        _nameArr=@[@"商品管理",@"订单管理",@"类别管理",@"数据统计",@"群发广告",@"资金管理"];
    }
    return _nameArr;
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor=backGroundColor;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
    }
    return _collectionView;
}


#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.navigationItem.title=@"首页";
    [_collectionView registerClass:[CLSHHomeTopViewCell class] forCellWithReuseIdentifier:topViewCellId];
    [_collectionView registerClass:[CLSHHomeBottomViewCell class] forCellWithReuseIdentifier:bottomViewCellId];
    [_collectionView registerClass:[CLSHHomePublishHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:publishHeaderCellId];
    
    [self initModelData];
    [self initDiscountView];
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.backgroundColor=[UIColor clearColor];
    hud.color=[UIColor clearColor];
//    hud.activityIndicatorColor=systemColor;
    
    //jpush notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OrderDetailAction:) name:@"toOrderDetail" object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark -- notification -- 订单详情
- (void)OrderDetailAction:(NSNotification *)notification{

     NSDictionary * dict = notification.userInfo;
    CLSHOrderDetailViewController * orderDetailVC = [CLSHOrderDetailViewController new];
    orderDetailVC.sn = [dict valueForKey:@"sn"];
    orderDetailVC.isPayed = YES;
    [self.navigationController pushViewController:orderDetailVC animated:YES];

}

#pragma mark -- 时候绑定折扣
- (void)initDiscountView{
    //应陶薏光要求
//    NSLog(@"--------%d",[FetchAppPublicKeyModel shareAppPublicKeyManager].isFlat);
//    if ( ![FetchAppPublicKeyModel shareAppPublicKeyManager].isFlat) {
//        
//        CLSHDiscountView * v = [[CLSHDiscountView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//        v.showDiscountblock = ^(){
//            [v removeFromSuperview];
//            [MBProgressHUD showSuccess:@"提交成功"];
//        };
//        [ShareApp.window addSubview:v];
//    }

//    if (![FetchAppPublicKeyModel shareAppPublicKeyManager].isPinless) {
//        
//        if (![FetchAppPublicKeyModel shareAppPublicKeyManager].isFlat) {
//            
//            [[MBProgressHUD showMessage:@"未符合绑定折扣条件,请联系客服!"] hide:YES afterDelay:2.0];
//            
//        }else{
//        
//            CLSHDiscountView * v = [[CLSHDiscountView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//            v.showDiscountblock = ^(){
//                [v removeFromSuperview];
//                [MBProgressHUD showSuccess:@"提交成功"];
//            };
//            [ShareApp.window addSubview:v];
//        }
//    }
    
    //应老大要求
//    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isFlat) {
//        
//        if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isPinless) {
//            
//        }else{
//        
//            CLSHDiscountView * v = [[CLSHDiscountView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//            v.showDiscountblock = ^(){
//                [v removeFromSuperview];
//                [MBProgressHUD showSuccess:@"提交成功"];
//            };
//            [ShareApp.window addSubview:v];
//        }
//        
//    }else{
//    
//       [[MBProgressHUD showMessage:@"未符合绑定折扣条件,请联系客服!"] hide:YES afterDelay:3.0];
//        CLSHAccountLogoutModel * logoutModel = [[CLSHAccountLogoutModel alloc] init];
//        [logoutModel postAppLogoutData:nil callBack:^(BOOL isSuccess, id result) {
//            
//            if (isSuccess) {
//                [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=NO;
//                NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"info"]];
//                dict[@"password"] = nil;
//                [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"info"];
//                
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogined"];
//                
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
//                    
//                    CLSHLoginViewController *loginViewController=[[CLSHLoginViewController alloc]init];
//                    //loginViewController.isBackRootTabbar=YES;
//                    [self.parentViewController presentViewController:loginViewController animated:YES completion:nil];
//                });
//            }
//        }];
//    }
    //应狗子要求
    if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isPinless) {
        
    }else{
    
        if ([FetchAppPublicKeyModel shareAppPublicKeyManager].isFlat) {
            CLSHDiscountView * v = [[CLSHDiscountView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
            v.showDiscountblock = ^(){
                [v removeFromSuperview];
                [MBProgressHUD showSuccess:@"提交成功"];
            };
            [ShareApp.window addSubview:v];
        }else{
        
            [[MBProgressHUD showMessage:@"未符合绑定折扣条件,请联系客服!"] hide:YES afterDelay:3.0];
            CLSHAccountLogoutModel * logoutModel = [[CLSHAccountLogoutModel alloc] init];
            [logoutModel postAppLogoutData:nil callBack:^(BOOL isSuccess, id result) {
                
                if (isSuccess) {
                    [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=NO;
                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"info"]];
                    dict[@"password"] = nil;
                    [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"info"];
                    
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogined"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                        
                        CLSHLoginViewController *loginViewController=[[CLSHLoginViewController alloc]init];
                        //loginViewController.isBackRootTabbar=YES;
                        [self.parentViewController presentViewController:loginViewController animated:YES completion:nil];
                    });
                }
            }];
        }
    }
   
}

-(void)initAnimation{
    
}

-(void)removeAnimation{
    
}

-(void)initModelData{
    cLSHHomeModel=[CLSHHomeModel new];
}


-(void)loadData{
    
    [cLSHHomeModel fetchHomeData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            [hud hide:YES];
            cLSHHomeModel = result;
            [_collectionView reloadData];
            
        }else{
             [hud hide:YES];
        }
    }];
}

#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section==0) {
        return 1;
    }
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        CLSHHomeTopViewCell *topCell=[collectionView dequeueReusableCellWithReuseIdentifier:topViewCellId forIndexPath:indexPath];
        topCell.homeModel = cLSHHomeModel;
        topCell.delegate=self;
        return topCell;
    }else{
         CLSHHomeBottomViewCell *bottomCell=[collectionView dequeueReusableCellWithReuseIdentifier:bottomViewCellId forIndexPath:indexPath];
        
        bottomCell.nameText=self.nameArr[indexPath.row];
        bottomCell.iconText=self.iconArr[indexPath.row];
        return bottomCell;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CLSHHomePublishHeader *header;
    if (indexPath.section==1) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:publishHeaderCellId forIndexPath:indexPath];
            header.deleagete=self;
        }
    }
    return header;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        switch (indexPath.row) {
            case 0:{

//                CLSHMerchantJoinProcessVC *merchantJoinProcessVC = [[CLSHMerchantJoinProcessVC alloc] init];
//                merchantJoinProcessVC.shopId = cLSHHomeModel.merchantID;
//                [self.navigationController pushViewController:merchantJoinProcessVC animated:YES];
                
                CLSHManagerGoodsVC *cLSHManagerGoodsVC=[CLSHManagerGoodsVC new];
                [self.navigationController pushViewController:cLSHManagerGoodsVC animated:YES];
            }
                
                break;
            case 1:{
            
                CLSHOrderManagerViewController * orderManagerVC = [[CLSHOrderManagerViewController alloc] init];
                [self.navigationController pushViewController:orderManagerVC animated:YES];
            }
                break;
            case 2:
            {
                CLSHCategoryManagementVC *categoryManagementVC = [[CLSHCategoryManagementVC alloc] init];
                [self.navigationController pushViewController:categoryManagementVC animated:YES];
            }
                break;
            case 3:
            {
                CLSHDataStatisticVC *dataStatisticVC = [[CLSHDataStatisticVC alloc] init];
                [self.navigationController pushViewController:dataStatisticVC animated:YES];
            }
                break;
            case 4:
            {
                CLSHAdvertiseManagementVC *advertiseManagementVC = [[CLSHAdvertiseManagementVC alloc] init];
                [self.navigationController pushViewController:advertiseManagementVC animated:YES];
            }
                break;
            case 5:
            
            {
                /**
                CLGSAccountBalanceViewController *cLGSAccountBalanceViewController=[[CLGSAccountBalanceViewController alloc]initWithNibName:@"CLGSAccountBalanceViewController" bundle:nil];
                [self.navigationController pushViewController:cLGSAccountBalanceViewController animated:YES];
                */
                CLSHMoneyManagerViewController * managerMoneyVC = [CLSHMoneyManagerViewController new];
                [self.navigationController pushViewController:managerMoneyVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}


#pragma mark <UICollectionViewDelegateFlowLayout>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(SCREENWIDTH, 200*AppScale);
    }else{
        return CGSizeMake((SCREENWIDTH-0.1)/3, (SCREENHEIGHT-240*AppScale-0.1-113)/2);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return CGSizeMake(SCREENWIDTH, 40*AppScale);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}


#pragma mark <CLSHHomePublishHeaderDelegate>
-(void)upLoadNewGoods{
    CLSHUpLoadGoodsVC *cLSHUpLoadGoodsVC=[CLSHUpLoadGoodsVC new];
    [self.navigationController pushViewController:cLSHUpLoadGoodsVC animated:YES];
}

#pragma mark <CLSHHomeTopViewCellDelegate>
-(void)clickWithDrawBtn{
    
    NSString * status = [[NSUserDefaults standardUserDefaults] objectForKey:@"certification"];
    if ([status isEqualToString:@"success"]) {
        
        CLSHApplicationWithDrawalsVC *cLSHApplicationWithDrawalsVC=[CLSHApplicationWithDrawalsVC new];
        cLSHApplicationWithDrawalsVC.balance = [cLSHHomeModel.balance floatValue];
        
        [self.navigationController pushViewController:
         cLSHApplicationWithDrawalsVC animated:YES];
    }else if([status isEqualToString:@"reviewing"]){
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message: @"您的身份验证正在审核中，请耐心等待!" preferredStyle:1];
        UIAlertAction *viewCancle = [UIAlertAction actionWithTitle:@"确定" style:1 handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:viewCancle];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
    
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您的身份尚未验证，请先实名认证" message: @"是否修改或编辑实名认证" preferredStyle:1];
        UIAlertAction *viewCancle = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *viewSure =  [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
            CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
            [self.navigationController pushViewController:certificationVC animated:YES];
        }];
        
        [alert addAction:viewCancle];
        [alert addAction:viewSure];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
