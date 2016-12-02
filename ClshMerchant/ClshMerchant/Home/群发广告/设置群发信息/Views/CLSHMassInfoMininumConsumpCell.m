//
//  CLSHMassInfoMininumConsumpCell.m
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


#import "CLSHMassInfoMininumConsumpCell.h"

@interface CLSHMassInfoMininumConsumpCell ()<UITextFieldDelegate>
{
    NSMutableDictionary *dic;
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *minWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *minHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *couponLeft;


@property (strong, nonatomic) IBOutlet UILabel *minConsump;
@property (strong, nonatomic) IBOutlet UILabel *couponMoney;
@property (strong, nonatomic) IBOutlet UITextField *inputConsump;
@property (strong, nonatomic) IBOutlet UITextField *inputCoupon;


@end

@implementation CLSHMassInfoMininumConsumpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.minWidth.constant = 55*AppScale;
    self.minHeight.constant = 30*AppScale;
    self.couponLeft.constant = 10*AppScale;
    self.minConsump.font = [UIFont systemFontOfSize:12*AppScale];
    self.couponMoney.font = [UIFont systemFontOfSize:12*AppScale];
    self.inputConsump.font = [UIFont systemFontOfSize:12*AppScale];
    self.inputCoupon.font = [UIFont systemFontOfSize:12*AppScale];
    self.inputCoupon.delegate = self;
    self.inputConsump.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    dic = [NSMutableDictionary dictionary];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    dic[@"couponMinAmount"] = self.inputConsump.text;
    dic[@"couponAmount"] = self.inputCoupon.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"couponAmount" object:nil userInfo:dic];
}


#pragma mark - setter getter
-(void)setMin:(NSString *)min
{
    _min = min;
    self.inputConsump.text = min;
}

-(void)setCoupon:(NSString *)coupon
{
    _coupon = coupon;
    self.inputCoupon.text = coupon;
}

@end
