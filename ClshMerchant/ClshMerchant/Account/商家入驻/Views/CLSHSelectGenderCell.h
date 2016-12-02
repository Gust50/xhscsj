//
//  CLSHSelectGenderCell.h
//  ClshMerchant
//
//  Created by arom on 16/9/18.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <UIKit/UIKit.h>

typedef void(^selectManBlock)();
typedef void(^selectWomanBlock)();

@interface CLSHSelectGenderCell : UITableViewCell

@property (nonatomic,strong)UILabel * describeLabel;    ///<描述
@property (nonatomic,strong)UIButton * manBtn;          ///<男性选择按钮
@property (nonatomic,strong)UIButton * womanBtn;        ///<女性选择按钮

@property (nonatomic,copy)selectManBlock selectManblock;///<选择男block
@property (nonatomic,copy)selectWomanBlock selectWomanblock;///<选择女block

@end
