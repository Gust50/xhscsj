//
//  CLSHSetupCenterCell.m
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


#import "CLSHSetupCenterCell.h"


@interface CLSHSetupCenterCell()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftWidth;

@end

@implementation CLSHSetupCenterCell

//修改字体
- (void)modify
{
    self.iconWidth.constant = 16*AppScale;
    self.iconHeight.constant = 16*AppScale;
    self.leftWidth.constant = 100*AppScale;
    self.imageLabel.textColor = RGBColor(51, 51, 51);
    self.displayRightLabel.textColor = RGBColor(204, 204, 204);
    self.imageLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.displayRightLabel.font = [UIFont systemFontOfSize:12*AppScale];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}



@end
