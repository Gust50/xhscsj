//
//  CLSHIsJoinDiscountCell.h
//  ClshMerchant
//
//  Created by wutaobo on 16/8/17.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>
@protocol  CLSHIsJoinDiscountCellDelegate<NSObject>
-(void)clickSwitch:(BOOL)isUse;
@end

@interface CLSHIsJoinDiscountCell : UITableViewCell

@property (nonatomic, strong)UILabel *leftLabel;

@property (nonatomic, weak) id<CLSHIsJoinDiscountCellDelegate>delegate;
@property (nonatomic ,assign) BOOL isOn;
@end
