//
//  CLSHBalanceIncomeCell.m
//  ClshMerchant
//
//  Created by kobe on 16/9/12.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHBalanceIncomeCell.h"
#import "CLSHAccountBalanceModel.h"
@interface CLSHBalanceIncomeCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *incomeLabelTap;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLabelTap;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *incomeLabelHeight;

/** 总收入三个字 */
@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
/** 总收入金额(数字) */
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@end

@implementation CLSHBalanceIncomeCell

- (void)awakeFromNib {
    [self modify];
}


- (void)modify{
    self.incomeLabelTap.constant = 20;
    self.incomeLabelHeight.constant = 15;
    self.leftLabelTap.constant = 10;
    self.leftLableHeight.constant = 24;
    self.incomeLabel.font = [UIFont systemFontOfSize:15*AppScale];
    self.leftLabel.font = [UIFont systemFontOfSize:19*AppScale];
    self.incomeLabel.textColor = RGBColor(102, 102, 102);
    self.leftLabel.textColor = RGBColor(242, 51, 47);
}


//@2需写
#pragma mark - setter getter
- (void)setIncomeAndExpendModel:(CLSHAccountIncomeModel *)incomeAndExpendModel{
    _incomeAndExpendModel = incomeAndExpendModel;
        NSString *leftValue = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[_incomeAndExpendModel.totalInAmount floatValue]]];
        _leftLabel.text = leftValue;
        [NSString labelString:_leftLabel font:[UIFont systemFontOfSize:13*AppScale] range:NSMakeRange(_leftLabel.text.length - 2, 2) color:RGBColor(242, 51, 47)];

}

@end
