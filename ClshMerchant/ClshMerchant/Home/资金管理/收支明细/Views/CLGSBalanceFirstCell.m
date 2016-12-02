//
//  CLGSBalanceFirstCell.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSBalanceFirstCell.h"
#import "CLSHAccountBalanceModel.h"

@interface CLGSBalanceFirstCell()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label4Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label4Height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineBottom;


@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *paymentLabel;

/** 总收入金额 */
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
/** 总支出金额 */
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation CLGSBalanceFirstCell

//修改字体
- (void)modify
{
    self.label1Tap.constant = 20*AppScale;
    self.label1Height.constant = 15*AppScale;
    self.label2Tap.constant = 10*AppScale;
    self.label2Height.constant = 24*AppScale;
    self.label3Tap.constant = 20*AppScale;
    self.label3Height.constant = 15*AppScale;
    self.label4Tap.constant = 10*AppScale;
    self.label4Height.constant = 24*AppScale;
    self.lineTap.constant = 20*AppScale;
    self.lineBottom.constant = 20*AppScale;
    self.incomeLabel.font = [UIFont systemFontOfSize:15*AppScale];
    self.paymentLabel.font = [UIFont systemFontOfSize:15*AppScale];
    self.leftLabel.font = [UIFont systemFontOfSize:19*AppScale];
    self.rightLabel.font = [UIFont systemFontOfSize:19*AppScale];
    self.incomeLabel.textColor = RGBColor(102, 102, 102);
    self.paymentLabel.textColor = RGBColor(102, 102, 102);
    self.leftLabel.textColor = RGBColor(242, 51, 47);
    self.rightLabel.textColor = RGBColor(51, 51, 51);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self modify];
}

#pragma mark - setter getter
-(void)setIncomeAndExpendModel:(CLSHAccountIncomeModel *)incomeAndExpendModel
{
    _incomeAndExpendModel = incomeAndExpendModel;
    NSString *totalInAmount = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[incomeAndExpendModel.totalInAmount floatValue]]];
    self.leftLabel.text = totalInAmount;
    [NSString labelString:self.leftLabel font:[UIFont systemFontOfSize:13*AppScale] range:NSMakeRange(self.leftLabel.text.length-2, 2) color:RGBColor(242, 51, 47)];
    NSString *totalOutAmount = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[incomeAndExpendModel.totalOutAmount floatValue]]];
    self.rightLabel.text = totalOutAmount;
    [NSString labelString:self.rightLabel font:[UIFont systemFontOfSize:13*AppScale] range:NSMakeRange(self.rightLabel.text.length-2, 2) color:RGBColor(51, 51, 51)];
}

@end
