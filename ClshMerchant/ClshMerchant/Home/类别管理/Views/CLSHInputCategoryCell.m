//
//  CLSHInputCategoryCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHInputCategoryCell.h"

@interface CLSHInputCategoryCell ()
@property (nonatomic, strong)UITextField *inputCategory;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)NSMutableDictionary *dic;
@end
@implementation CLSHInputCategoryCell

-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UITextField *)inputCategory
{
    if (!_inputCategory) {
        _inputCategory = [[UITextField alloc] init];
        _inputCategory.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputCategory.font = [UIFont systemFontOfSize:14*AppScale];
        _inputCategory.borderStyle = UITextBorderStyleNone;
    }
    return _inputCategory;
}

-(NSMutableDictionary *)dic
{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange)  name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textFieldDidChange
{
    self.dic[@"categoryName"] = self.inputCategory.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getCategoryName" object:nil userInfo:self.dic];
}

- (void)initUI
{
    [self addSubview:self.backView];
    [self.backView addSubview:self.inputCategory];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    [_inputCategory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-10*AppScale);
    }];
}

-(void)setName:(NSString *)name
{
    _name = name;
    self.inputCategory.text = name;
    self.dic[@"categoryName"] = name;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getCategoryName" object:nil userInfo:self.dic];
}

@end
