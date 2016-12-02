//
//  CLSHModifyClassifyCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHModifyClassifyCell.h"
#import "CLSHCategoryManageModel.h"

@interface CLSHModifyClassifyCell ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *selectWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *selectHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineBottom;


@property (strong, nonatomic) IBOutlet UILabel *classifyName;
@property (strong, nonatomic) IBOutlet UIImageView *icon;


@end
@implementation CLSHModifyClassifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectWidth.constant = 15*AppScale;
    self.selectHeight.constant = 15*AppScale;
    self.nameLeft.constant = 10*AppScale;
    self.lineLeft.constant = 20*AppScale;
    self.lineBottom.constant = 8*AppScale;
    
    self.classifyName.font = [UIFont systemFontOfSize:13*AppScale];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.icon.image = [UIImage imageNamed:@"Modify_select"];

    }else
    {
        self.icon.image = [UIImage imageNamed:@"Modify_normal"];

    }
}

- (void)setModel:(CLSHCategoryListModel *)model{

    _model = model;
    self.classifyName.text = model.name;
    
}

@end
