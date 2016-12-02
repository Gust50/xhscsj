//
//  CLSHAdvertisingDetailVC.m
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


#import "CLSHAdvertisingDetailVC.h"
#import "CLSHAdvertiseEndDateCell.h"
#import "CLSHMerchantNameCell.h"
#import "CLSHMerchantImageCell.h"
#import "CLSHAdvertiseBrowseNumCell.h"
#import "CLSHAdManagerModel.h"

@interface CLSHAdvertisingDetailVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CLSHAdDetailManagerModel * detailManagerModel;
}

@property (nonatomic, strong)UITableView *tableView;
@end

@implementation CLSHAdvertisingDetailVC
static NSString *const endDateID = @"CLSHAdvertiseEndDateCell";
static NSString *const nameID = @"CLSHMerchantNameCell";
static NSString *const ID = @"Cell";
static NSString *const imageID = @"CLSHMerchantImageCell";
static NSString *const browseNumID = @"CLSHAdvertiseBrowseNumCell";

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFooter];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"广告详情"];
    
    [self loadData];
    
    //注册cell
    [self.tableView registerClass:[CLSHAdvertiseEndDateCell class] forCellReuseIdentifier:endDateID];
    [self.tableView registerClass:[CLSHMerchantNameCell class] forCellReuseIdentifier:nameID];
    [self.tableView registerClass:[CLSHMerchantImageCell class] forCellReuseIdentifier:imageID];
    [self.tableView registerClass:[CLSHAdvertiseBrowseNumCell class] forCellReuseIdentifier:browseNumID];
}

//加载尾部
- (void)loadFooter
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10*AppScale, SCREENWIDTH, 80*AppScale)];
    view.backgroundColor = backGroundColor;
    UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(15*AppScale, 10*AppScale, SCREENWIDTH-30*AppScale, 60*AppScale)];
    footer.numberOfLines = 0;
    footer.font = [UIFont systemFontOfSize:12*AppScale];
    footer.text = @"*广告截止日期后的24小时内，剩余未被领取的红包金额将自动返还到商家账户，请注意查收！";
    footer.textAlignment = NSTextAlignmentCenter;
    footer.textColor = RGBColor(122, 122, 123);
    [NSString labelString:footer font:[UIFont systemFontOfSize:12*AppScale] range:NSMakeRange(0, 1) color:[UIColor redColor]];
    [view addSubview:footer];
    self.tableView.tableFooterView = view;
}

#pragma mark -- 加载数据
-(void)loadData{

    detailManagerModel = [[CLSHAdDetailManagerModel alloc] init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"luckyDrawAdId"] = self.adId;
    
    [detailManagerModel fetchAdDetailManagerData:params callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            detailManagerModel = result;
            [self.tableView reloadData];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 1) {
        return detailManagerModel.images.count+2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSHAdvertiseEndDateCell *endDateCell = [tableView dequeueReusableCellWithIdentifier:endDateID];
    CLSHMerchantNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:nameID];
    CLSHMerchantImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:imageID];
    CLSHAdvertiseBrowseNumCell *browseNumCell = [tableView dequeueReusableCellWithIdentifier:browseNumID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!browseNumCell) {
        browseNumCell = [[CLSHAdvertiseBrowseNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:browseNumID];
    }
    if (!imageCell) {
        imageCell = [[CLSHMerchantImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageID];
    }
    if (!nameCell) {
        nameCell = [[CLSHMerchantNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nameID];
    }
    if (!endDateCell) {
        endDateCell = [[CLSHAdvertiseEndDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:endDateID];
    }
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    endDateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    browseNumCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        endDateCell.model = detailManagerModel;
        return endDateCell;
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            nameCell.merchantName.text = detailManagerModel.title;
            return nameCell;
        }else if (indexPath.row == 1)
        {
            cell.textLabel.font = [UIFont systemFontOfSize:12*AppScale];
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.text = detailManagerModel.introduction;
            return cell;
        }else
        {
            imageCell.imageUrl = detailManagerModel.images[indexPath.row-2];
            return imageCell;
        }
    }else
    {
        browseNumCell.model = detailManagerModel;
        return browseNumCell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40*AppScale;
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            return 40*AppScale;
        }else if (indexPath.row == 1)
        {
            CGSize size = [NSString sizeWithStr:detailManagerModel.introduction font:[UIFont systemFontOfSize:8*AppScale] width:120];
            return size.height+20*AppScale;
        }else
        {
            return 130*AppScale;
        }
    }else
    {
        return 152*AppScale;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
@end
