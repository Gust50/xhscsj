//
//  CLSHStoreAddressVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/11.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHStoreAddressVC.h"
#import "CLSHStoreAddressCell.h"

@interface CLSHStoreAddressVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

static NSString *const addressID = @"CLSHStoreAddressCell";
@implementation CLSHStoreAddressVC

#pragma mark - lazyLoad

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10*AppScale, SCREENWIDTH, SCREENHEIGHT-10*AppScale) style:UITableViewStylePlain];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"店铺地址"];
    [self.view addSubview:self.tableView];
    [self loadFooter];
    self.view.userInteractionEnabled = NO;
    
    //注册cell
    [self.tableView registerClass:[CLSHStoreAddressCell class] forCellReuseIdentifier:addressID];
}

- (void)loadFooter
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20*AppScale)];
    view.backgroundColor = backGroundColor;
    UILabel *describe = [[UILabel alloc] initWithFrame:CGRectMake(10*AppScale, 10*AppScale, SCREENWIDTH-20*AppScale, 20*AppScale)];
    describe.backgroundColor = backGroundColor;
    describe.text = @"*店铺地址不可修改。";
    describe.font = [UIFont systemFontOfSize:10*AppScale];
    describe.textColor = RGBColor(106, 106, 107);
    [view addSubview:describe];
    self.tableView.tableFooterView = view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14*AppScale]};
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHStoreAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:addressID];
    if (!addressCell) {
        addressCell = [[CLSHStoreAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressID];
    }
    addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        addressCell.storeAddress.text = @"店铺地址：";
        addressCell.address.text = self.address1;
    }else
    {
        addressCell.storeAddress.text = @"详细地址:";
        addressCell.address.text = self.address;
    }
    return addressCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*AppScale;
}

#pragma mark - setter getter
-(void)setAddress:(NSString *)address
{
    _address = address;
}

-(void)setAddress1:(NSString *)address1
{
    _address1 = address1;
}

@end
