//
//  CLSHWithdrawalsBankCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHWithdrawalsBankCell.h"

@interface CLSHWithdrawalsBankCell ()
/** 约束 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bankNameTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *arrowWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *arrowHeight;


@end

@implementation CLSHWithdrawalsBankCell
//修改字体
- (void)modify
{
    self.arrowWidth.constant = 10*AppScale;
    self.arrowHeight.constant = 10*AppScale;
    self.iconHeight.constant = 30*AppScale;
    self.iconWidth.constant = 30*AppScale;
    self.bankCartIcon.layer.cornerRadius = 15*AppScale;
    self.bankCartIcon.layer.masksToBounds = YES;
    self.bankNameTap.constant = 10*AppScale;
    self.numberTap.constant = 5*AppScale;
    self.bankName.textColor = RGBColor(50, 50, 50);
    self.bankName.font = [UIFont systemFontOfSize:13*AppScale];
    self.bankCartTailNumber.font = [UIFont systemFontOfSize:11*AppScale];
    self.bankCartTailNumber.textColor = RGBColor(200, 200, 204);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:YES];
    
}

#pragma mark - setter getter
//-(void)setAccountCardBankListModel:(CLSHAccountCardBankListModel *)accountCardBankListModel
//{
//    _accountCardBankListModel = accountCardBankListModel;
//    if (accountCardBankListModel.bankAccountImg == nil) {
//        self.bankCartIcon.image = [UIImage imageNamed:@"ChinaBankIcon"];
//    }else
//    {
//        [self.bankCartIcon sd_setImageWithURL:[NSURL URLWithString:accountCardBankListModel.bankAccountImg] placeholderImage:nil];
//    }
//    self.bankName.text = accountCardBankListModel.bankCategory;
//    self.bankCartTailNumber.text = [NSString stringWithFormat:@"尾号（%@）", [accountCardBankListModel.bankAccountNumber substringFromIndex:accountCardBankListModel.bankAccountNumber.length - 4]];
//}

@end
