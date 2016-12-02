//
//  CLSHMyBankCartCell.h
//  ClshUser
//
//  Created by wutaobo on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHAccountCardBankListModel;

@interface CLSHMyBankCartCell : UITableViewCell

@property (nonatomic, strong) CLSHAccountCardBankListModel *accountCardBankListModel;   ///<银行卡列表数据模型
@property (nonatomic, copy)NSString *name;  ///<判断银行卡从哪个控制器跳转过来
@end
