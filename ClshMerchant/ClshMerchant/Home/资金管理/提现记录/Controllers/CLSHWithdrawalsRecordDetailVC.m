//
//  CLSHWithdrawalsRecordDetailVC.m
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


#import "CLSHWithdrawalsRecordDetailVC.h"
#import "CLSHRecordDetailView.h"
#import "CLSHWithdrawalsRecordModel.h"

@interface CLSHWithdrawalsRecordDetailVC ()
{
    CLSHWithdrawalsRecordDetailModel *recordDetailModel;    ///<提现记录详情数据模型
}

@property (nonatomic, strong) CLSHRecordDetailView *recordDetailView;

@end

@implementation CLSHWithdrawalsRecordDetailVC

#pragma mark - lazyLoad
-(CLSHRecordDetailView *)recordDetailView
{
    if (!_recordDetailView) {
        _recordDetailView = [[CLSHRecordDetailView alloc] initWithFrame:CGRectMake(0, 74, SCREENWIDTH, 310*AppScale)];
    }
    return _recordDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"提现详情"];
    recordDetailModel = [[CLSHWithdrawalsRecordDetailModel alloc] init];
    
    [self.view addSubview:self.recordDetailView];
    [self loadData];
}

#pragma mark - loadData
- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"withDrawLogId"] = self.withDrawLogId;
    [recordDetailModel fetchWithdrawalsRecordDetailData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            recordDetailModel = result;
            self.recordDetailView.detailModel = recordDetailModel;
        }else
        {
            [MBProgressHUD showError:result];
        }
        
    }];
}

#pragma mark - setter getter
-(void)setWithDrawLogId:(NSString *)withDrawLogId
{
    _withDrawLogId = withDrawLogId;
}

@end
