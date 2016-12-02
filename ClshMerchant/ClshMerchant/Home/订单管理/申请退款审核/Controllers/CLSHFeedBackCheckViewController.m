//
//  CLSHFeedBackCheckViewController.m
//  ClshMerchant
//
//  Created by arom on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHFeedBackCheckViewController.h"
#import "CLSHApplicationForRefundModel.h"

@interface CLSHFeedBackCheckViewController ()<UITextViewDelegate>
{
    CLSHApplicationForRefundModel *refundModel;         ///<退款审核
    NSMutableDictionary *params;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *applyTimeLabelWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *feedBackReasonLabelWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passButtonMarginTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passButtonMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passButtonMarginNotBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBtnMarginTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomBtnMarginRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBtnMarginLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBtnHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;

@property (weak, nonatomic) IBOutlet UIButton *passButton;
@property (weak, nonatomic) IBOutlet UIButton *notPassButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak, nonatomic) IBOutlet UILabel *applyTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedBackLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;

@property(nonatomic,strong)UILabel *placeHolderLabel;

@end

@implementation CLSHFeedBackCheckViewController

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

#pragma mark --重写UI约束
- (void)reWriteUI{

    self.applyTimeLabelWidth.constant = 64*AppScale;
    self.feedBackReasonLabelWidth.constant = 64*AppScale;
    self.passButtonMarginTop.constant = 20*AppScale;
    self.passButtonMarginLeft.constant = SCREENWIDTH/7;
    self.passButtonWidth.constant = SCREENWIDTH*2/7;
    self.passButtonMarginNotBtn.constant = SCREENWIDTH/7;
    self.textViewMarginTop.constant = 30*AppScale;
    self.textViewMarginLeft.constant = 30*AppScale;
    self.textViewMarginRight.constant = 30*AppScale;
    self.textViewMarginBottom.constant = 30*AppScale;
    self.bottomBtnMarginTop.constant = 30*AppScale;
    self.bottomBtnMarginLeft.constant = 30*AppScale;
    self.BottomBtnMarginRight.constant = 30*AppScale;
    self.bottomBtnHeight.constant = 40*AppScale;
    self.ViewHeight.constant = 350*AppScale;
    
    self.passButton.layer.masksToBounds = YES;
    self.passButton.layer.cornerRadius = 20;
    self.notPassButton.layer.masksToBounds = YES;
    self.notPassButton.layer.cornerRadius = 20;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5;
    self.bottomButton.layer.masksToBounds = YES;
    self.bottomButton.layer.cornerRadius = 10;
    self.applyTimeLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.feedBackLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.passButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.notPassButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.textView.font = [UIFont systemFontOfSize:13*AppScale];
    self.bottomButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.timeLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.reasonLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.passButton.layer.borderColor = systemColor.CGColor;
    self.passButton.layer.borderWidth = 1;
    self.notPassButton.layer.borderColor = systemColor.CGColor;
    self.notPassButton.layer.borderWidth = 1;
    self.notPassButton.selected = YES;
    self.notPassButton.backgroundColor = systemColor;
    self.passButton.backgroundColor = [UIColor whiteColor];
    [self.passButton setTitleColor:systemColor forState:(UIControlStateNormal)];

    [self.notPassButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [self.textView addSubview:self.placeHolderLabel];
    self.textView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reWriteUI];
    self.navigationItem.title = @"审核";
    refundModel = [CLSHApplicationForRefundModel new];
    params = [NSMutableDictionary dictionary];
    params[@"userid"] = [FetchAppPublicKeyModel shareAppPublicKeyManager].infoModel.userId;
    params[@"isPass"] = @"false";
    
}

#pragma mark -- textViewFeild delegate
- (void)textViewDidChange:(UITextView*)textView{
    
    if([textView.text length] == 0){
        
        _placeHolderLabel.text = @"请填写不给予通过的理由...";
        
    }else{
        
        _placeHolderLabel.text = @"";//这里给空
    }
}

//通过或者不通过
- (IBAction)passOrNoPass:(UIButton *)sender {
    
    if (sender.tag == 1) {
        params[@"isPass"] = @"true";
        self.passButton.backgroundColor = systemColor;
        self.notPassButton.backgroundColor = [UIColor whiteColor];
        [self.notPassButton setTitleColor:systemColor forState:(UIControlStateNormal)];
        [self.passButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }else
    {
        params[@"isPass"] = @"false";
        self.notPassButton.backgroundColor = systemColor;
        self.passButton.backgroundColor = [UIColor whiteColor];
        [self.passButton setTitleColor:systemColor forState:(UIControlStateNormal)];
        
        [self.notPassButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }
}

//确认
- (IBAction)sure:(id)sender {
    
    params[@"reason"] = self.textView.text;
    params[@"sn"] = self.sn;
    [refundModel fetchCLSHApplicationForRefundModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
    
}

#pragma mark - setter getter
-(void)setSn:(NSString *)sn
{
    _sn = sn;
}

@end
