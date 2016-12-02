//
//  CLSHCertificationVC.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSHCertificationVC : UIViewController

@property (nonatomic, copy)NSString *industryName;  ///<传入行业名称
@property (nonatomic, copy)NSString *industryId;    ///<传入行业id
@property (nonatomic, copy)NSString *shopId;    ///<传入店铺Id

@property (nonatomic, assign)BOOL isFaildCertification;     ///<实名认证失败
@property (nonatomic, assign)BOOL isFirstCertification;     ///<还没有进行实名认证
@property (nonatomic, assign)BOOL isFaildCerAndFaildJoin;   ///<实名认证和入驻失败
@property (nonatomic, assign)BOOL isJoinProgress;           ///<入驻流程
//@4
- (void)loadData;
@end
