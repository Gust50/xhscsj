//
//  CLSHIndetityImageCell.h
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

@protocol  CLSHIndetityImageCellDelegate<NSObject>

-(void)upLoadImg:(NSString *)upLoadTypeName;
-(void)upLoadImgTypeName:(NSString *)typeName isPerson:(BOOL)isPersion indexPath:(NSIndexPath *)indexPath;
@end

@interface CLSHIndetityImageCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL isPerson;
@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)UIButton *upload;
@property (nonatomic, weak) id <CLSHIndetityImageCellDelegate>delegate;
@end
