//
//  CLSHCommentCell.h
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

@class CLSHCommentDataModel;
@interface CLSHCommentCell : UITableViewCell

@property(nonatomic,assign)CGFloat cellHeight;    //高度

@property (nonatomic,strong)UIImageView * iconView;           //头像
@property (nonatomic,strong)UILabel * nameLable;              //姓名
@property (nonatomic,strong)UILabel * timeLable;              //时间
@property (nonatomic,strong)UILabel * contentLabel;           //内容
@property (nonatomic,strong)UIView * imgView;                 //图片View

@property (nonatomic,strong)CLSHCommentDataModel * model;
@end
