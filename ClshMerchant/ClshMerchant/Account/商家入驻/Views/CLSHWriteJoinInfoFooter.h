//
//  CLSHWriteJoinInfoFooter.h
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

typedef void(^immediatelyApplicationBlock)();
typedef void(^AgreeProtcolBlock)(BOOL isAgree);
@interface CLSHWriteJoinInfoFooter : UIView

@property (nonatomic, copy)immediatelyApplicationBlock immediatelyApplicationBlock;
@property (nonatomic, copy)AgreeProtcolBlock agreeProtcolblock;
@end
