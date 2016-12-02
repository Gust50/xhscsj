//
//  CLSHCategoryManagementEditCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHCategoryManagementEditCell.h"
#import "CLSHCategoryManageModel.h"

@interface CLSHCategoryManagementEditCell ()
@property (nonatomic, strong)UILabel *name;
@property (nonatomic, strong)UILabel *count;
@property (nonatomic, strong)UIButton *edit;
@end

@implementation CLSHCategoryManagementEditCell

-(UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"生鲜制品";
        _name.font = [UIFont systemFontOfSize:14*AppScale];
        _name.textColor = RGBColor(55, 55, 55);
    }
    return _name;
}

-(UILabel *)count
{
    if (!_count) {
        _count = [[UILabel alloc] init];
        _count.text = @"3";
        _count.font = [UIFont systemFontOfSize:14*AppScale];
        _count.textColor = [UIColor redColor];
        _count.textAlignment = NSTextAlignmentRight;
    }
    return _count;
}

-(UIButton *)edit
{
    if (!_edit) {
        _edit = [[UIButton alloc] init];
        [_edit setImage:[UIImage imageNamed:@"EditCategory"] forState:UIControlStateNormal];
        [_edit addTarget:self action:@selector(editCategory) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edit;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        if (self.editCategoryBlock) {
            self.editCategoryBlock();
        }

    }
}

- (void)initUI
{
    [self addSubview:self.name];
    [self addSubview:self.count];
    [self addSubview:self.edit];
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(15*AppScale, 15*AppScale));
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_edit.mas_right).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(100*AppScale, 20*AppScale));
    }];
    
    [_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_name.mas_right).offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).offset(-30*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
    }];
    
}


- (void)editCategory
{
    if (self.editCategoryBlock) {
        self.editCategoryBlock();
    }
}

- (void)setModel:(CLSHCategoryListModel *)model{

    _model = model;
    _name.text = model.name;
    _count.text = [NSString stringWithFormat:@"%ld",model.size];
}

@end
