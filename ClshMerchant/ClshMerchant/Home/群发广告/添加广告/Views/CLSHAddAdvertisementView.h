//
//  CLSHAddAdvertisementView.h
//  ClshMerchant
//
//  Created by kobe on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@protocol  CLSHAddAdvertisementViewDelegate<NSObject>
-(void)addImage;
-(void)deleteImage:(UIImage *)img;
-(void)datePicker;
-(void)nextStepBtn;
-(void)previewBtn;
-(void)titleName:(NSString *)name;
-(void)textContent:(NSString *)content;
@end

@interface CLSHAddAdvertisementView : UIView
@property (nonatomic, strong) NSArray *imgArr;


@property (nonatomic, weak) id <CLSHAddAdvertisementViewDelegate>delegate;
@property (nonatomic, copy) NSString *showDatePickerTime;
@end
