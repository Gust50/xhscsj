//
//  CLSHUpLoadNameCell.h
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

@protocol  CLSHUpLoadNameCellDelegate <NSObject>
-(void)upLoadNameCellDone:(NSString *)content;
@end

@interface CLSHUpLoadNameCell : UITableViewCell
@property (nonatomic, copy) NSString *nameText;
@property (nonatomic, weak) id<CLSHUpLoadNameCellDelegate>delegate;
@end
