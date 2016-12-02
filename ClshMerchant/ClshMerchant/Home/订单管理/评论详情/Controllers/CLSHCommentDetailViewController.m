//
//  CLSHCommentDetailViewController.m
//  ClshMerchant
//
//  Created by arom on 16/8/15.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHCommentDetailViewController.h"
#import "CLSHInformationOfOrderTableViewCell.h"
#import "CLSHCommentCell.h"
#import "CLSHConmmetHeadView.h"
#import "CLSHUnReplyFooterView.h"
#import "CLSHRepliedFooterView.h"
#import "CLSHOrderManageModel.h"


@interface CLSHCommentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{

    CLSHCommentDataModel * commentModel;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation CLSHCommentDetailViewController

static NSString * const topCellId = @"topCellId";
static NSString * const commentCellID = @"commentCellID";
static NSString * const HeadViewID = @"headViewID";
static NSString * const UnReplyViewID = @"UnReplyViewID";
static NSString * const ReplyViewID = @"ReplyViewID";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+10*AppScale, SCREENWIDTH, SCREENHEIGHT-64-10*AppScale) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma  mnark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self loadData];
}

#pragma mark -- initUI
- (void)initUI{

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"评论详情";
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"评论详情"];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[CLSHInformationOfOrderTableViewCell class] forCellReuseIdentifier:topCellId];
    [self.tableView registerClass:[CLSHCommentCell class] forCellReuseIdentifier:commentCellID];
    [self.tableView registerClass:[CLSHConmmetHeadView class] forHeaderFooterViewReuseIdentifier:HeadViewID];
    [self.tableView registerClass:[CLSHUnReplyFooterView class] forHeaderFooterViewReuseIdentifier:UnReplyViewID];
    [self.tableView registerClass:[CLSHRepliedFooterView class] forHeaderFooterViewReuseIdentifier:ReplyViewID];
    
}

#pragma mark -- load Data
- (void)loadData{
    
    commentModel = [[CLSHCommentDataModel alloc] init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"orderId"] = _orderID;
    DLog(@"one more time");
    [commentModel fetchCommentData:params callBack:^(BOOL isSuccess, id result) {
        [self.dataArray removeAllObjects];
        if (isSuccess) {
            commentModel = result;
            self.dataArray = [NSMutableArray arrayWithArray:commentModel.parentReview];
            [self.tableView reloadData];
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark -- tableView datasource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 3;
    }else{
    
        return 1;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 44*AppScale;
    }else{
    
        CGSize size = [NSString sizeWithStr:commentModel.reviewContent font:[UIFont systemFontOfSize:12*AppScale] width:SCREENWIDTH-20];
        if (commentModel.reviewImages.count) {
             return size.height+35*AppScale+(SCREENWIDTH-50*AppScale)/4+10*AppScale;
        }else{
        
            return size.height+35*AppScale;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0.01;
    }
    return 40*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return 10*AppScale;
    }else{
    
        if (_dataArray.count) {
            
            CLSHAnswerCommentDataModel *model = self.dataArray[0];
            CGSize size = [NSString sizeWithStr:model.Content font:[UIFont systemFontOfSize:10*AppScale] width:SCREENWIDTH-20];
            return size.height+35*AppScale+10*AppScale;
        }else{
        
            return 40*AppScale;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{

    return 10*AppScale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CLSHConmmetHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadViewID];
    if (!headView) {
        headView = [[CLSHConmmetHeadView alloc] initWithReuseIdentifier:HeadViewID];
    }
   
    if (section != 0) {
        
        headView.model = commentModel;
        return headView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    CLSHRepliedFooterView * replyFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ReplyViewID];
    CLSHUnReplyFooterView * unReplyFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:UnReplyViewID];
    
    if (section == 1) {
        if (_dataArray.count) {
            
            CLSHAnswerCommentDataModel * answerCommentModel = [[CLSHAnswerCommentDataModel alloc] init];
            answerCommentModel = _dataArray[0];
            replyFooterView.model = answerCommentModel;
            
            return replyFooterView;
        }else{
        
            unReplyFooterView.answerCommentblock = ^(){
            
                if (unReplyFooterView.textField.text.length == 0) {
                    [MBProgressHUD showError:@"请输入要回复的内容"];
                }else{
                
                    CLSHAnswerCommentBehaviorModel * answerCommentBehavior = [[CLSHAnswerCommentBehaviorModel  alloc] init];
                    NSMutableDictionary * needParams = [NSMutableDictionary dictionary];
                    needParams[@"content"] = unReplyFooterView.textField.text;
                    needParams[@"reviewId"] = commentModel.reviewId;
                    [answerCommentBehavior fetchAnswerCommentBehaviorData:needParams callBack:^(BOOL isSuccess, id result) {
                        if (isSuccess) {
                            
//                            [MBProgressHUD showSuccess:result];
                            [self loadData];
                        }else{
                        
                            [MBProgressHUD showError:result];
                        }
                    }];
                }
            };
            return unReplyFooterView;
        }
        
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHInformationOfOrderTableViewCell * infoCell = [tableView dequeueReusableCellWithIdentifier:topCellId];
    CLSHCommentCell * commentCell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    if (!infoCell) {
        infoCell = [[CLSHInformationOfOrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:topCellId];
    }
    if (!commentCell) {
        commentCell = [[CLSHCommentCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:commentCellID];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            infoCell.leftLabel.text = @"下单时间：";
            infoCell.rightLabel.text = commentModel.orderCreateDate;
            
        }else if (indexPath.row == 1){
        
            infoCell.leftLabel.text = @"订单编号：";
            infoCell.rightLabel.text = commentModel.orderSn;
        }else{
        
            infoCell.leftLabel.text = @"配送方式：";
            infoCell.rightLabel.text = commentModel.shippingMethodName;
        }
        
        infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return infoCell;
    }else{

        commentCell.model = commentModel;
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return commentCell;
    }
}

@end
