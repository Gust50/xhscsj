//
//  CLSHCancelOrderView.m
//  ClshMerchant
//
//  Created by arom on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHCancelOrderView.h"

@interface CLSHCancelOrderView ()<UITextViewDelegate>

@property(nonatomic,strong)UILabel *placeHolderLabel;
@end

@implementation CLSHCancelOrderView

#pragma mark -- 懒加载
- (UIView *)maskView{

    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = RGBAColor(0, 0, 0, 0.5);
    }
    return _maskView;
}

- (UIView *)contentView{

    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 5;
    }
    return _contentView;
}

- (UITextView *)textFieldView{

    if (!_textFieldView) {
        _textFieldView = [[UITextView alloc] init];
        _textFieldView.delegate = self;
        _textFieldView.font = [UIFont systemFontOfSize:13*AppScale];
    }
    return _textFieldView;
}

- (UIView *)lineView{

    if (!_lineView) {
        _lineView = [[UIView  alloc] init];
        _lineView.backgroundColor = systemColor;
    }
    return _lineView;
}

- (UIButton *)sureButton{

    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_sureButton setTitle:@"确定取消" forState:(UIControlStateNormal)];
        [_sureButton setBackgroundColor:systemColor];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_sureButton addTarget:self action:@selector(sureCancel:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _sureButton;
}

- (UIButton *)cancelButton{

    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_cancelButton setTitle:@"放弃" forState:(UIControlStateNormal)];
        [_cancelButton setTitleColor:systemColor forState:(UIControlStateNormal)];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_cancelButton addTarget:self action:@selector(cancelOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelButton;
}

- (UILabel *)placeHolderLabel{
    
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,-15,SCREENWIDTH-(8+10+80+10)*AppScale,60)];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _placeHolderLabel.text = @"取消理由...";
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.backgroundColor =[UIColor clearColor];
    }
    return _placeHolderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.maskView];
    [_maskView addSubview:self.contentView];
    [_contentView addSubview:self.textFieldView];
    [_contentView addSubview:self.lineView];
    [_contentView addSubview:self.sureButton];
    [_contentView addSubview:self.cancelButton];
    
    [_textFieldView addSubview:self.placeHolderLabel];
    [self updateConstraints];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self removeFromSuperview];
}

- (void)sureCancel:(UIButton *)sender{

    [self removeFromSuperview];
    NSLog(@"确定取消");
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelOrder)]) {
        [self.delegate cancelOrder];
    }
}

- (void)cancelOrder:(UIButton *)sender{

    [self removeFromSuperview];
    NSLog(@"放弃取消");
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_maskView.mas_centerX);
        make.centerY.equalTo(_maskView.mas_centerY);
        make.left.equalTo(_maskView.mas_left).with.offset(30*AppScale);
        make.height.equalTo(@(150*AppScale));
    }];
    
    [_textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_left).with.offset(0);
        make.right.equalTo(_contentView.mas_right).with.offset(0);
        make.top.equalTo(_contentView.mas_top).with.offset(0);
        make.height.equalTo(@(109*AppScale));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_contentView.mas_left).with.offset(0);
        make.right.equalTo(_contentView.mas_right).with.offset(0);
        make.top.equalTo(_textFieldView.mas_bottom).with.offset(0);
        make.height.equalTo(@(1*AppScale));
    }];
    
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_left).with.offset(0);
        make.top.equalTo(_textFieldView.mas_bottom).with.offset(0);
        make.bottom.equalTo(_contentView.mas_bottom).with.offset(0);
        make.width.equalTo(@(SCREENWIDTH/2-30*AppScale-1));
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sureButton.mas_right).with.offset(0);
        make.top.equalTo(_lineView.mas_bottom).with.offset(0);
        make.right.equalTo(_contentView.mas_right).with.offset(0);
        make.bottom.equalTo(_contentView.mas_bottom).with.offset(0);
    }];
    
}

- (void)textViewDidChange:(UITextView*)textView{
    
    if([textView.text length] == 0){
        
        _placeHolderLabel.text = @"取消理由...";
        
    }else{
        
        _placeHolderLabel.text = @"";//这里给空
        
    }
}

@end
