//
//  CLSHSetupMyIconCell.h
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

@class CLSHSetUpCenterModel;
@interface CLSHSetupMyIconCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *myIconImage;

//@property (nonatomic,strong)CLSHSetUpCenterModel *setUpCenterModel;

//@2
@property(nonatomic,strong)NSString *iconUrl;
@end
