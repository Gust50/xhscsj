//
//  CLSHRegistView.h
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

typedef void(^verificationCodeBlock)();
typedef void(^dismissBlock)();
typedef void(^goDelegateVCBlock)();

@protocol RegistButtonClickedDelegate <NSObject>

- (void)regist;

@end

@interface CLSHRegistView : UIView

@property (nonatomic,strong)UIView *navView;                        //!<nav
@property (nonatomic,strong)UIButton * BackButton;                  //!<返回键
@property (nonatomic,strong)UILabel * titleLabel;                   //!<title

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

@property (nonatomic,strong)UIView * SurePasswordView;              ///<确认密码View
@property (nonatomic,strong)UIImageView * SurePasswordIconView;     ///<确认密码图标
@property (nonatomic,strong)UITextField * SurePasswordTextField;    ///<确认密码输入框
@property (nonatomic,strong)UIView * SurePasswordBottomView;        ///<底部分割线

@property (nonatomic,strong)UIView * verificationView;              //!<验证View
@property (nonatomic,strong)UIImageView * verificatioIcon;          //!<验证头像
@property (nonatomic,strong)UITextField * verificatioCode;          //!<验证
@property (nonatomic,strong)KBLabel * verificationLabel;            //!<获取语音验证码
@property (nonatomic,strong)UIView * verificationBottomView;        ///<底部分割线

@property (nonatomic,strong)UIButton * regist;                      //!<注册按钮
@property (nonatomic,strong)UILabel * formerLabel;                  ///<固定文字
@property (nonatomic,strong)UILabel * delegateLabel;                ///<协议
@property (nonatomic,strong)UIImageView * backgroundImage;          //!<背景图

@property (nonatomic,copy)verificationCodeBlock verificationblock;
@property (nonatomic,copy)dismissBlock dismissblock;              //>!返回block
@property (nonatomic,copy)goDelegateVCBlock goDelegateVCblock;    ///<跳转粗粮协议block;
@property (nonatomic,weak)id <RegistButtonClickedDelegate> delegate;//delegate

@end
