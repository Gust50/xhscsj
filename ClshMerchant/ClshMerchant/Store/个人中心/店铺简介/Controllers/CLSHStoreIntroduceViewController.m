//
//  CLSHStoreIntroduceViewController.m
//  ClshMerchant
//
//  Created by arom on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHStoreIntroduceViewController.h"
#import "CLSHStoreUpdateModel.h"

@interface CLSHStoreIntroduceViewController ()<UITextViewDelegate>
{
    CLSHStoreUpdateIntroductionModel *updateIntroductionModel;  ///<店铺简介数据模型
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginBootom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *describeLabelMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *describleLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonMarginRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttomHeight;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *motifyButton;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@property(nonatomic,strong)UILabel *placeHolderLabel;

@end

@implementation CLSHStoreIntroduceViewController

#pragma mark --懒加载
- (UILabel *)placeHolderLabel{
    
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,-15,SCREENWIDTH-(8+10+80+10)*AppScale,60)];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _placeHolderLabel.text = @"请填写不给予通过的理由...";
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.backgroundColor =[UIColor clearColor];
    }
    return _placeHolderLabel;
}
#pragma mark --更新约束
- (void)motifyConstrants{

    self.contentViewMarginTop.constant = 64+10*AppScale;
    self.contentViewHeight.constant = 300*AppScale;
    self.secondViewHeight.constant = 150*AppScale;
    self.textViewMarginBootom.constant = 15*AppScale;
    self.textViewMarginTop.constant = 15*AppScale;
    self.textViewMarginLeft.constant = 10*AppScale;
    self.textViewMarginRight.constant = 10*AppScale;
    self.describeLabelMarginTop.constant = 10*AppScale;
    self.describleLabelHeight.constant = 20*AppScale;
    self.buttonMarginTop.constant = 20*AppScale;
    self.buttonMarginRight.constant = 10*AppScale;
    self.buttonMarginLeft.constant = 10*AppScale;
    self.buttomHeight.constant = 40*AppScale;
    
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5*AppScale;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = RGBColor(219, 218, 219).CGColor;
    self.motifyButton.layer.masksToBounds = YES;
    self.motifyButton.layer.cornerRadius = 5*AppScale;
    
    self.textView.font = [UIFont systemFontOfSize:12*AppScale];
    self.motifyButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.describeLabel.font = [UIFont systemFontOfSize:10*AppScale];
    
//    [self.textView addSubview:self.placeHolderLabel];
    self.textView.delegate = self;
}

#pragma mark --life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //更新约束
    [self motifyConstrants];
    self.navigationItem.title = @"店铺简介";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.text = self.intro;
    
    updateIntroductionModel = [[CLSHStoreUpdateIntroductionModel alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}

//确认修改
- (IBAction)confimUpdate:(UIButton *)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"introduction"] = self.textView.text;
    params[@"shopId"] = self.shopId;
    [updateIntroductionModel fetchStoreUpdateIntroductionData:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}


#pragma mark -- textViewFeild delegate
//- (void)textViewDidChange:(UITextView*)textView{
//    
//    if([textView.text length] == 0 && [textView.text isEqualToString:@""]){
//        
//        _placeHolderLabel.text = @"请填写不给予通过的理由...";
//        
//    }else{
//        
//        _placeHolderLabel.text = @"";//这里给空
//        
//    }
//}

#pragma mark - setter getter
-(void)setIntro:(NSString *)intro
{
    _intro = intro;
}

-(void)setShopId:(NSString *)shopId
{
    _shopId = shopId;
}

@end
