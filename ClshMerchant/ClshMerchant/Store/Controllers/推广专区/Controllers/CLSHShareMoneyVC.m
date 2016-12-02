//
//  CLSHShareMoneyVC.m
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


#import "CLSHShareMoneyVC.h"
#import "UINavigationBar+Awesome.h"
#import "CLSHInviteCodeRecord.h"
#import "CLSHShareMoneyModel.h"
#import "KBCreateQRCode.h"

//@222222
//#import "KBCreateQRCode.h"

#import "KBAppShare.h"

@interface CLSHShareMoneyVC ()
{
    CLSHShareMoneyModel *shareMoneyModel;   ///<分享赚钱数据模型
//@22222
    KBAppShare *shareModel;                 ///<分享模型
}

//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewTapHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineHeight2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *myCodeLabelHeight;
@property (strong, nonatomic) IBOutlet UILabel *myInviteLabel;
@property (strong, nonatomic) IBOutlet UILabel *myInviteLinkLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view1Tap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *QRLabelTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *IconTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label1Width;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *label2Width;
@property (strong, nonatomic) IBOutlet UILabel *myQRLabel;


@property (strong, nonatomic) IBOutlet UILabel *lineLabel;
@property (strong, nonatomic) IBOutlet UILabel *middleLineLabel;

/** 二维码 */
@property (strong, nonatomic) IBOutlet UIImageView *ORCodeIcon;

/** 我的邀请码 */
@property (strong, nonatomic) IBOutlet UILabel *inviteCode;
/** 我的邀请链接 */
@property (strong, nonatomic) IBOutlet UILabel *inviteLink;
/** 复制邀请码 */
@property (strong, nonatomic) IBOutlet UIButton *inviteCodeCopy;
/** 复制邀请链接 */
@property (strong, nonatomic) IBOutlet UIButton *inviteLinkCopy;
/** 邀请记录 */
@property (strong, nonatomic) IBOutlet UIButton *inviteRecordBtn;
/** 描述 */
@property (strong, nonatomic) IBOutlet UILabel *describe;
@end

@implementation CLSHShareMoneyVC

#pragma mark - init
- (void)modifyStyle
{
    self.myQRLabel.font = [UIFont systemFontOfSize:16*AppScale];
    self.label1Width.constant = 90*AppScale;
    self.label2Width.constant = 90*AppScale;
    
    self.view1Tap.constant = 64+10*AppScale;
    self.QRLabelTap.constant = 11*AppScale;
    self.myCodeLabelHeight.constant = 21*AppScale;
    self.IconTap.constant = 10*AppScale;
    self.iconWidth.constant = 130*AppScale;
    self.iconHeight.constant = 130*AppScale;
    
    self.myInviteLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.myInviteLinkLabel.font = [UIFont systemFontOfSize:13*AppScale];
    self.myCodeLabelHeight.constant = 21*AppScale;
    
    self.view1.constant = 180*AppScale;
    self.viewTapHeight.constant = 10*AppScale;
    self.lineHeight.constant = 50*AppScale;
    self.lineHeight2.constant = 50*AppScale;
    self.lineLabel.backgroundColor = RGBColor(212, 212, 212);
    self.middleLineLabel.backgroundColor = RGBColor(212, 212, 212);
    
    self.inviteRecordBtn.layer.cornerRadius = 5.0;
    self.inviteRecordBtn.layer.masksToBounds = YES;
    self.inviteRecordBtn.backgroundColor = systemColor;
    self.inviteRecordBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.describe.font = [UIFont systemFontOfSize:11*AppScale];
    self.inviteLinkCopy.layer.cornerRadius = 3.0;
    self.inviteLinkCopy.layer.masksToBounds = YES;
    self.inviteLinkCopy.backgroundColor = systemColor;
    self.inviteCodeCopy.layer.cornerRadius = 3.0;
    self.inviteLinkCopy.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.inviteCodeCopy.layer.masksToBounds = YES;
    self.inviteCodeCopy.backgroundColor = systemColor;
    self.inviteCodeCopy.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
    self.inviteCode.font = [UIFont systemFontOfSize:11*AppScale];
    self.inviteLink.font = [UIFont systemFontOfSize:11*AppScale];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveQRCode)];
    self.ORCodeIcon.userInteractionEnabled=YES;
    [self.ORCodeIcon addGestureRecognizer:tap];
    
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyStyle];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"分享赚钱"];
    
    //@222222
    shareModel=[[KBAppShare alloc]init];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem normalImage:@"shareMoneyWhite" selectImage:@"shareMoneyWhite" target:self action:@selector(shareQRCode)];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    [self loadData];
}

#pragma mark <loadData>
- (void)loadData
{
    shareMoneyModel = [[CLSHShareMoneyModel alloc] init];
    [shareMoneyModel fetchAccountShareMoneyModel:nil callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess) {
            shareMoneyModel = result;
            self.inviteCode.text = shareMoneyModel.code;
            self.inviteLink.text = shareMoneyModel.shareLink;
            self.describe.text = [NSString stringWithFormat:@"* %@", shareMoneyModel.shareDesc];
            [NSString labelString:self.describe font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(0, 1) color:[UIColor redColor]];
            UIImage *image=[KBCreateQRCode createQRCodeFromString:shareMoneyModel.shareLink codeSize:130 red:0 green:0 blue:0 insertImage:[UIImage imageNamed:@"AppLogo"] roundRadius:2.0f];
            self.ORCodeIcon.image=image;
            
            shareModel.title=shareMoneyModel.shareTitle;
            shareModel.detail=shareMoneyModel.shareDesc;
            shareModel.imageurl=shareMoneyModel.shareLink;
            shareModel.thumbImage=image;
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark <otherResponse>
//分享
- (void)shareQRCode
{
    [KBAppShare share:shareModel];
}
//复制邀请码
- (IBAction)copyInviteCode:(UIButton *)sender {
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:self.inviteCode.text];
    if (pab == nil) {
        [MBProgressHUD showError:@"复制失败!"];
    }else
    {
        [MBProgressHUD showSuccess:@"已复制!"];
        NSLog(@"%@", pab.string);
    }
    
}
//复制邀请链接
- (IBAction)copyInviteLink:(UIButton *)sender {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    [pab setString:self.inviteLink.text];
    if (pab == nil) {
        [MBProgressHUD showError:@"复制失败!"];
    }else
    {
        [MBProgressHUD showSuccess:@"已复制!"];
        NSLog(@"%@", pab.string);
    }
}
//邀请记录
- (IBAction)inviteRecord:(UIButton *)sender {
    
    CLSHInviteCodeRecord *record = [[CLSHInviteCodeRecord alloc] init];
    [self.navigationController pushViewController:record animated:YES];
}

//保存二维码
-(void)saveQRCode{

    UIAlertController *show=[UIAlertController alertControllerWithTitle:@"我的二维码" message:@"是否保存" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImageWriteToSavedPhotosAlbum(self.ORCodeIcon.image, self, @selector(saveImage:didFinishSavingWithError:contextInfo:), NULL);
    }];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
        
    }];
    
    [show addAction:confirm];
    [show addAction:cancel];
    
    [self.navigationController presentViewController:show animated:YES completion:^{
        
    }];
}

-(void)saveImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error!=NULL) {
        
        [MBProgressHUD showError:@"保存失败"];
    }else{
        
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

@end
