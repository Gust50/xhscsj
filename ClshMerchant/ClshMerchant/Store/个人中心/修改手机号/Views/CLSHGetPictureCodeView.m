//
//  CLSHGetPictureCodeView.m
//  ClshUser
//
//  Created by wutaobo on 16/8/17.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHGetPictureCodeView.h"

@interface CLSHGetPictureCodeView ()<UITextFieldDelegate>
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputLeft;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *reminderHeight;


@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIView *topView;


@property (strong, nonatomic) IBOutlet UIButton *cancelLabel;
@property (strong, nonatomic) IBOutlet UIButton *sureLabel;

@end
@implementation CLSHGetPictureCodeView

#pragma mark - modify
- (void)modify
{
    self.backViewWidth.constant = 250*AppScale;
    self.backViewHeight.constant = 115*AppScale;
    self.topViewTop.constant = 15*AppScale;
    self.topViewLeft.constant = 50*AppScale;
    self.topViewRight.constant = 50*AppScale;
    self.topViewHeight.constant = 25*AppScale;
    self.inputLeft.constant = 10*AppScale;
    self.reminderHeight.constant = 15*AppScale;
    self.backView.layer.cornerRadius = 5*AppScale;
    self.backView.layer.masksToBounds = YES;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.inputCode.borderStyle = UITextBorderStyleLine;
    self.inputCode.layer.borderColor = RGBColor(195, 195, 198).CGColor;
    self.inputCode.layer.borderWidth = 1;
    self.inputCode.font = [UIFont systemFontOfSize:12*AppScale];
    self.reminder.font = [UIFont systemFontOfSize:10*AppScale];
    self.cancelLabel.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.sureLabel.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.inputCode.delegate = self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self modify];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPassCode)];
    [self addGestureRecognizer:gesture];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - 屏幕上弹
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //键盘高度216
    
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.frame = CGRectMake(0.0f, -100.0f, SCREENWIDTH, SCREENHEIGHT);//64-216
    
    [UIView commitAnimations];
}

#pragma mark -屏幕恢复
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //滑动效果
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复屏幕
    self.frame = CGRectMake(0.0f, 0.0f, SCREENWIDTH, SCREENHEIGHT);//64-216
    
    [UIView commitAnimations];
}

//切换图片
- (IBAction)changePicture:(UIButton *)sender {
    
    if (self.changePictureBlock) {
        self.changePictureBlock();
    }
}
//取消
- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}
//确定
- (IBAction)sure:(UIButton *)sender {
    
    
    if (self.inputCode.text.length!=0) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"code"] = self.inputCode.text;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postCode" object:nil userInfo:dic];
        
        sleep(1);
        if (self.getPhoneCodeBlock) {
            self.getPhoneCodeBlock();
        }
    }else{
        
        [MBProgressHUD showError:@"验证码不能为空"];
    }
    
    
}

//移除视图
- (void)cancelPassCode
{
    [self removeFromSuperview];
}

@end
