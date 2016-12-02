//
//  CLSHDeleteCategoryView.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHDeleteCategoryView.h"

@interface CLSHDeleteCategoryView ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleBottom;


@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UIButton *noDelete;
@property (strong, nonatomic) IBOutlet UIButton *delete;

@end
@implementation CLSHDeleteCategoryView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    self.backViewWidth.constant = 240*AppScale;
    self.backViewHeight.constant = 120*AppScale;
    self.middleBottom.constant = 40*AppScale;
    
    self.backView.layer.cornerRadius = 10.0*AppScale;
    self.backView.layer.masksToBounds = YES;
    self.describe.font = [UIFont systemFontOfSize:16*AppScale];
    self.noDelete.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.delete.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:gesture];
}

//不删除类别
- (IBAction)noDeleteCategory:(UIButton *)sender {
    if (self.noDeleteCategoryBlock) {
        self.noDeleteCategoryBlock();
        [self removeFromSuperview];
    }
}

//删除类别
- (IBAction)deleteCategory:(UIButton *)sender {
    if (self.deleteCategoryBlock) {
        self.deleteCategoryBlock();
        [self removeFromSuperview];
    }
}

- (void)removeView
{
    [self removeFromSuperview];
}

@end
