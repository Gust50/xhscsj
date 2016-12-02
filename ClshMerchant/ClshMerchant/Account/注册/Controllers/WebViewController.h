//
//  WebViewController.h
//  ClshMerchant
//
//  Created by kobe on 16/8/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (nonatomic,strong)UIButton * BackButton;//!<返回键
@property (nonatomic,strong)UIView *navView;
@property (nonatomic,strong)UILabel * navTitleLabel;              //《嗅虎商城服务协议》
@property (nonatomic,strong)UIWebView *web;
@end
