//
//  CLSHBankCartDropMenuVC.m
//  ClshUser
//
//  Created by wutaobo on 16/6/14.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHBankCartDropMenuVC.h"
#import "CLSHAccountCardBankModel.h"
@interface CLSHBankCartDropMenuVC ()

@property (nonatomic, strong) NSArray *bankTypeArray;

@end

static NSString *const ID = @"cell";
static NSString *const bankTypeID = @"bankTypeCell";
@implementation CLSHBankCartDropMenuVC

#define mark - loadLazy
-(NSArray *)bankTypeArray
{
    if (!_bankTypeArray) {
        _bankTypeArray = [NSArray arrayWithObjects:@"借记卡", @"信用卡", @"对公账户", nil];
    }
    return _bankTypeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces=NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.tag == 3) {
        return self.bankTypeArray.count;
    }else if (self.tag == 2)
    {
        return self.accountCardBankCategoryModel.bankCategorys.count;
    }else
    {
        return self.userArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    UITableViewCell *bankTypeCell = [tableView dequeueReusableCellWithIdentifier:bankTypeID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (!bankTypeCell) {
        bankTypeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bankTypeID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    bankTypeCell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (self.tag == 3) {
        bankTypeCell.textLabel.font = [UIFont systemFontOfSize:14*AppScale];
        bankTypeCell.textLabel.text = nil;
        bankTypeCell.textLabel.text = self.bankTypeArray[indexPath.row];
        return bankTypeCell;
    }else if(self.tag == 2)
    {
        cell.textLabel.font = [UIFont systemFontOfSize:14*AppScale];
        cell.textLabel.text = nil;
        CLSHAccountCardBankCategoryListModel *listModel = self.accountCardBankCategoryModel.bankCategorys[indexPath.row];
        cell.textLabel.text = listModel.bankCategoryName;
        
        return cell;
    }else
    {
        cell.textLabel.font = [UIFont systemFontOfSize:14*AppScale];
        cell.textLabel.text = nil;
        cell.textLabel.text = self.userArray[indexPath.row];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tag == 3) {
        
        NSArray *array = [NSArray arrayWithObjects:@"debit", @"credit", @"company", nil];
        //通知传值
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        info[@"bankType"] = array[indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CLGSBankCartType" object:nil userInfo:info];
        
    }else if(self.tag == 2)
    {
        //通知传值
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        CLSHAccountCardBankCategoryListModel *listModel = self.accountCardBankCategoryModel.bankCategorys[indexPath.row];
        info[@"bankCategory"] = listModel.bankCategoryName;
        info[@"bankCardID"] = listModel.bankCategoryID;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CLGSBankCategory" object:nil userInfo:info];
    }else
    {
        //通知传值
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CLGSUserName" object:nil userInfo:@{@"userName":self.userArray[indexPath.row]}];
    }
    
}

#pragma mark - stter getter
-(void)setAccountCardBankCategoryModel:(CLSHAccountCardBankCategoryModel *)accountCardBankCategoryModel
{
    _accountCardBankCategoryModel = accountCardBankCategoryModel;
    [self.tableView reloadData];
}

-(void)setUserArray:(NSArray *)userArray
{
    _userArray = userArray;
    [self.tableView reloadData];
}

-(void)setTag:(NSInteger)tag
{
    _tag = tag;
    [self.tableView reloadData];
}

@end
