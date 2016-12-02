//
//  CLSHUnReplyFooterView.h
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

typedef void(^answerCommentBlock)();

@interface CLSHUnReplyFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong)UITextField * textField;          //输入框
@property (nonatomic,strong)UIButton * answerButton;          //回复按钮

@property (nonatomic,copy)answerCommentBlock answerCommentblock;

@end
