//
//  CLSHSetupInfoModel.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/15.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHSetupInfoModel : NSObject

/**
 *  设置群发信息
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchAddAdSetupMassInfoData:(NSDictionary *)params
              callBack:(void (^) (BOOL isSuccess, id result))completion;

@end
