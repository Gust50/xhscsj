//
//  KBTextView.h
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface KBTextView : UITextView
@property (nonatomic, copy) NSString *placeHolder;                ///<提示文本
@property (nonatomic, strong) UIColor *placeHolderColor;          ///<提示文本的颜色
@property (nonatomic, strong) UIFont  *placeHolderFont;            ///<提示文本的字体
@end
