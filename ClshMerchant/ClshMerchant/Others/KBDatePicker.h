//
//  KBPickerTime.h
//  ClshMerchant
//
//  Created by kobe on 16/8/4.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@protocol KBDatePickerDelegate <NSObject>
-(void)showDataPicker:(NSString *)string timeString:(NSString *)timeString;
@end

@interface KBDatePicker : UIView
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, weak) id <KBDatePickerDelegate>delegate;
@property (nonatomic, assign) BOOL isDimBackground;
@property (nonatomic, strong) UIColor *dimBackgroundColor;
@property (nonatomic, assign) CGFloat dimBackgroundAlpha;    ///<0-1
-(void)showDatePicker;
@end
