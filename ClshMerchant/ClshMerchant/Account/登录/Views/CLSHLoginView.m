//
//  CLSHLoginView.m
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


#import "CLSHLoginView.h"
#import "KBLabel.h"

@interface CLSHLoginView (){

    BOOL canSee;
}

@end

@implementation CLSHLoginView

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
        _titleLabel.text = @"登录";
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

- (UIView *)loginButtonView{

    if (!_loginButtonView) {
        _loginButtonView = [[UIView alloc] init];
    }
    return _loginButtonView;
}

- (UIButton *)loginButton{

    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        //[_loginButton setAttributedTitle:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15*AppScale],NSFontAttributeName, nil] forState:(UIControlStateNormal)];
        _loginButton.backgroundColor = systemColor;
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 5*AppScale;
        [_loginButton addTarget:self action:@selector(buttonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginButton;
}

-(KBLabel *)registLabel{

    if (!_registLabel) {
        _registLabel = [[KBLabel alloc] init];
        _registLabel.text = @"注册";
        _registLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _registLabel.textColor = RGBColor(47, 177, 95);
        _registLabel.type = bottomLine;
        _registLabel.lineColor = RGBColor(47, 177, 95);
        _registLabel.labelFont = [UIFont systemFontOfSize:14*AppScale];
        _registLabel.textAlignment = NSTextAlignmentCenter;
        _registLabel.userInteractionEnabled = YES;
    }
    return _registLabel;
}

- (KBLabel *)forgetPasswordLabel{

    if (!_forgetPasswordLabel) {
        _forgetPasswordLabel = [[KBLabel alloc] init];
        _forgetPasswordLabel.text = @"忘记密码";
        _forgetPasswordLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _forgetPasswordLabel.textColor = RGBColor(47, 177, 95);
        _forgetPasswordLabel.type = bottomLine;
        _forgetPasswordLabel.lineColor = RGBColor(47, 177, 95);
        _forgetPasswordLabel.labelFont = [UIFont systemFontOfSize:14*AppScale];
        _forgetPasswordLabel.textAlignment = NSTextAlignmentCenter;
        _forgetPasswordLabel.userInteractionEnabled = YES;
    }
    return _forgetPasswordLabel;
}


- (UIImageView *)backImageView{

    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BottomBackground"]];
    }
    return _backImageView;
}

#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame] ) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.backImageView];
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.navView];
//    [_navView addSubview:self.BackButton];
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
    
    [self addSubview:self.loginButtonView];
    [_loginButtonView addSubview:self.loginButton];
    [_loginButtonView addSubview:self.registLabel];
    [_loginButtonView addSubview:self.forgetPasswordLabel];
    
    //添加手势
    UITapGestureRecognizer * tapRegistLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoRegisterVC)];
    [self.registLabel addGestureRecognizer:tapRegistLabel];
    
    UITapGestureRecognizer * tapForgetLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoForgetPwdVC)];
    [self.forgetPasswordLabel addGestureRecognizer:tapForgetLabel];
    
    [self updateConstraints];
}

- (void)gotoRegisterVC{
    
    self.regist();
}

- (void)gotoForgetPwdVC{
    self.forget();
}

- (void)dismiss{
    
    self.dismissblock();
    
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
        make.height.equalTo(@(50*AppScale));
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
        make.height.equalTo(@(1));
    }];
    
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(_accountView.mas_bottom).with.offset(20*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.height.equalTo(@(50*AppScale));
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
        make.height.equalTo(@(1));
    }];
    
    [_loginButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
        make.top.equalTo(_passwordView.mas_bottom).with.offset(40*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
        make.height.equalTo(@(90*AppScale));
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_loginButtonView.mas_left).with.offset(8*AppScale);
        make.top.equalTo(_loginButtonView.mas_top).with.offset(10*AppScale);
        make.right.equalTo(_loginButtonView.mas_right).with.offset(-8*AppScale);
        make.height.equalTo(@(40*AppScale));
    }];
    
    [_registLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginButtonView.mas_left).with.offset(15*AppScale);
        make.top.equalTo(_loginButton.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(40*AppScale));
    }];
    
    [_forgetPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_loginButtonView.mas_right).with.offset(-15*AppScale);
        make.top.equalTo(_loginButton.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(80*AppScale));
        
    }];
    
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@(SCREENHEIGHT/3));

    }];
    
    
}

- (void)buttonClicked{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(login)]) {
        [self.delegate login];
    }
}






@end
