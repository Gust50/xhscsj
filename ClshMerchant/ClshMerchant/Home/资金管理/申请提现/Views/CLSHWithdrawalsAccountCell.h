//
//  CLSHWithdrawalsAccountCell.h
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

@interface CLSHWithdrawalsAccountCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;

@property (strong, nonatomic) IBOutlet UITextField *rightTextfield;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *distance;

@end
