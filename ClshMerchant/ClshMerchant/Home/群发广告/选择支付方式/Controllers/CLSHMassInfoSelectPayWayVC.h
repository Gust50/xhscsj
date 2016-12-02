//
//  CLSHMassInfoSelectPayWayVC.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSHMassInfoSelectPayWayVC : UIViewController

@property (nonatomic, copy)NSString *payTotalMoney; ///<传入支付总金额
@property (nonatomic, strong)NSMutableDictionary * needsParams;  ///<奇葩接口要传的数据

@end
