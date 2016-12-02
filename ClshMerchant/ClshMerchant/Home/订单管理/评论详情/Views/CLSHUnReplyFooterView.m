//
//  CLSHUnReplyFooterView.m
//  ClshMerchant
//
//  Created by arom on 16/8/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHUnReplyFooterView.h"

@implementation CLSHUnReplyFooterView

#pragma mark -- 懒加载
- (UITextField *)textField{

    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.layer.masksToBounds = YES;
        _textField.layer.cornerRadius = 5*AppScale;
        _textField.layer.borderColor = RGBColor(53, 53, 53).CGColor;
        _textField.layer.borderWidth = 1;
    }
    return _textField;
}

- (UIButton *)answerButton{

    if (!_answerButton) {
        _answerButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_answerButton setTitle:@"回复" forState:(UIControlStateNormal)];
        [_answerButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _answerButton.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _answerButton.layer.masksToBounds = YES;
        _answerButton.layer.cornerRadius = 5*AppScale;
        _answerButton.backgroundColor = systemColor;
        [_answerButton addTarget:self action:@selector(answer:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _answerButton;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        
    }
    return self;
}

- (void)initUI{

    self.contentView.backgroundColor = [UIColor whiteColor];
//    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textField];
    [self addSubview:self.answerButton];
    
    [self updateConstraints];
}

- (void)answer:(UIButton *)sender{

    if (self.answerCommentblock) {
        self.answerCommentblock();
    }
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(_answerButton.mas_left).with.offset(-10*AppScale);
        make.height.equalTo(@(30*AppScale));
    }];
    
    [_answerButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(50*AppScale));
    }];
}

@end
