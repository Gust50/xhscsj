//
//  CLGSAccountBalanceViewController.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/23.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSAccountBalanceViewController.h"
#import "CLGSBalancePaymentsViewController.h"
#import "CLSHApplicationWithDrawalsVC.h"
#import "CLSHWithdrawalsRecordVC.h"
#import "CLSHAccountBalanceModel.h"
#import "CLSHMerchantJoinModel.h"

//@1
#import "CLSHCertificationVC.h"
#import "CLSHHomeModel.h"

@interface CLGSAccountBalanceViewController ()
{
    CLSHAccountBalanceModel *accountBalanceModel; ///<账户余额数据模型
    
        CLSHHomeModel *cLSHHomeModel;


}
/**中间和下面label*/
@property (strong, nonatomic) IBOutlet UILabel *middleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *freezeLabel;
/** 约束 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *banlanceTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *withfrawalsHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomGeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *withdrawalsTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *withdrawalsWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *recordTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *recordHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label3Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label4Tap;

/**账户余额数值*/
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
/**申请提现按钮*/
@property (strong, nonatomic) IBOutlet UIButton *withdrawalsBtn;
/**账户余额*/
@property (strong, nonatomic) IBOutlet UILabel *accountBalance;
/**冻结余额*/
@property (strong, nonatomic) IBOutlet UILabel *accountFreeze;
/** 查看提现记录 */
@property (strong, nonatomic) IBOutlet UIButton *lookRecord;

@end

@implementation CLGSAccountBalanceViewController

#pragma mark - 修改字体
- (void)modify
{
    self.label3Tap.constant = 5*AppScale;
    self.label4Tap.constant = 5*AppScale;
    self.label1Tap.constant = 10*AppScale;
    self.label2Tap.constant = 10*AppScale;
    self.recordTap.constant = 20*AppScale;
    self.recordHeight.constant = 30*AppScale;
    self.iconWidth.constant = 105*AppScale;
    self.iconHeight.constant = 105*AppScale;
    
    self.middleHeight.constant = 50*AppScale;
    self.bottomGeight.constant = 50*AppScale;
    self.withdrawalsWidth.constant = 120*AppScale;
    self.withfrawalsHeight.constant = 40*AppScale;
    UIImage *select_img=[UIImage imageNamed:@"LookWithdrawalsRecord"];
    //不对图形进行渲染，ios7会自动对图形进行渲染
    select_img=[select_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.lookRecord setImage:select_img forState:UIControlStateNormal];

    self.lookRecord.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.lookRecord.imageEdgeInsets = UIEdgeInsetsMake(0, -10*AppScale, 0, 0);
    [self.lookRecord setTitleColor:systemColor forState:UIControlStateNormal];
    self.banlanceTap.constant = 15*AppScale;
    self.iconTap.constant = 50*AppScale;
    self.viewHeight.constant = 220*AppScale;
    //设置申请提现的button为圆角
    self.withdrawalsBtn.layer.cornerRadius = 3.0;
    self.withdrawalsBtn.layer.masksToBounds = YES;
    self.withdrawalsBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    //账户余额数值字体颜色
    self.accountLabel.font = [UIFont systemFontOfSize:22*AppScale];
    self.accountLabel.textColor = RGBColor(233, 0, 0);
    self.withdrawalsBtn.backgroundColor = RGBColor(0, 149, 68);
    
    self.middleLabel.backgroundColor = RGBColor(235, 235, 235);
    self.bottomLabel.backgroundColor = RGBColor(235, 235, 235);
    self.accountLabel.textColor = RGBColor(233, 0, 0);
    self.accountFreeze.font = [UIFont systemFontOfSize:13*AppScale];
    self.accountFreeze.textColor = RGBColor(204, 204, 204);
    self.freezeLabel.textColor = RGBColor(66, 66, 66);
    self.balanceLabel.textColor = RGBColor(66, 66, 66);
    self.balanceLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.freezeLabel.font = [UIFont systemFontOfSize:13*AppScale];
    
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    [self.navigationItem setTitle:@"账户余额"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self setNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    accountBalanceModel = [[CLSHAccountBalanceModel alloc] init];
    [accountBalanceModel fetchAccountBalanceData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            accountBalanceModel = result;

            NSString *balance = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[accountBalanceModel.balance floatValue]]];
            self.accountBalance.text=balance;

            NSString *free = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[accountBalanceModel.freezedBalance floatValue]]];
            self.accountFreeze.text=free;
            
            NSString *accountLabelStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:[accountBalanceModel.balance floatValue] + [accountBalanceModel.freezedBalance floatValue]]];
            self.accountLabel.text = accountLabelStr;
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <otherResponse>
//设置导航栏
- (void)setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalTitle:@"收支明细" selectTitle:@"收支明细" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:nil selectImage:nil target:self action:@selector(pushIncomeAndPay) size:CGSizeMake(80, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}

- (void)pushIncomeAndPay
{
    CLGSBalancePaymentsViewController *incomePayment = [[CLGSBalancePaymentsViewController alloc] init];
    incomePayment.title = @"收支明细";
    [self.navigationController pushViewController:incomePayment animated:YES];
}
//    infoParams[@"phoneNumber"] = @"18647703450";
//    infoParams[@"type"] = @(0);
//    infoParams[@"realname"] = @"1";
//    infoParams[@"idNumber"] = @"2";               ///<身份证号码
//    infoParams[@"phoneNumber"] = @"2";               ///<联系人电话
//    infoParams[@"areaId"] = @"2";                   ///<地区id
//    infoParams[@"address"] = @"2";
//申请提现
- (IBAction)withdrawBtn:(UIButton *)sender {
    NSString * status = [[NSUserDefaults standardUserDefaults] objectForKey:@"certification"];
    if ([status isEqualToString:@"success"]) {
        
        CLSHApplicationWithDrawalsVC *cLSHApplicationWithDrawalsVC=[CLSHApplicationWithDrawalsVC new];
        cLSHApplicationWithDrawalsVC.balance = [cLSHHomeModel.balance floatValue];
        cLSHApplicationWithDrawalsVC.notHomePage = YES;
        [self.navigationController pushViewController:
         cLSHApplicationWithDrawalsVC animated:YES];
    }else{
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您的身份尚未验证，请先实名认证" message: @"是否修改或编辑实名认证" preferredStyle:1];
        UIAlertAction *viewCancle = [UIAlertAction actionWithTitle:@"取消" style:1 handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *viewSure =  [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
            CLSHCertificationVC * certificationVC = [[CLSHCertificationVC alloc] init];
            [self.navigationController pushViewController:certificationVC animated:YES];
        }];
        
        [alert addAction:viewCancle];
        [alert addAction:viewSure];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }


}

//查看提现记录
- (IBAction)recordBtn:(UIButton *)sender {
    

    CLSHWithdrawalsRecordVC *recordVC = [[CLSHWithdrawalsRecordVC alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
    
    
}

@end
