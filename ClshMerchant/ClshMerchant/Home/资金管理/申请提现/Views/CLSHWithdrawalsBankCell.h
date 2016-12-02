//
//  CLSHWithdrawalsBankCell.h
//  ClshUser
//
//  Created by wutaobo on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSHWithdrawalsBankCell : UITableViewCell

//是否需要隐藏btn
@property (nonatomic, assign) BOOL isHiddenBtn;
/** 银行卡图标 */
@property (strong, nonatomic) IBOutlet UIImageView *bankCartIcon;
/** 银行卡名字 */
@property (strong, nonatomic) IBOutlet UILabel *bankName;
/** 银行卡尾号 */
@property (strong, nonatomic) IBOutlet UILabel *bankCartTailNumber;
@end
