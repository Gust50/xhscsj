//
//  CLSHAdvertisePreviewVC.m
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


#import "CLSHAdvertisePreviewVC.h"
#import "CLSHMerchantNameCell.h"
#import "CLSHMerchantImageCell.h"
#import "CLSHMechantTaskWalletView.h"
#import "CLSHAdManagerModel.h"

@interface CLSHAdvertisePreviewVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat titleHeight;    ///<计算内容高度
    NSArray *imageArray;    ///<图片数组
    CLSHMechantTaskWalletView *merchantTaskWalletView;
    
     CLSHMerchantGetAdvertiseWalletModel *getAdvertiseWalletModel;   ///<打开广告红包数据模型
    CLSHAdDetailManagerModel * detailManagerModel;  ///<广告详情数据模型
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UILabel *time;

@end

@implementation CLSHAdvertisePreviewVC
static NSString *const nameID = @"CLSHMerchantNameCell";
static NSString *const ID = @"Cell";
static NSString *const imageID = @"CLSHMerchantImageCell";

#pragma mark - lazyLoad
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

-(UILabel *)time
{
    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-45*AppScale, SCREENHEIGHT-50*AppScale, 36*AppScale, 36*AppScale)];
        _time.layer.borderWidth = 1.5;
        _time.layer.borderColor = systemColor.CGColor;
        _time.layer.cornerRadius = 18.0*AppScale;
        _time.layer.masksToBounds = YES;
        _time.textColor = systemColor;
        _time.textAlignment = NSTextAlignmentCenter;
        _time.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _time;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"广告预览"];
    [self.view addSubview:self.time];
    [self countDown:self.time];
    getAdvertiseWalletModel = [[CLSHMerchantGetAdvertiseWalletModel alloc] init];
    
    //注册cell
    [self.tableView registerClass:[CLSHMerchantNameCell class] forCellReuseIdentifier:nameID];
    [self.tableView registerClass:[CLSHMerchantImageCell class] forCellReuseIdentifier:imageID];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

//倒计时
-(void)countDown:(UILabel *)lable{
    __block NSInteger timeout=9;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t  _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout==0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置Label属性
                lable.text=@"0s";
//                lable.hidden = YES;
//                [self loadGetAdWalletData];
                
                merchantTaskWalletView = [[CLSHMechantTaskWalletView alloc] init];
                merchantTaskWalletView.frame=self.view.bounds;
                merchantTaskWalletView.center=self.view.center;
//                [[[UIApplication sharedApplication] keyWindow]addSubview:merchantTaskWalletView];
                
                
            });
        }else{
            lable.hidden = NO;
            NSInteger seconds=timeout%10;
            NSString *strTime=[NSString stringWithFormat:@"%0.1ld",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的显示界面
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                lable.text=[NSString stringWithFormat:@"%@s", strTime];
                [UIView commitAnimations];
                timeout--;
            });
        }
    });
    dispatch_resume(_timer);
}

//领取红包
- (void)loadGetAdWalletData
{
    NSMutableDictionary *getParams = [NSMutableDictionary dictionary];
//    getParams[@"luckyDrawADId"] = self.luckyDrawAdId;
    [getAdvertiseWalletModel fetchAccountMerchantGetAdvertiseWalletModel:getParams callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            getAdvertiseWalletModel = result;
            [self.tableView reloadData];
            if (getAdvertiseWalletModel.coupon && getAdvertiseWalletModel.luckyDraw) {
                merchantTaskWalletView.getWallet.text = @"获得一个红包和一张优惠券";
            }else if (getAdvertiseWalletModel.coupon)
            {
                merchantTaskWalletView.getWallet.text = @"获得一张优惠券";
                
            }else if (getAdvertiseWalletModel.luckyDraw)
            {
                merchantTaskWalletView.getWallet.text = @"获得一个红包";
            }
            
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 2) {
        return imageArray.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHMerchantNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:nameID];
    CLSHMerchantImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:imageID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!imageCell) {
        imageCell = [[CLSHMerchantImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageID];
    }
    if (!nameCell) {
        nameCell = [[CLSHMerchantNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nameID];
    }
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        nameCell.merchantName.text = self.dic[@"title"];
        return nameCell;
    }else if (indexPath.section == 1)
    {
        cell.textLabel.font = [UIFont systemFontOfSize:12*AppScale];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = self.dic[@"content"];
        return cell;
    }else
    {
        imageCell.adImage.image = imageArray[indexPath.row];
        return imageCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40*AppScale;
    }else if (indexPath.section == 1)
    {
        return titleHeight+20*AppScale;
    }else
    {
        return 152*AppScale;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10*AppScale;
    }
    return 0;
}

#pragma mark - setter getter
-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    CGSize size = [NSString sizeWithStr:self.dic[@"content"] font:[UIFont systemFontOfSize:12*AppScale] width:SCREENWIDTH-20*AppScale];
    titleHeight = size.height;
    imageArray = dic[@"img"];
    [self.tableView reloadData];
}

@end
