//
//  CLGSWithdrawalsDetailFirstCell.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSWithdrawalsDetailFirstCell.h"
#import "CLSHAccountBalanceModel.h"

@interface CLGSWithdrawalsDetailFirstCell ()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Height;


//出账金额label
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation CLGSWithdrawalsDetailFirstCell

//修改字体
- (void)modify
{
    self.label1Tap.constant = 40*AppScale;
    self.labelHeight.constant = 20*AppScale;
    self.label2Tap.constant = 10*AppScale;
    self.label2Height.constant = 25*AppScale;
    self.moneyLabel.font = [UIFont systemFontOfSize:16*AppScale];
    self.accountLabel.font = [UIFont systemFontOfSize:21*AppScale];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}

#pragma mark - setter getter

- (void)setType:(NSString *)type
{
    _type = type;
    if ([type isEqualToString:@"debit"]) {
        self.moneyLabel.text = @"出账金额";
        self.accountLabel.textColor = RGBColor(153, 153, 153);
    }else
    {
        self.moneyLabel.text = @"入账金额";
        self.accountLabel.textColor = RGBColor(242, 51, 47);
    }
}

//提现记录详情
//-(void)setFetchMoneyRecordDetailModel:(CLSHAccountFetchMoneyRecordDetailModel *)fetchMoneyRecordDetailModel
//{
//    _fetchMoneyRecordDetailModel = fetchMoneyRecordDetailModel;
//    self.moneyLabel.text = @"出账金额";
//    self.accountLabel.textColor = RGBColor(153, 153, 153);
//    NSString *accountLabelStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:fetchMoneyRecordDetailModel.amount]];
//    self.accountLabel.text = accountLabelStr;
//}

-(void)setAmount:(CGFloat)amount
{
    _amount = amount;
    NSString *accountLabelStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:amount]];
    self.accountLabel.text = accountLabelStr;
}

@end
