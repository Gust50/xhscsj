//
//  CLSHAccountBankCartInfoVC.h
//  ClshUser
//
//  Created by wutaobo on 16/6/23.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHAccountCardBankListModel;

@interface CLSHAccountBankCartInfoVC : UIViewController

@property (nonatomic, strong) CLSHAccountCardBankListModel *accountCardBankListModel;   ///<银行卡列表数据模型
@property (nonatomic, copy) NSString *bankCartID;   ///<传入银行卡ID
@end
