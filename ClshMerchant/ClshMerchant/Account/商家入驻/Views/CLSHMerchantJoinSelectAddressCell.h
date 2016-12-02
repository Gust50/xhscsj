//
//  CLSHMerchantJoinSelectAddressCell.h
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

typedef void(^selectAdressBlock)(NSString *detailAddress);
@interface CLSHMerchantJoinSelectAddressCell : UITableViewCell

@property (nonatomic, copy)selectAdressBlock selectAdressBlock;
@property (nonatomic, copy) NSString *shopAddress;

@end
