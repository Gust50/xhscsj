//
//  KBPickerArea.h
//  KBPickerArea
//
//  Created by kobe on 16/4/19.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KBPickerArea;

@protocol KBPickerAreaDelegate <NSObject>

/** 回调地址代理 */
-(void)pickerArea:(KBPickerArea *)pickerArea
         province:(NSString *)province
             city:(NSString *)city
             area:(NSString *)area areaId:(NSString *)areaId;
//-(void)pickerArea:(KBPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city;

@end

@interface KBPickerArea : UIView

@property(nonatomic,weak)id<KBPickerAreaDelegate>delegate;

/** 传入地址数据 */
@property(nonatomic,strong,nullable)NSDictionary *dictAddress;

/** 初始化 */
-(instancetype)initWithDelegate:(nullable id)delegate;
/** 显示界面 */
-(void)showSelectAreaView;

@end

NS_ASSUME_NONNULL_END
