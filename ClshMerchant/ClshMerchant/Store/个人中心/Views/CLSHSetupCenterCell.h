//
//  CLSHSetupCenterCell.h
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@interface CLSHSetupCenterCell : UITableViewCell
/** 图标 */
@property (strong, nonatomic) IBOutlet UIImageView *imageIcon;
/** 图标对应名称 */
@property (strong, nonatomic) IBOutlet UILabel *imageLabel;
/** 右边说明 */
@property (strong, nonatomic) IBOutlet UILabel *displayRightLabel;



@end
