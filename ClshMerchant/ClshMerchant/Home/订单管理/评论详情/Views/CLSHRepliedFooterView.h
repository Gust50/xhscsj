//
//  CLSHRepliedFooterView.h
//  ClshMerchant
//
//  Created by arom on 16/8/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHAnswerCommentDataModel;
@interface CLSHRepliedFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)UIImageView * iconView;         //头像
@property (nonatomic,strong)UILabel * nameLabel;            //名字
@property (nonatomic,strong)UILabel * timeLabel;            //时间
@property (nonatomic,strong)UILabel * contentLabel;         //内容

@property (nonatomic,strong)CLSHAnswerCommentDataModel * model;

@end
