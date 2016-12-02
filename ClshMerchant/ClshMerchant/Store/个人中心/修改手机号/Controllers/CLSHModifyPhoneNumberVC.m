//
//  CLSHModifyPhoneNumberVC.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHModifyPhoneNumberVC.h"
#import "CLSHBindNewPhoneNumberVC.h"
#import "CLSHModifyPhoneNumModel.h"
#import "KBTimer.h"
#import "KBLabel.h"
#import "CLSHGetPictureCodeView.h"
#import "CLSHGetPictureCodeModel.h"

@interface CLSHModifyPhoneNumberVC ()
{
    CLSHPhoneNumModel *phoneNumModel;    ///<获取手机号码数据模型
    CLSHAccountCheckTokenModel *checkTokenModel;    ///<验证验证码数据模型
    BOOL isReceiveCode; ///<判断是否收到验证码
    NSString *oldToken; ///<保存输入的验证码
    
    CLSHGetPictureCodeModel *pictureModel;          ///<获取图片验证码数据模型
    CLSHVerifyPictureCodeModel *verifyPictureCodeModel;///<验证图片验证码数据模型
    NSMutableDictionary *param;                    ///<传入参数手机号
    NSString *code;                                 //<图片验证码字符
    
}
@property (nonatomic, strong)CLSHGetPictureCodeView *getPictureCodeView;     ///<图片验证码视图

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberLabelTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberLabelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numberHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *codeLabelWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *codeLabelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getCodeWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *getCodeHeight;
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *verTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *verHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *numHeight;



/** 绑定手机号label */
@property (strong, nonatomic) IBOutlet UILabel *bindIphoneLabel;
/** 手机号码 */
@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;
/** 输入验证码 */
@property (strong, nonatomic) IBOutlet UITextField *inputCode;
/** 获取语音验证码 */
@property (strong, nonatomic) IBOutlet UILabel *getCode;
/** 验证 */
@property (strong, nonatomic) IBOutlet UIButton *verification;
/** 描述 */
@property (strong, nonatomic) IBOutlet UILabel *describe;
/** 客服电话 */
@property (strong, nonatomic) IBOutlet UIButton *customerServiceNumber;



@end

@implementation CLSHModifyPhoneNumberVC

#pragma mark - 修改字体
- (void)modifyStyle
{
    self.numTap.constant = 0;
    self.numHeight.constant = 40*AppScale;
    self.describeTap.constant = 50*AppScale;
    self.describeHeight.constant = 21*AppScale;
    self.verTap.constant = 40*AppScale;
    self.verHeight.constant = 40*AppScale;
    
    self.codeLabelHeight.constant = 21*AppScale;
    self.codeLabelWidth.constant = 60*AppScale;
    self.getCodeWidth.constant = 90*AppScale;
    self.getCodeHeight.constant = 30*AppScale;
    self.bindIphoneLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.phoneNumber.font = [UIFont systemFontOfSize:20*AppScale];
    self.codeLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.numberTap.constant = 15*AppScale;
    self.numberHeight.constant = 21*AppScale;
    self.numberLabelTap.constant = 20*AppScale;
    self.numberLabelHeight.constant = 21*AppScale;
    self.backViewHeight.constant = 100*AppScale;
    self.viewHeight.constant = 50*AppScale;
    
    self.bindIphoneLabel.textColor = RGBColor(102, 102, 102);
    self.phoneNumber.textColor = RGBColor(102, 102, 102);
    self.getCode.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCodeEven)];
    [self.getCode addGestureRecognizer:gesture];
    self.getCode.layer.borderWidth = 1;
    self.getCode.layer.borderColor = systemColor.CGColor;
    self.getCode.font = [UIFont systemFontOfSize:11*AppScale];
    self.getCode.layer.cornerRadius = 12.0*AppScale;
    self.getCode.layer.masksToBounds = YES;
   
    self.verification.backgroundColor = systemColor;
    self.verification.layer.cornerRadius = 5.0;
    self.verification.layer.masksToBounds = YES;
    self.verification.titleLabel.font = [UIFont systemFontOfSize:15*AppScale];
    self.describe.textColor = RGBColor(102, 102, 102);
    self.describe.font = [UIFont systemFontOfSize:11*AppScale];
    [self.customerServiceNumber setTitleColor:systemColor forState:UIControlStateNormal];
    self.customerServiceNumber.titleLabel.font = [UIFont systemFontOfSize:20*AppScale];
    UIImage *select_img=[UIImage imageNamed:@"phoneIcon"];
    //不对图形进行渲染，ios7会自动对图形进行渲染
    select_img=[select_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.customerServiceNumber setImage:select_img forState:UIControlStateNormal];
    self.customerServiceNumber.imageEdgeInsets = UIEdgeInsetsMake(0, -20*AppScale, 0, 0);
    self.inputCode.borderStyle = UITextBorderStyleNone;
    self.inputCode.font = [UIFont systemFontOfSize:13*AppScale];
    self.inputCode.clearButtonMode = UITextFieldViewModeWhileEditing;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyStyle];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"修改手机号"];
    
    phoneNumModel = [[CLSHPhoneNumModel alloc] init];
    checkTokenModel = [[CLSHAccountCheckTokenModel alloc] init];
    
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

- (void)receiveCode:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    code = dic[@"code"];
    NSLog(@"---------%@", code);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]};
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    [phoneNumModel fetchAccountPhoneNumModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            phoneNumModel = result;
            self.phoneNumber.text = [phoneNumModel.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <otherResponse>
//获取手机验证码
- (void)getCodeEven
{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.getPictureCodeView];
    [self getPictureCodeEven];
    
    WS(weakSelf);
    self.getPictureCodeView.getPhoneCodeBlock = ^(){
        [weakSelf verifyPictureCode];
    };
    
}

//获取图片验证码
- (void)getPictureCodeEven
{
    param[@"phoneNum"] = phoneNumModel.mobile;
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
    dic[@"captchaId"] = phoneNumModel.mobile;
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
    [phoneNumModel fetchAccountValidateCodeModel:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:@"验证码已发送，请注意查收！"];
            KBTimer *tiemr=[[KBTimer alloc]init];
            [tiemr countDown:self.getCode];
            isReceiveCode = YES;
        }else
        {
            [MBProgressHUD showError:@"获取语音验证码失败，请重新获取！"];
        }
    }];
}

//验证
- (IBAction)verificationEven:(UIButton *)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (!isReceiveCode) {
        
        [MBProgressHUD showError:@"请获取语音验证码！"];
        return;
    }else if ([self.inputCode.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"请输入验证码！"];
        return;
    }
        
    params[@"smsToken"] = self.inputCode.text;
    oldToken = params[@"smsToken"];
    [checkTokenModel fetchAccountCheckTokenModel:params callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
//            [MBProgressHUD showSuccess:result];
            
            CLSHBindNewPhoneNumberVC *bind = [[CLSHBindNewPhoneNumberVC alloc] init];
            bind.oldSmsToken = oldToken;
            [self.navigationController pushViewController:bind animated:YES];
        }else
        {
            [MBProgressHUD showError:@"请输入正确的验证码！"];
        }
    }];
}


//拨打客服电话
- (IBAction)customerServicePhoneNumber:(UIButton *)sender {
}

@end
