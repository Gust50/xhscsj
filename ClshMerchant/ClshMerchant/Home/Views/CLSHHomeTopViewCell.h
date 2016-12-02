//
//  CLSHHomeTopViewCell.h
//  ClshMerchant
//
//  Created by kobe on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

@class CLSHHomeModel;
@protocol  CLSHHomeTopViewCellDelegate<NSObject>
-(void)clickWithDrawBtn;
@end

@interface CLSHHomeTopViewCell : UICollectionViewCell
@property (nonatomic, weak) id<CLSHHomeTopViewCellDelegate>delegate;
@property (nonatomic, strong)CLSHHomeModel *homeModel;  ///<首页数据模型
@end
