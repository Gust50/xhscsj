//
//  CLGSApplicationSuccessController.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/26.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSApplicationSuccessController.h"
#import "CLGSAccountBalanceViewController.h"

@interface CLGSApplicationSuccessController ()
/** 约束 */
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *completeHeight;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;


@property (strong, nonatomic) IBOutlet UIView *backgroundV;
//完成按钮
@property (strong, nonatomic) IBOutlet UIButton *complete;
@end

@implementation CLGSApplicationSuccessController

#pragma mark - 修改字体
- (void)modify
{
    self.iconWidth.constant = 80*AppScale;
    self.iconHeight.constant = 80*AppScale;
    self.viewHeight.constant = 45*AppScale;
    self.completeHeight.constant = 40*AppScale;
    self.countLabel.font = [UIFont systemFontOfSize:16*AppScale];
    self.complete.titleLabel.font = [UIFont systemFontOfSize:16*AppScale];
    
    self.rightLabel.font = [UIFont systemFontOfSize:17*AppScale];
    self.rightLabel.textColor = RGBColor(233, 0, 0);
    
    //设置view的背景色
    self.backgroundV.backgroundColor = RGBColor(237, 237, 237);
    
    //设置圆角
    self.complete.layer.cornerRadius = 5.0;
    self.complete.layer.masksToBounds = YES;
    self.complete.backgroundColor = RGBColor(0, 149, 68);
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear: animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear: animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modify];
    [self.navigationItem setTitle:@"提交成功"];
    
    NSString *moneyStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithInteger:[_money integerValue]]];
    _rightLabel.text = moneyStr;
}

#pragma mark <otherResponse>
- (IBAction)successBtn:(UIButton *)sender {
    //返回到指定控制器
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[CLGSAccountBalanceViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    if (self.notHomePage) {
        CLGSAccountBalanceViewController * balanceVC = [[CLGSAccountBalanceViewController alloc] init];
        [self.navigationController popToViewController:balanceVC animated:YES];
    }else{
    
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - setter getter
-(void)setMoney:(NSString *)money
{
    _money = money;
}

- (void)setNotHomePage:(BOOL)notHomePage{

    _notHomePage = notHomePage;
}

@end
