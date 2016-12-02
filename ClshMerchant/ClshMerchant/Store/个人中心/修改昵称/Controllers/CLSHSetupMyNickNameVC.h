//
//  CLSHSetupMyNickNameVC.h
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


#import <UIKit/UIKit.h>

@interface CLSHSetupMyNickNameVC : UIViewController

/** 标题 */
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, copy)NSString *shopId;         ///<商家id

@property (nonatomic, assign) BOOL isStoreName;     ///<修改店铺名称

@property (nonatomic, assign) BOOL isStoreTel;      ///<修改电话

@property (nonatomic, assign) BOOL isStoreADV;      //修改广告语

@property (nonatomic, assign) BOOL isStoreNickName; //修改昵称


/** 输入昵称 */
@property (strong, nonatomic) IBOutlet UITextField *inputNickname;
/** 输入描述 */
@property (strong, nonatomic) IBOutlet UILabel *inputDescribe;
/** 确认修改 */
@property (strong, nonatomic) IBOutlet UIButton *confirmModify;

@property (nonatomic, copy) NSString *nickName; ///<传入昵称
@property (nonatomic, copy) NSString *storeName; ///<传入店铺名称
@property (nonatomic, copy) NSString *storeTel; ///<传入店铺电话
@property (nonatomic, copy) NSString *storeADV; ///<传入广告语

@end
