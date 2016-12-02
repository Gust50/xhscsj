//
//  CLSHLoginView.h
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


#import <UIKit/UIKit.h>

@class KBLabel;

typedef void (^RegistBlock)();
typedef void (^forgetPwdBlock)();
typedef void(^dismissBlock)();

@protocol LoginButtonClickedDelegate <NSObject>

- (void)login;
@end

@interface CLSHLoginView : UIView

@property (nonatomic,strong)UIView *navView;//!>nav
@property (nonatomic,strong)UIButton * BackButton;//!>返回键
@property (nonatomic,strong)UILabel * titleLabel;//!>title

@property (nonatomic,strong)UIImageView * iconImageView;            ///<logo
@property (nonatomic,strong)UIView * accountView;                   ///<账号视图
@property (nonatomic,strong)UIImageView * accountIconView;          ///<账号图标
@property (nonatomic,strong)UITextField * accountTextField;         ///<账号输入框
@property (nonatomic,strong)UIView * accountBottomView;             ///<底部分割线

@property (nonatomic,strong)UIView * passwordView;                  ///<密码View
@property (nonatomic,strong)UIImageView * passwordIconView;         ///<密码图标
@property (nonatomic,strong)UITextField * passwordTextField;        ///<密码输入框
@property (nonatomic,strong)UIButton * seeButton;                   ///<密码是否可见Btn
@property (nonatomic,strong)UIView * passwordBottomView;            ///<底部分割线

@property (nonatomic,strong)UIView * loginButtonView;               ///<登录View
@property (nonatomic,strong)UIButton * loginButton;                 ///<登录按钮
@property (nonatomic,strong)KBLabel * registLabel;                  ///<注册label
@property (nonatomic,strong)KBLabel * forgetPasswordLabel;          ///忘记密码label

@property (nonatomic,strong)UIImageView * backImageView;            ///<背景图片View

@property (nonatomic,copy)RegistBlock regist;
@property (nonatomic,copy)forgetPwdBlock forget;
@property (nonatomic,strong)dismissBlock dismissblock;//>!返回block

@property (nonatomic,weak)id<LoginButtonClickedDelegate> delegate;

@end
