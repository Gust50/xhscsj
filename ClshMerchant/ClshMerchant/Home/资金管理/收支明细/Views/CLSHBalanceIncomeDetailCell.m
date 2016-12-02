//
//  CLSHBalanceIncomeDetailCell.m
//  ClshMerchant
//
//  Created by kobe on 16/9/13.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHBalanceIncomeDetailCell.h"

@interface CLSHBalanceIncomeDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *label1;///左边文字创建时间
@property (weak, nonatomic) IBOutlet UILabel *label2;///左边文字生效时间
@property (weak, nonatomic) IBOutlet UILabel *label3;///左边文字入账金额
@property (weak, nonatomic) IBOutlet UILabel *label4;///左边文字已结算收益天数
@property (weak, nonatomic) IBOutlet UILabel *label5;//左边文字剩余可结算收益天数
@property (weak, nonatomic) IBOutlet UILabel *label6;//左边文字订单号
@property (weak, nonatomic) IBOutlet UILabel *label7;///左边文字商品名称
@property (weak, nonatomic) IBOutlet UILabel *label8;///左边文字备注




@property (weak, nonatomic) IBOutlet UILabel *startTimelabel;///创建时间
@property (weak, nonatomic) IBOutlet UILabel *effectTimeLabel;///生效时间
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;///入账金额
@property (weak, nonatomic) IBOutlet UILabel *didEarnDayLabel;///已结算收益天数
@property (weak, nonatomic) IBOutlet UILabel *leaftEarnDayLabel;//剩余可结算收益天数
@property (weak, nonatomic) IBOutlet UILabel *snlabel;//订单号
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;///商品名称
@property (weak, nonatomic) IBOutlet UILabel *memoLabel;///备注

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left1Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left1Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left1Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left2Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left2Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left2Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left3Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left3Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left3Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left4Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left4Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left4Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left5Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left5Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left5Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left6Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left6Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left6Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left7Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left7Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left7Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left8Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left8Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left8Width;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right1Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right1Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right1Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right2Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right2Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right2Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right3Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right3Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right3Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right4Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right4Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right4Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right5Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right5Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right5Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right6Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right6Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right6Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right7Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right7Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right7Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right8Tap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right8Width;




@end
@implementation CLSHBalanceIncomeDetailCell

- (void)awakeFromNib {
    [self modify];
}

- (void)modify{
    self.left1Tap.constant = 10*AppScale;
    self.left1Height.constant = 15*AppScale;
    self.left1Width.constant = 110*AppScale;
    
    self.left2Tap.constant = 5*AppScale;
    self.left2Height.constant = 15*AppScale;
    self.left2Width.constant = 110*AppScale;
    
    self.left3Tap.constant = 5*AppScale;
    self.left3Height.constant = 15*AppScale;
    self.left3Width.constant = 110*AppScale;
    
    self.left4Tap.constant = 5*AppScale;
    self.left4Height.constant = 15*AppScale;
    self.left4Width.constant = 110*AppScale;
    
    self.left5Tap.constant = 5*AppScale;
    self.left5Height.constant = 15*AppScale;
    self.left5Width.constant = 110*AppScale;
    
    
    self.left6Tap.constant = 5*AppScale;
    self.left6Height.constant = 15*AppScale;
    self.left6Width.constant = 110*AppScale;
    
    
    self.left7Tap.constant = 5*AppScale;
    self.left7Height.constant = 15*AppScale;
    self.left7Width.constant = 110*AppScale;
    
    self.left8Tap.constant = 5*AppScale;
    self.left8Height.constant = 15*AppScale;
    self.left8Width.constant = 110*AppScale;
    
    
    
    
    self.right1Tap.constant = 5*AppScale;
    self.right1Height.constant = 15*AppScale;
    self.right1Width.constant = 161*AppScale;
    
    self.right2Tap.constant = 5*AppScale;
    self.right2Height.constant = 15*AppScale;
    self.right2Width.constant = 161*AppScale;
    
    self.right3Tap.constant = 5*AppScale;
    self.right3Height.constant = 15*AppScale;
    self.right3Width.constant = 161*AppScale;
    
    self.right4Tap.constant = 5*AppScale;
    self.right4Height.constant = 15*AppScale;
    self.right4Width.constant = 161*AppScale;
    
    self.right5Tap.constant = 5*AppScale;
    self.right5Height.constant = 15*AppScale;
    self.right5Width.constant = 161*AppScale;
    
    
    self.right6Tap.constant = 5*AppScale;
    self.right6Height.constant = 15*AppScale;
    self.right6Width.constant = 161*AppScale;
    
    self.right7Tap.constant = 5*AppScale;
    self.right7Height.constant = 15*AppScale;
    self.right7Width.constant = 161*AppScale;
    
    self.right8Tap.constant = 5*AppScale;
    self.right8Width.constant = 161*AppScale;
   
    self.label1.font = [UIFont systemFontOfSize:12*AppScale];
    self.label2.font = [UIFont systemFontOfSize:12*AppScale];
    self.label3.font = [UIFont systemFontOfSize:12*AppScale];
    self.label4.font = [UIFont systemFontOfSize:12*AppScale];
    self.label5.font = [UIFont systemFontOfSize:12*AppScale];
    self.label6.font = [UIFont systemFontOfSize:12*AppScale];
    self.label7.font = [UIFont systemFontOfSize:12*AppScale];
    self.label8.font = [UIFont systemFontOfSize:12*AppScale];
    
    self.startTimelabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.effectTimeLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.incomeLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.didEarnDayLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.leaftEarnDayLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.snlabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.nameLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.memoLabel.font = [UIFont systemFontOfSize:12*AppScale];
    
    self.startTimelabel.textColor = RGBColor(66, 66, 66);
    self.effectTimeLabel.textColor = RGBColor(66, 66, 66);
    self.incomeLabel.textColor = RGBColor(66, 66, 66);
    self.didEarnDayLabel.textColor = RGBColor(66, 66, 66);
    self.leaftEarnDayLabel.textColor = RGBColor(66, 66, 66);
    self.snlabel.textColor = RGBColor(66, 66, 66);
    self.nameLabel.textColor = RGBColor(66, 66, 66);
    self.memoLabel.textColor = RGBColor(66, 66, 66);
    
    
}

- (void)setIncomemmModel:(CLSHIncomeDetailModel *)incomemmModel{
    
    _incomemmModel = incomemmModel;
    
    //创建时间
    NSDate *date = [[KBDateFormatter shareInstance]dateFromTimeInterval:([incomemmModel.createDate doubleValue]/1000.0)];
    NSString *timeString = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.startTimelabel.text = timeString;
    
    //收益生效时间
    NSDate *ddate = [[KBDateFormatter shareInstance]dateFromTimeInterval:([incomemmModel.effectiveTime doubleValue]/1000.0)];
    NSString *dtimeString = [[KBDateFormatter shareInstance] stringFromDate:ddate];
    self.startTimelabel.text = dtimeString;
    ///入账金额
    self.incomeLabel.text = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[incomemmModel.inAmount floatValue]]] ;
    
    ///已结算收益天数（返回格式暂定为nsstring）
    self.didEarnDayLabel.text = incomemmModel.effectivedDay;
    if (self.didEarnDayLabel.text == NULL) {
        self.didEarnDayLabel.text = @"0天";
    }
    
    ///剩余可结算收益天数（返回格式暂定为nsstring）
    self.leaftEarnDayLabel.text = incomemmModel.remainEffectiveDay;
    if (self.leaftEarnDayLabel.text == NULL) {
        self.leaftEarnDayLabel.text = @"0天";
    }
    
    ///订单号
    self.snlabel.text = incomemmModel.sn;
    if (self.snlabel.text == NULL) {
        self.snlabel.text = @"无订单";
    }
    
    ///商品名(description)
    self.nameLabel.text = incomemmModel.name;
    
    ///备注（可多行显示）
    self.memoLabel.text = incomemmModel.memo;
    if (self.memoLabel.text == NULL) {
        self.memoLabel.text = @"无备注";
    }
    
  
}


@end
