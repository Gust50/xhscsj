//
//  CLSHUpLoadImgCell.h
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>
@protocol CLSHUpLoadImgCellDelegate <NSObject>
-(void)clickUpLoadImgBtn;
-(void)deleteImgBtn:(UIImage *)img;
@end

@interface CLSHUpLoadImgCell : UITableViewCell
@property (nonatomic, strong) NSArray *imgArr;
@property (nonatomic, weak) id<CLSHUpLoadImgCellDelegate>delegate;
@property (nonatomic, assign) BOOL isUrl;
@end
