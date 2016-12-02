//
//  CLSHJoinProgressVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHJoinProgressVC.h"
#import "CLSHSelectIndustryVC.h"
#import "CLSHCertificationVC.h"
#import "CLSHWriteMerchantJoinInfoVC.h"

@interface CLSHJoinProgressVC ()
{
    NSString * industryId;   ///<行业id
}
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nextHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nextBottom;


@property (strong, nonatomic) IBOutlet UILabel *describe;
@property (strong, nonatomic) IBOutlet UILabel *select;
@property (strong, nonatomic) IBOutlet UILabel *industryName;
@property (strong, nonatomic) IBOutlet UIButton *next;
@end

@implementation CLSHJoinProgressVC

- (void)modify
{
    self.describeTop.constant = 64+20*AppScale;
    self.describeHeight.constant = 20*AppScale;
    self.backViewTop.constant = 5*AppScale;
    self.backViewHeight.constant = 40*AppScale;
    self.imageWidth.constant = 10*AppScale;
    self.imageHeight.constant = 15*AppScale;
    self.nextBottom.constant = 60*AppScale;
    self.nextHeight.constant = 40*AppScale;
    self.describe.font = [UIFont systemFontOfSize:11*AppScale];
    self.select.font = [UIFont systemFontOfSize:13*AppScale];
    self.industryName.font = [UIFont systemFontOfSize:13*AppScale];
    self.next.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.next.layer.cornerRadius = 5*AppScale;
    self.next.layer.masksToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"入驻流程"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectIndustryName:) name:@"selectIndustryName" object:nil];
}

- (void)selectIndustryName:(NSNotification *)info
{
    
    NSDictionary *dic = info.userInfo;
    self.industryName.text = dic[@"industryName"];
    industryId = dic[@"industryId"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//选择行业
- (IBAction)selectIndustry:(UIButton *)sender {
    CLSHSelectIndustryVC *selectIndustryVC = [[CLSHSelectIndustryVC alloc] init];
    [self.navigationController pushViewController:selectIndustryVC animated:YES];
    
}

//下一步
- (IBAction)theNext:(UIButton *)sender {
    if (self.industryName.text.length == 0) {
        [MBProgressHUD showError:@"请选择行业"];
        return;
    }else
    {
        
        CLSHWriteMerchantJoinInfoVC *infoVC = [[CLSHWriteMerchantJoinInfoVC alloc] init];
        infoVC.industryName = self.industryName.text;
        infoVC.tempAppendNumber = self.tempAppendNumber;
        infoVC.industryId = industryId;
        infoVC.shopId = self.shopId;
        [self.navigationController pushViewController:infoVC animated:YES];
        /**
        CLSHCertificationVC *writeIdentityInfoVC = [[CLSHCertificationVC alloc] init];
        writeIdentityInfoVC.industryName = self.industryName.text;
        writeIdentityInfoVC.industryId = industryId;
        writeIdentityInfoVC.shopId = self.shopId;
        [self.navigationController pushViewController:writeIdentityInfoVC animated:YES];
         */
    }
    
}

#pragma mark - setter getter
-(void)setShopId:(NSString *)shopId
{
    _shopId = shopId;
}

@end
