//
//  CLSHRegistView.m
//  ClshMerchant
//
//  Created by arom on 16/7/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHRegistView.h"
#import "KBLabel.h"
#import "KBRegexp.h"
#import "KBTimer.h"
#import "CLSHRegistModel.h"
#import "CLSHGetPictureCodeView.h"
#import "CLSHGetPictureCodeModel.h"

@interface CLSHRegistView()<UITextFieldDelegate>{

    BOOL canSee;
    CLSHGetPictureCodeModel *pictureModel;          ///<获取图片验证码数据模型
    CLSHVerifyPictureCodeModel *verifyPictureCodeModel;///<验证图片验证码数据模型
    NSMutableDictionary *param;                    ///<传入参数手机号
    NSString *code;
}

@property (nonatomic, strong)CLSHGetPictureCodeView *getPictureCodeView;     ///<图片验证码视图

@end
@implementation CLSHRegistView

#pragma mark --懒加载

- (UIView *)navView{
    
    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (UIButton *)BackButton{
    
    if (!_BackButton) {
        _BackButton = [[UIButton alloc] init];
        [_BackButton setImage:[UIImage imageNamed:@"Arrow"] forState:(UIControlStateNormal)];
        [_BackButton setTitle:@" 返回" forState:(UIControlStateNormal)];
        [_BackButton setTitleColor:systemColor forState:(UIControlStateNormal)];
        _BackButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_BackButton addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
        [_BackButton setTitleColor:systemColor forState:(UIControlStateNormal)];
    }
    return _BackButton;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = systemColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"注册";
        _titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _titleLabel;
}


- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"logo"];
    }
    return _iconImageView;
}

- (UIView *)accountView{
    
    if (!_accountView) {
        _accountView = [[UIView alloc] init];
    }
    return _accountView;
}

- (UIImageView *)accountIconView{
    
    if (!_accountIconView) {
        _accountIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Account"]];
    }
    return _accountIconView;
}

- (UITextField *)accountTextField{
    
    if (!_accountTextField) {
        _accountTextField = [[UITextField alloc] init];
        _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountTextField.placeholder = @"请输入号码";
        _accountTextField.textColor = systemColor;
        _accountTextField.delegate = self;
        _accountTextField.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _accountTextField;
}

- (UIView *)accountBottomView{
    
    if (!_accountBottomView) {
        _accountBottomView = [[UIView alloc] init];
        _accountBottomView.backgroundColor = backGroundColor;
    }
    return _accountBottomView;
}

- (UIView *)passwordView{
    
    if (!_passwordView) {
        _passwordView = [[UIView alloc] init];
    }
    return _passwordView;
}

- (UIImageView *)passwordIconView{
    
    if (!_passwordIconView) {
        _passwordIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Password"]];
    }
    return _passwordIconView;
}

- (UITextField *)passwordTextField{
    
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.textColor = systemColor;
        _passwordTextField.font = [UIFont systemFontOfSize:14*AppScale];
        canSee = NO;
    }
    return _passwordTextField;
}

- (UIButton *)seeButton{
    
    if (!_seeButton) {
        _seeButton = [[UIButton alloc] init];
        [_seeButton setImage:[UIImage imageNamed:@"EyeIcon"] forState:(UIControlStateNormal)];
        [_seeButton addTarget:self action:@selector(canSeePWD) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _seeButton;
}

- (UIView *)passwordBottomView{
    
    if (!_passwordBottomView) {
        _passwordBottomView = [[UIView alloc] init];
        _passwordBottomView.backgroundColor = backGroundColor;
    }
    return _passwordBottomView;
}

- (UIView *)SurePasswordView{
    
    if (!_SurePasswordView) {
        _SurePasswordView = [[UIView alloc] init];
    }
    return _SurePasswordView;
}

- (UIImageView *)SurePasswordIconView{
    
    if (!_SurePasswordIconView) {
        _SurePasswordIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Password"]];
    }
    return _SurePasswordIconView;
}

- (UITextField *)SurePasswordTextField{
    
    if (!_SurePasswordTextField) {
        _SurePasswordTextField = [[UITextField alloc] init];
        _SurePasswordTextField.placeholder = @"请确认密码";
        _SurePasswordTextField.secureTextEntry = YES;
        _SurePasswordTextField.textColor = systemColor;
        _SurePasswordTextField.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _SurePasswordTextField;
}

- (UIView *)SurePasswordBottomView{
    
    if (!_SurePasswordBottomView) {
        _SurePasswordBottomView = [[UIView alloc] init];
        _SurePasswordBottomView.backgroundColor = backGroundColor;
    }
    return _SurePasswordBottomView;
}


- (UIView *)verificationView{

    if (!_verificationView) {
        _verificationView = [[UIView alloc]init];
    }
    return _verificationView;
}

- (UIImageView *)verificatioIcon{

    if (!_verificatioIcon) {
        _verificatioIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VerificationCodeIcon"]];
    }
    return _verificatioIcon;
}

- (UITextField *)verificatioCode{

    if (!_verificatioCode) {
        _verificatioCode = [[UITextField alloc] init];
        _verificatioCode.placeholder = @"请输入验证码";
        _verificatioCode.textColor = systemColor;
        _verificatioCode.font = [UIFont systemFontOfSize:14*AppScale];
    }
    return _verificatioCode;
}

- (KBLabel *)verificationLabel{

    if (!_verificationLabel) {
        _verificationLabel = [[KBLabel alloc] init];
        _verificationLabel.text = @"获取语音验证码";
        _verificationLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _verificationLabel.textColor = systemColor;
        _verificationLabel.type = bottomLine;
        _verificationLabel.lineColor = systemColor;
        _verificationLabel.labelFont = [UIFont systemFontOfSize:12*AppScale];
        _verificationLabel.textAlignment = NSTextAlignmentCenter;
        _verificationLabel.userInteractionEnabled = YES;
    }
    return _verificationLabel;
}

- (UIView *)verificationBottomView{

    if (!_verificationBottomView) {
        _verificationBottomView = [[UIView alloc] init];
        _verificationBottomView.backgroundColor = backGroundColor;
    }
    return _verificationBottomView;
}

- (UIButton *)regist{

    if (!_regist) {
        _regist = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_regist setTitle:@"注册" forState:(UIControlStateNormal)];
        [_regist setBackgroundColor:systemColor];
        [_regist setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _regist.layer.masksToBounds = YES;
        _regist.layer.cornerRadius = 5*AppScale;
        [_regist addTarget:self action:@selector(registAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _regist;
}

- (UILabel *)formerLabel{

    if (!_formerLabel) {
        _formerLabel = [[UILabel alloc] init];
        _formerLabel.text = @"注册即是同意 ";
        _formerLabel.textColor = [UIColor blackColor];
        _formerLabel.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _formerLabel;
}

- (UILabel *)delegateLabel{

    if (!_delegateLabel) {
        _delegateLabel = [[UILabel alloc] init];
        _delegateLabel.text = @"《嗅虎商城服务协议》";
        _delegateLabel.textColor = systemColor;
        _delegateLabel.font = [UIFont systemFontOfSize:12*AppScale];
        
        
        //@1交互修改
        _delegateLabel.userInteractionEnabled = NO;
    }
    return _delegateLabel;
}

- (UIImageView *)backgroundImage{
    
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BottomBackground"]];
        _backgroundImage.userInteractionEnabled = YES;
    }
    return _backgroundImage;
}

#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame] ) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
        
        pictureModel = [[CLSHGetPictureCodeModel alloc] init];
        param = [NSMutableDictionary dictionary];
        verifyPictureCodeModel = [[CLSHVerifyPictureCodeModel alloc] init];
        
        //图片验证码视图
        self.getPictureCodeView =[[[NSBundle mainBundle]loadNibNamed:@"CLSHGetPictureCodeView" owner:self options:nil]lastObject];
        self.getPictureCodeView.backgroundColor = RGBAColor(0, 0, 0, 0.7);
        self.getPictureCodeView.frame=[UIScreen mainScreen].bounds;
        self.getPictureCodeView.reminder.text = @"";
        self.getPictureCodeView.inputCode.text = @"";
        WS(weakSelf);
        self.getPictureCodeView.changePictureBlock = ^(){
            [weakSelf getPictureCodeEven];
        };
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCode:) name:@"postCode" object:nil];
    }
    return self;
}

- (void)receiveCode:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    code = dic[@"code"];
    NSLog(@"---------%@", code);
}

- (void)initUI{

    [self addSubview:self.backgroundImage];
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.navView];
    [_navView addSubview:self.BackButton];
    [_navView addSubview:self.titleLabel];
    
    [self addSubview:self.accountView];
    [_accountView addSubview:self.accountIconView];
    [_accountView addSubview:self.accountTextField];
    [_accountView addSubview:self.accountBottomView];
    
    [self addSubview:self.passwordView];
    [_passwordView addSubview:self.passwordIconView];
    [_passwordView addSubview:self.passwordTextField];
    [_passwordView addSubview:self.seeButton];
    [_passwordView addSubview:self.passwordBottomView];
    
    [self addSubview:self.SurePasswordView];
    [_SurePasswordView addSubview:self.SurePasswordIconView];
    [_SurePasswordView addSubview:self.SurePasswordTextField];
    [_SurePasswordView addSubview:self.SurePasswordBottomView];
    
    [self addSubview:self.verificationView];
    [_verificationView addSubview:self.verificatioIcon];
    [_verificationView addSubview:self.verificatioCode];
    [_verificationView addSubview:self.verificationLabel];
    [_verificationView addSubview:self.verificationBottomView];
    
    [self addSubview:self.regist];
    [self addSubview:self.formerLabel];
    [self addSubview:self.delegateLabel];
    
    //添加手势
    UITapGestureRecognizer * tapRegistLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getVerification)];
    [self.verificationLabel addGestureRecognizer:tapRegistLabel];
    
    UITapGestureRecognizer * tapDelegateLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goDelegateVC)];
    [self.delegateLabel addGestureRecognizer:tapDelegateLabel];
    
    [self updateConstraints];
    
    
}

- (void)canSeePWD{
    
    if (canSee) {
        _passwordTextField.secureTextEntry = NO;
        canSee = NO;
    }else{
        
        _passwordTextField.secureTextEntry = YES;
        canSee = YES;
    }
}

- (void)dismiss{
    
    if (self.dismissblock) {
        
        self.dismissblock();
    }
}

- (void)getVerification{//定时器
    
    if ([KBRegexp checkPhoneNumInput:_accountTextField.text]) {
        [[[UIApplication sharedApplication]keyWindow]addSubview:self.getPictureCodeView];
        self.getPictureCodeView.inputCode.text = @"";
        [self getPictureCodeEven];
        
        WS(weakSelf);
        self.getPictureCodeView.getPhoneCodeBlock = ^(){
            [weakSelf verifyPictureCode];
        };
    }else{
        
        [MBProgressHUD showError:@"手机号码有误!"];
    }

}

//获取图片验证码
- (void)getPictureCodeEven
{
    param[@"phoneNum"] = _accountTextField.text;
    [pictureModel fetchAccountGetPictureCodeModel:param callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            UIImage *img=result;
            [self.getPictureCodeView.picture setBackgroundImage:img forState:0];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//验证图片验证码
- (void )verifyPictureCode
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"captchaNo"] = code;
    dic[@"captchaId"] = _accountTextField.text;
    [verifyPictureCodeModel fetchAccountVerifyPictureCodeModel:dic callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            verifyPictureCodeModel = result;
            if (verifyPictureCodeModel.isValid) {
                self.getPictureCodeView.reminder.text = @"";
                [self.getPictureCodeView removeFromSuperview];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5)*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self phoneCode];
                });
                
            }else
            {
                self.getPictureCodeView.reminder.text = @"验证码错误！";
                self.getPictureCodeView.inputCode.text = @"";
                [self getPictureCodeEven];
            }
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

//发送手机验证码
- (void)phoneCode
{
    if ([KBRegexp checkPhoneNumInput:_accountTextField.text]) {
        self.verificationblock();
        KBTimer *tiemr=[[KBTimer alloc]init];
        [tiemr countDown:_verificationLabel];
    }else{
        
        [MBProgressHUD showError:@"手机号码有误!"];
    }
}

- (void)registAction{

    if (self.delegate && [self respondsToSelector:@selector(regist)]) {
        
        [self.delegate regist];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    if (textField.text.length == 11) {
        
        __block CLSHtelephoneVerifyModel * verifyModel = [[CLSHtelephoneVerifyModel alloc] init];
        
//        [verifyModel FetchTelePhoneIsregistedData:textField.text callBack:^(BOOL isSuccess, id  _Nonnull result) {
//            
//            if (isSuccess) {
//                verifyModel = result;
//                if (verifyModel.isOccupy) {
//                    
//                }else{
//                    
//                    [MBProgressHUD showError:@"该账号已存在"];
//                }
//            }
//            
//        }];
    }
    
    return YES;
}

- (void)goDelegateVC{

    if (self.goDelegateVCblock) {
        self.goDelegateVCblock();
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    
    [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.equalTo(@64);
    }];
    
    [_BackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_navView.mas_left).with.offset(8);
        make.bottom.equalTo(_navView.mas_bottom).with.offset(0);
        make.top.equalTo(_navView.mas_top).with.offset(20);
        make.width.mas_equalTo(@(40*AppScale));
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_navView.mas_centerX);
        make.top.equalTo(_navView.mas_top).with.offset(20);
        make.bottom.equalTo(_navView.mas_bottom).with.offset(0);
        make.width.equalTo(@100);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_navView.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@(90*AppScale));
        make.width.equalTo(@(150*AppScale));
        
    }];
    
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(_iconImageView.mas_bottom).with.offset(30*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.height.equalTo(@(40*AppScale));
    }];
    
    [_accountIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_accountView.mas_left).with.offset(8*AppScale);
        make.centerY.equalTo(_accountView.mas_centerY);
        make.height.equalTo(@(15*AppScale));
        make.width.equalTo(@(15*AppScale));
    }];
    
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_accountIconView.mas_right).with.offset(8*AppScale);
        make.centerY.equalTo(_accountView.mas_centerY);
        make.right.equalTo(_accountView.mas_right).with.offset(-8*AppScale);
        make.height.equalTo(@(30*AppScale));
    }];
    
    [_accountBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_accountView.mas_left).with.offset(8*AppScale);
        make.right.equalTo(_accountView.mas_right).with.offset(-8*AppScale);
        make.bottom.equalTo(_accountView.mas_bottom).with.offset(-1*AppScale);
        make.height.equalTo(@1);
    }];
    
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(_accountView.mas_bottom).with.offset(20*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.height.equalTo(@(40*AppScale));
    }];
    
    [_passwordIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_passwordView.mas_left).with.offset(8*AppScale);
        make.centerY.equalTo(_passwordView.mas_centerY);
        make.height.equalTo(@(15*AppScale));
        make.width.equalTo(@(15*AppScale));
    }];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_passwordIconView.mas_right).with.offset(8*AppScale);
        make.centerY.equalTo(_passwordView.mas_centerY);
        make.right.equalTo(_passwordView.mas_right).with.offset(-40*AppScale);
        make.height.equalTo(@(30*AppScale));
    }];
    
    [_seeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_passwordTextField.mas_right).with.offset(0);
        make.right.equalTo(_passwordView.mas_right).with.offset(-8*AppScale);
        make.centerY.equalTo(_passwordView.mas_centerY);
        make.height.equalTo(@(30*AppScale));
    }];
    
    [_passwordBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_passwordView.mas_left).with.offset(8*AppScale);
        make.right.equalTo(_passwordView.mas_right).with.offset(-8*AppScale);
        make.bottom.equalTo(_passwordView.mas_bottom).with.offset(-1*AppScale);
        make.height.equalTo(@1);
    }];
    
    [_SurePasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(_passwordView.mas_bottom).with.offset(20*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.height.equalTo(@(40*AppScale));
    }];
 
    [_SurePasswordIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_SurePasswordView.mas_left).with.offset(8*AppScale);
        make.centerY.equalTo(_SurePasswordView.mas_centerY);
        make.height.equalTo(@(15*AppScale));
        make.width.equalTo(@(15*AppScale));
    }];
    
    [_SurePasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_SurePasswordIconView.mas_right).with.offset(8*AppScale);
        make.centerY.equalTo(_SurePasswordView.mas_centerY);
        make.right.equalTo(_SurePasswordView.mas_right).with.offset(-8*AppScale);
        make.height.equalTo(@(30*AppScale));
    }];
    
    [_SurePasswordBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_SurePasswordView.mas_left).with.offset(8*AppScale);
        make.right.equalTo(_SurePasswordView.mas_right).with.offset(-8*AppScale);
        make.bottom.equalTo(_SurePasswordView.mas_bottom).with.offset(-1*AppScale);
        make.height.equalTo(@1);
    }];
    
    [_verificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(_SurePasswordView.mas_bottom).with.offset(20*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.height.equalTo(@(40*AppScale));
    }];
    
    [_verificatioIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_verificationView.mas_left).with.offset(8*AppScale);
        make.centerY.equalTo(_verificationView.mas_centerY);
        make.height.equalTo(@(15*AppScale));
        make.width.equalTo(@(15*AppScale));
    }];
    
    [_verificatioCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_verificatioIcon.mas_right).with.offset(8*AppScale);
        make.right.equalTo(_verificationLabel.mas_left).with.offset(-8*AppScale);
        make.centerY.equalTo(_verificationView.mas_centerY);
        make.height.equalTo(@(30*AppScale));
    }];
    
    [_verificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_verificationView.mas_right).with.offset(-8*AppScale);
        make.centerY.equalTo(weakSelf.verificationView.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(110*AppScale));
    }];
    
    [_verificationBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_verificationView.mas_left).with.offset(8*AppScale);
        make.right.equalTo(_verificationView.mas_right).with.offset(-8*AppScale);
        make.bottom.equalTo(_verificationView.mas_bottom).with.offset(-1*AppScale);
        make.height.equalTo(@1);
    }];
    
    [_regist mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(28*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-28*AppScale);
        make.top.equalTo(_verificationView.mas_bottom).with.offset(20*AppScale);
        make.height.equalTo(@(40*AppScale));
    }];
    
    [_formerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(28*AppScale);
        make.top.equalTo(_regist.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(75*AppScale));
    }];
    
    [_delegateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_formerLabel.mas_right).with.offset(0);
        make.top.equalTo(_regist.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.right.equalTo(weakSelf.mas_right).with.offset(-28*AppScale);
    }];
    
    [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(SCREENHEIGHT/3));
        
    }];
}


@end
