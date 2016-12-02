//
//  CLSHMassInfoCouponCell.m
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


#import "CLSHMassInfoCouponCell.h"

@interface CLSHMassInfoCouponCell ()
{
    NSMutableDictionary *dic;
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *couponWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *couponHeight;



@end

@implementation CLSHMassInfoCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.couponWidth.constant = 80*AppScale;
    self.couponHeight.constant = 30*AppScale;
    self.fullCutCoupons.titleEdgeInsets = UIEdgeInsetsMake(0, 10*AppScale, 0, 0);
    self.rebate.titleEdgeInsets = UIEdgeInsetsMake(0, 10*AppScale, 0, 0);
    self.noCoupon.titleEdgeInsets = UIEdgeInsetsMake(0, 10*AppScale, 0, 0);
    self.fullCutCoupons.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.rebate.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.noCoupon.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.backgroundColor = [UIColor whiteColor];
    self.fullCutCoupons.selected = YES;
    dic = [NSMutableDictionary dictionary];
    [self.fullCutCoupons setImage:[UIImage imageNamed:@"Select_select"] forState:UIControlStateSelected];
    [self.rebate setImage:[UIImage imageNamed:@"Select_select"] forState:UIControlStateSelected];
    [self.noCoupon setImage:[UIImage imageNamed:@"Select_select"] forState:UIControlStateSelected];
    [self.fullCutCoupons setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
    [self.rebate setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
    [self.noCoupon setImage:[UIImage imageNamed:@"Select_normal"] forState:UIControlStateNormal];
}

//选择优惠券类型
- (IBAction)selectCouponType:(UIButton *)sender {
    
    if (sender.tag == 1) {
        dic[@"couponType"] = @"fullVolumeReduction";
        dic[@"isSelectNull"] = @"NoFirst";
    }else if (sender.tag == 2)
    {
        dic[@"couponType"] = @"other";
        dic[@"isSelectNull"] = @"NoFirst";
    }else
    {
        [dic removeObjectForKey:@"couponType"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectCoupon" object:nil userInfo:dic];
}


@end
