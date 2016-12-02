//
//  CLSHWriteIdentityInfoVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHWriteIdentityInfoVC.h"
#import "CLSHWriteMerchantJoinInfoVC.h"

@interface CLSHWriteIdentityInfoVC ()

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oneLineTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *twoLineTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nextTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nextHeight;


@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *identityLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputName;
@property (strong, nonatomic) IBOutlet UITextField *inputIdentityNum;
@property (strong, nonatomic) IBOutlet UITextField *inputPhoneNum;
@property (strong, nonatomic) IBOutlet UIButton *next;

@end

@implementation CLSHWriteIdentityInfoVC

- (void)modify
{
    self.describeTop.constant = 64+10*AppScale;
    self.describeHeight.constant = 20*AppScale;
    self.backViewTop.constant = 10*AppScale;
    self.backViewHeight.constant = 120*AppScale;
    self.nameHeight.constant = 70*AppScale;
    self.oneLineTop.constant = 39*AppScale;
    self.twoLineTop.constant = 39*AppScale;
    self.nextTop.constant = 50*AppScale;
    self.nextHeight.constant = 40*AppScale;
    self.describe.font = [UIFont systemFontOfSize:13*AppScale];
    self.nameLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.identityLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.phoneNumLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputName.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputIdentityNum.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputPhoneNum.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputName.borderStyle = UITextBorderStyleNone;
    self.inputIdentityNum.borderStyle = UITextBorderStyleNone;
    self.inputPhoneNum.borderStyle = UITextBorderStyleNone;
    self.next.titleLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.next.layer.cornerRadius = 5*AppScale;
    self.next.layer.masksToBounds = YES;
    self.next.backgroundColor = systemColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"填写身份信息"];
}

//下一步

- (IBAction)theNext:(UIButton *)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    if (self.inputName.text.length < 2) {
//        [MBProgressHUD showError:@"请输入正确的姓名"];
//        return;
//    }else if (![KBRegexp validateUserIdCard:self.inputIdentityNum.text])
//    {
//        [MBProgressHUD showError:@"请输入正确的身份证号码"];
//        return;
//    }else if (![KBRegexp checkPhoneNumInput:self.inputPhoneNum.text])
//    {
//        [MBProgressHUD showError:@"请输入正确的手机号码"];
//        return;
//    }
    params[@"memberName"] = self.inputName.text;
    params[@"phone"] = self.inputPhoneNum.text;
    params[@"idCardNumber"] = self.inputIdentityNum.text;
    params[@"industryId"] = self.industryId;
    CLSHWriteMerchantJoinInfoVC *writeMerchantJoinInfoVC = [[CLSHWriteMerchantJoinInfoVC alloc] init];
    writeMerchantJoinInfoVC.params = params;
    writeMerchantJoinInfoVC.industryName = self.industryName;
    [self.navigationController pushViewController:writeMerchantJoinInfoVC animated:YES];
}

#pragma mark - setter getter
-(void)setIndustryName:(NSString *)industryName
{
    _industryName = industryName;
}

-(void)setIndustryId:(NSString *)industryId
{
    _industryId = industryId;
}

@end
