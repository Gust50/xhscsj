//
//  CLSHMassInfoWalletCell.m
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


#import "CLSHMassInfoWalletCell.h"

@interface CLSHMassInfoWalletCell ()<UITextFieldDelegate>
{
    NSMutableDictionary *dic;
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *walletHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *wayWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputRight;


@property (strong, nonatomic) IBOutlet UILabel *walletLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputMoney;

@end

@implementation CLSHMassInfoWalletCell

- (void)modify
{
    self.walletWidth.constant = 75*AppScale;
    self.walletHeight.constant = 30*AppScale;
    self.wayWidth.constant = 85*AppScale;
    self.inputRight.constant = 10*AppScale;
    self.inputMoney.delegate=self;
    self.walletLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.inputMoney.font = [UIFont systemFontOfSize:12*AppScale];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
    self.backgroundColor = [UIColor whiteColor];
    dic = [NSMutableDictionary dictionary];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    dic[@"luckyDrawAmount"] = self.inputMoney.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"inputWalletAmount" object:nil userInfo:dic];
}

//分配方式
- (IBAction)distributionWay:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"AverageIcon"] forState:UIControlStateNormal];
        dic[@"boRandom"] = @"else";
    }else
    {
        [sender setImage:[UIImage imageNamed:@"RandomIcon"] forState:UIControlStateNormal];
        dic[@"boRandom"] = @"true";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"inputWalletAmount" object:nil userInfo:dic];
}

-(void)setCount:(NSString *)count
{
    _count = count;
    self.inputMoney.text = count;
}

@end
