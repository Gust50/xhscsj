//
//  CLSHMassInfoEndDateCell.h
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

@protocol CLSHMassInfoEndDateCellDelegate <NSObject>

-(void)datePicker;
@end
@interface CLSHMassInfoEndDateCell : UITableViewCell

@property (nonatomic, weak)id<CLSHMassInfoEndDateCellDelegate>delegate;
@property (nonatomic, copy) NSString *showDatePickerTime;
@end
