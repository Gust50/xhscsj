//
//  CLSHArriveAccountTimeCell.m
//  ClshUser
//
//  Created by wutaobo on 16/6/23.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHArriveAccountTimeCell.h"

@interface CLSHArriveAccountTimeCell ()
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation CLSHArriveAccountTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.rightLabel.font = [UIFont systemFontOfSize:11*AppScale];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
