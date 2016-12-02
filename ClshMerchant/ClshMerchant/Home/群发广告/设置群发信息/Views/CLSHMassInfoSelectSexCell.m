//
//  CLSHMassInfoSelectSexCell.m
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


#import "CLSHMassInfoSelectSexCell.h"

@interface CLSHMassInfoSelectSexCell ()
{
    NSMutableDictionary *dic;
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *selectWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *selectHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *manLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *menLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *personWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *personLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputLeft;


@property (strong, nonatomic) IBOutlet UIButton *all;
@property (strong, nonatomic) IBOutlet UIButton *man;
@property (strong, nonatomic) IBOutlet UIButton *men;
@property (strong, nonatomic) IBOutlet UILabel *front;
@property (strong, nonatomic) IBOutlet UILabel *person;
@property (strong, nonatomic) IBOutlet UITextField *inputPersonCount;

@end

@implementation CLSHMassInfoSelectSexCell

- (void)modify
{
    self.selectWidth.constant = 50*AppScale;
    self.selectHeight.constant = 30*AppScale;
    self.manLeft.constant = 5*AppScale;
    self.menLeft.constant = 5*AppScale;
    self.personLeft.constant = 5*AppScale;
    self.inputLeft.constant = 5*AppScale;
    self.personWidth.constant = 20*AppScale;
    self.inputWidth.constant = 70*AppScale;
    self.all.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.man.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.men.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.front.font = [UIFont systemFontOfSize:12*AppScale];
    self.inputPersonCount.font = [UIFont systemFontOfSize:12*AppScale];
    self.person.font = [UIFont systemFontOfSize:12*AppScale];
    self.all.titleEdgeInsets = UIEdgeInsetsMake(0, 5*AppScale, 0, 0);
    self.man.titleEdgeInsets = UIEdgeInsetsMake(0, 5*AppScale, 0, 0);
    self.men.titleEdgeInsets = UIEdgeInsetsMake(0, 5*AppScale, 0, 0);
    self.all.selected = YES;
    [self.all setImage:[UIImage imageNamed:@"Select_select"] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
    self.backgroundColor = [UIColor whiteColor];
    dic = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange)  name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textFieldDidChange
{
    dic[@"text"] = self.inputPersonCount.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectSex" object:nil userInfo:dic];
}

- (IBAction)selectSex:(UIButton *)sender {
    
    if (sender.tag == 1) {
       [self.all setImage:[UIImage imageNamed:@"Select_select"] forState:UIControlStateNormal];
        [self.man setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
        [self.men setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
    }else if (sender.tag == 2)
    {
        [self.all setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
        [self.man setImage:[UIImage imageNamed:@"Select_select"] forState:UIControlStateNormal];
        [self.men setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
        dic[@"genderType"] = @"male";
    }else
    {
        [self.all setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
        [self.man setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
        [self.men setImage:[UIImage imageNamed:@"Select_select"] forState:UIControlStateNormal];
        dic[@"genderType"] = @"female";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectSex" object:nil userInfo:dic];
}


@end
