//
//  CLSHWriteMerchantJoinInfoVC.h
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSHWriteMerchantJoinInfoVC : UIViewController

@property (nonatomic, copy)NSString *industryName;  ///<传入行业名
@property (nonatomic, copy)NSString *industryId;    ///<传入行业id
@property (nonatomic, copy)NSString *shopId;    ///<传入店铺Id
@property (nonatomic, assign)NSInteger tempAppendNumber;
@end
