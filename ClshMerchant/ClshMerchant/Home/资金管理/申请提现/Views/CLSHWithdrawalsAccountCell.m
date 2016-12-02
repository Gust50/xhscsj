//
//  CLSHWithdrawalsAccountCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/26.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHWithdrawalsAccountCell.h"

@interface CLSHWithdrawalsAccountCell ()<UITextFieldDelegate>


@end

@implementation CLSHWithdrawalsAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.distance.constant = 10*AppScale;
    self.leftLabel.textColor = RGBColor(50, 50, 50);
    self.rightTextfield.textColor = RGBColor(50, 50, 50);
    self.rightTextfield.delegate = self;
    //隐藏右边输入框
    self.rightTextfield.borderStyle = UITextBorderStyleNone;
    self.rightTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange)  name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)textFieldDidChange{
    
    NSMutableDictionary *info=[NSMutableDictionary dictionary];
    
    info[@"money"]=self.rightTextfield.text;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CLGSGetMoney" object:nil userInfo:info];
    
}

@end
