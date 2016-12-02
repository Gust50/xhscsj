//
//  CLSHInviteCodeRecordHeader.h
//  ClshUser
//
//  Created by kobe on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^userOrMerchantBlock)(NSInteger tag);

@interface CLSHInviteCodeRecordHeader : UIView

@property (nonatomic, copy)userOrMerchantBlock userOrMerchantBlock;

@end
