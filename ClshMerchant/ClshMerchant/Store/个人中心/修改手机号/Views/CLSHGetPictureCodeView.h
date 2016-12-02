//
//  CLSHGetPictureCodeView.h
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


#import <UIKit/UIKit.h>

typedef void(^getPhoneCodeBlock)();
typedef void(^changePictureBlock)();

@interface CLSHGetPictureCodeView : UIView

@property (strong, nonatomic) IBOutlet UIButton *picture;
@property (strong, nonatomic) IBOutlet UILabel *reminder;
@property (strong, nonatomic) IBOutlet UITextField *inputCode;

@property (nonatomic, copy)getPhoneCodeBlock getPhoneCodeBlock;
@property (nonatomic, copy)changePictureBlock changePictureBlock;
@end
