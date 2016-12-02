//
//  CLSHUpLoadCategoryCell.m
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHUpLoadCategoryCell.h"

@interface CLSHUpLoadCategoryCell ()
{
    NSString *name;
}
@property (nonatomic, strong) UILabel *categoryLab;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *addCategoryBtn;
@property (nonatomic, strong) UIButton *selectCategoryBtn;
@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, assign) BOOL isExpand;
@end

@implementation CLSHUpLoadCategoryCell

-(UILabel *)categoryLab{
    if (!_categoryLab) {
        _categoryLab=[UILabel new];
        _categoryLab.textAlignment=NSTextAlignmentLeft;
        _categoryLab.textColor=RGBColor(51, 51, 51);
        _categoryLab.font=[UIFont systemFontOfSize:13*AppScale];
        _categoryLab.text=@"类    别";
    }
    return _categoryLab;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField=[UITextField new];
        _textField.placeholder=@"请选择类别";
        _textField.layer.borderColor=RGBColor(51, 51, 51).CGColor;
        _textField.layer.borderWidth=1;
        _textField.font=[UIFont systemFontOfSize:13*AppScale];
        _textField.textColor=RGBColor(51, 51, 51);
        _textField.textAlignment = NSTextAlignmentCenter;
    }
    return _textField;
}

-(UIButton *)selectCategoryBtn{
    if (!_selectCategoryBtn) {
        _selectCategoryBtn=[UIButton buttonWithType:0];
        _selectCategoryBtn.backgroundColor=[UIColor clearColor];
        [_selectCategoryBtn addTarget:self action:@selector(chooseCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectCategoryBtn;
}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow=[UIImageView new];
        _arrow.image=[UIImage imageNamed:@"DropIcon"];
    }
    return _arrow;
}

-(UIButton *)addCategoryBtn{
    if (!_addCategoryBtn) {
        _addCategoryBtn=[UIButton buttonWithType:0];
        [_addCategoryBtn setTitleColor:systemColor forState:0];
        [_addCategoryBtn setTitle:@"添加类别" forState:0];
        _addCategoryBtn.titleLabel.font=[UIFont systemFontOfSize:13*AppScale];
        _addCategoryBtn.layer.borderColor=systemColor.CGColor;
        _addCategoryBtn.layer.borderWidth=1;
        _addCategoryBtn.layer.cornerRadius=3.0f;
        _addCategoryBtn.layer.masksToBounds=YES;
        [_addCategoryBtn addTarget:self action:@selector(addCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCategoryBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.isExpand=NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryName:) name:@"postCategoryName" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(informArrow:) name:@"informArrow" object:nil];
    }
    return self;
}

//类别
- (void)categoryName:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    name = dic[@"name"];
    self.textField.text = name;
}

//通知按钮
- (void)informArrow:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    if (![dic[@"categoryId"] isEqual:0]) {
        [UIView animateWithDuration:0.25 animations:^{
            _arrow.transform=CGAffineTransformIdentity;
            self.isExpand = NO;
        }];
    }
}

-(void)initUI{
    
    [self addSubview:self.categoryLab];
    [self addSubview:self.textField];
    [self addSubview:self.addCategoryBtn];
    
    [_textField addSubview:self.arrow];
    [_textField addSubview:self.selectCategoryBtn];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_categoryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_categoryLab.mas_right).with.offset(0);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(30*AppScale));
        make.right.equalTo(_addCategoryBtn.mas_left).with.offset(-10*AppScale);
    }];
    
    [_addCategoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 30*AppScale));
    }];
    
    
    [_selectCategoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_textField).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_textField.mas_right).with.offset(-5*AppScale);
        make.centerY.equalTo(_textField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 10*AppScale));
    }];
}


#pragma mark <otherResponse>
-(void)chooseCategoryBtn:(UIButton *)btn{
    
    if (self.isCanRotate) {
        if (_isExpand) {
            
            [UIView animateWithDuration:0.25 animations:^{
                _arrow.transform=CGAffineTransformIdentity;
            }];
            _isExpand=NO;
        }else{
            
            [UIView animateWithDuration:0.25 animations:^{
                _arrow.transform=CGAffineTransformMakeRotation(M_PI);
                
            }];
            _isExpand=YES;
        }
    }else
    {
        _isExpand=NO;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseCategory:)]) {
        [self.delegate chooseCategory:_isExpand];
    }
}
-(void)addCategoryBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addCategory)]) {
        [self.delegate addCategory];
    }
}

#pragma mark - setter getter
-(void)setIsCanRotate:(BOOL)isCanRotate
{
    _isCanRotate = isCanRotate;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setCategoryName:(NSString *)categoryName{

    _categoryName = categoryName;
    self.textField.text = categoryName;
    
}

@end
