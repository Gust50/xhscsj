//
//  CLSHSelectDiscountView.m
//  ClshMerchant
//
//  Created by arom on 16/9/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSelectDiscountView.h"
#import "CLSHHomeModel.h"

@interface CLSHSelectDiscountView ()<UITableViewDelegate,UITableViewDataSource>{

    CLSHDiscountListModel * discountListModel;
}

@property (nonatomic,strong)UITableView * tableView;
@end

@implementation CLSHSelectDiscountView

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.size.width,self.size.height) style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.tableView];
}

#pragma mark -- tableViewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.dataSource) {
        return _dataSource.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellID"];
    }
    discountListModel = [[CLSHDiscountListModel alloc] init];
    discountListModel = [_dataSource objectAtIndexCheck:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",discountListModel.discount];
    cell.textLabel.font = [UIFont systemFontOfSize:12*AppScale];
    cell.textLabel.textColor = RGBColor(102, 102, 102);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self removeFromSuperview];
    if (self.selectDiscountblock) {
        self.selectDiscountblock(indexPath.row);
    }
}

@end
