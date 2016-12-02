//
//  CLSHStoreSwitchCell.h
//  ClshMerchant
//
//  Created by kobe on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

//@protocol  CLSHStoreSwitchCellDelegate<NSObject>
//-(void)clickSwitch:(BOOL)isUse;
//@end

@interface CLSHStoreSwitchCell : UITableViewCell
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *titleContent;
@property (nonatomic,strong)UILabel * discountLabel;
//@property (nonatomic, weak) id<CLSHStoreSwitchCellDelegate>delegate;

@property (nonatomic, assign)BOOL isJoinPromotion;  ///<传入是否参加折扣

@end
