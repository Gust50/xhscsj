//
//  CLSHSetupMyNickNameVC.m
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


#import "CLSHSetupMyNickNameVC.h"
#import "CLSHStoreUpdateModel.h"

@interface CLSHSetupMyNickNameVC ()
{
    CLSHStoreUpdateModel *updateNameModel;          ///<修改店铺名称
    CLSHAcountUpdateNickNameModel *nickNameModel;   ///<修改昵称
    CLSHStoreUpdatePhoneModel *updatePhoneModel;    ///<修改联系电话
    CLSHStoreAdLanguageModel *adLanguageModel;      ///<修改广告语
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nickNameTapHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *inputDescribeTapHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmTapHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *describeHeight;

@end

@implementation CLSHSetupMyNickNameVC

#pragma mark <init>
- (void)modifyFont
{
    self.describeHeight.constant = 21*AppScale;
    self.nickNameTapHeight.constant = 74*AppScale;
    self.inputDescribeTapHeight.constant = 10*AppScale;
    self.confirmTapHeight.constant = 40*AppScale;
    self.inputHeight.constant = 41*AppScale;
    self.confirmHeight.constant = 40*AppScale;
    self.inputDescribe.textColor = RGBColor(102, 102, 102);
    self.inputDescribe.font = [UIFont systemFontOfSize:10*AppScale];
    self.confirmModify.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
    self.confirmModify.layer.cornerRadius = 5.0;
    self.confirmModify.layer.masksToBounds = YES;
    self.confirmModify.backgroundColor = systemColor;
    self.inputNickname.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputNickname.font = [UIFont systemFontOfSize:13*AppScale];
    if (_isStoreName) {
        
        self.inputDescribe.text = @"*好的店名能让人印象深刻~";
    }else if(_isStoreTel){
    
        self.inputDescribe.text = @"*请记得添加区号，格式：0755-XXXXXX";
    }else if(_isStoreADV){
    
        self.inputDescribe.text = @"*广告语字数限12字及以内~";
    }else{
    
        self.inputDescribe.text = @"用户昵称可以是字母、数字、汉字和符号，只能设置2-16位字符。";
    }
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyFont];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:self.titleString];
    
    updateNameModel = [[CLSHStoreUpdateModel alloc] init];
    nickNameModel = [[CLSHAcountUpdateNickNameModel alloc] init];
    updatePhoneModel = [[CLSHStoreUpdatePhoneModel alloc] init];
    adLanguageModel = [[CLSHStoreAdLanguageModel alloc] init];
    if (_isStoreName) {
        self.inputNickname.text = self.storeName;
    }else if(_isStoreTel){
    
        self.inputNickname.text = self.storeTel;
    }else if(_isStoreADV){
    
        self.inputNickname.text = self.storeADV;
    }else if(_isStoreNickName){
        
        self.inputNickname.text = self.nickName;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14*AppScale]};
}

#pragma mark <otherResponse>
//确认修改
- (IBAction)confirm:(UIButton *)sender {
    
    if (self.isStoreName) {///<修改店铺名称
//        if (![self.inputNickname.text isEqualToString:@""]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"shopId"] = self.shopId;
        params[@"name"] = self.inputNickname.text;
        [updateNameModel fetchStoreUpdateNameData:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
//        }else
//        {
//            [MBProgressHUD showError:@"请输入正确的店铺名称"];
//        }
        
    }else if (self.isStoreNickName)
    {///<修改昵称
//        if (![self.inputNickname.text isEqualToString:@""]) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"nickname"] = self.inputNickname.text;
            [updatePhoneModel fetchStoreUpdatePhoneData:params callBack:^(BOOL isSuccess, id result) {
                if (isSuccess) {
                    [MBProgressHUD showSuccess:result];
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                {
                    [MBProgressHUD showError:result];
                }
            }];
//        }else
//        {
//            [MBProgressHUD showError:@"请输入正确的联系电话"];
//        }
    }else if (self.isStoreTel)
    {///<修改联系电话
        if (![KBRegexp checkPhoneNumInput:self.inputNickname.text]) {
            [MBProgressHUD showError:@"请输入正确的手机号码"];
            return;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"shopId"] = self.shopId;
        params[@"phone"] = self.inputNickname.text;
        [updatePhoneModel fetchStoreUpdatePhoneData:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    }else if (self.isStoreADV)
    {///<修改广告语
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"shopId"] = self.shopId;
        params[@"adLanguage"] = self.inputNickname.text;
        [adLanguageModel fetchStoreAdLanguageData:params callBack:^(BOOL isSuccess, id result) {
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                [MBProgressHUD showError:result];
            }
        }];
    }
}

#pragma mark - setter getter
//标题
-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
}
//商家id
-(void)setShopId:(NSString *)shopId
{
    _shopId = shopId;
}

//修改
- (void)setIsStoreName:(BOOL)isStoreName{

    _isStoreName = isStoreName;
}

-(void)setIsStoreNickName:(BOOL)isStoreNickName
{
    _isStoreNickName = isStoreNickName;
}

-(void)setIsStoreADV:(BOOL)isStoreADV
{
    _isStoreADV = isStoreADV;
}

-(void)setIsStoreTel:(BOOL)isStoreTel
{
    _isStoreTel = isStoreTel;
}

-(void)setNickName:(NSString *)nickName
{
    _nickName = nickName;
}

- (void)setStoreName:(NSString *)storeName{

    _storeName = storeName;
}

-(void)setStoreTel:(NSString *)storeTel
{
    _storeTel = storeTel;
}

@end
