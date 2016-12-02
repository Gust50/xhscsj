//
//  BaseCollectionViewVC.h
//  ClshMerchant
//
//  Created by kobe on 16/7/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>
typedef void(^leftBarButtonBlock)(void);
typedef void(^rightBarButtonBlock)(void);

@interface BaseCollectionViewVC : UICollectionViewController


-(void)configureLeftBarButtonWithTitle:(NSString *)title
                             normalImg:(NSString *)normal
                             selectImg:(NSString *)selectImg
                                action:(leftBarButtonBlock)action;

-(void)configureRightBarButtonWithTitle:(NSString *)title
                              normalImg:(NSString *)normal
                              selectImg:(NSString *)selectImg
                                 action:(rightBarButtonBlock)action;
@end
