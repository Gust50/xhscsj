//
//  CLSHSelectCategoryView.m
//  ClshMerchant
//
//  Created by kobe on 16/8/10.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSelectCategoryView.h"
#import "CLSHCategoryManageModel.h"

@interface CLSHSelectCategoryView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CLSHSelectCategoryView
static NSString *const cellID=@"cellID";
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 150*AppScale, 120*AppScale) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
    }
    return _tableView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        [self initTalbleView];
    }
    return self;
}

-(void)initTalbleView{
    
    [self addSubview:self.tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categoryModel.classification.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:12*AppScale];
    CLSHCategoryListModel *listModel = self.categoryModel.classification[indexPath.row];
    cell.textLabel.text=listModel.name;
    return cell;
}

-(void)setCategoryModel:(CLSHCategoryManageModel *)categoryModel
{
    _categoryModel = categoryModel;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHCategoryListModel *listModel = self.categoryModel.classification[indexPath.row];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"name"] = listModel.name;
    dic[@"categoryId"] = @(listModel.categoryID);
    NSLog(@"----%zi",listModel.categoryID);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postCategoryName" object:nil userInfo:dic];
    
}

@end
