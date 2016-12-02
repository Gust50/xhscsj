//
//  CLSHOnSaleToolbar.m
//  ClshMerchant
//
//  Created by kobe on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHOnSaleToolbar.h"

@interface CLSHOnSaleToolbar ()
@property (nonatomic, strong) UIButton *addGoodsBtn;
@property (nonatomic, strong) UIButton *batchManagerBtn;
@end

@implementation CLSHOnSaleToolbar

-(UIButton *)addGoodsBtn{
    if (!_addGoodsBtn) {
        _addGoodsBtn=[UIButton new];
        _addGoodsBtn.backgroundColor=systemColor;
        [_addGoodsBtn setTitle:@"添加商品" forState:0];
        [_addGoodsBtn addTarget:self action:@selector(clickAddGoodsBtn:) forControlEvents:UIControlEventTouchUpInside];
        _addGoodsBtn.titleLabel.font=[UIFont systemFontOfSize:14*AppScale];
        [_addGoodsBtn setTitleColor:[UIColor whiteColor] forState:0];
    }
    return _addGoodsBtn;
}

-(UIButton *)batchManagerBtn{
    if (!_batchManagerBtn) {
        _batchManagerBtn=[UIButton new];
        _batchManagerBtn.backgroundColor=[UIColor whiteColor];
        [_batchManagerBtn addTarget:self action:@selector(clickBatchManagerBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_batchManagerBtn setTitleColor:RGBColor(51, 51, 51) forState:0];
        _batchManagerBtn.titleLabel.font=[UIFont systemFontOfSize:14*AppScale];
        [_batchManagerBtn setTitle:@"批量管理" forState:0];
    }
    return _batchManagerBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.addGoodsBtn];
    [self addSubview:self.batchManagerBtn];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    [_addGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(_batchManagerBtn.mas_left);
        make.width.equalTo(_batchManagerBtn.mas_width);
    }];
    
    [_batchManagerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.left.equalTo(_addGoodsBtn.mas_right);
        make.width.equalTo(_addGoodsBtn.mas_width);
    }];
}

#pragma mark <otherResponse>
-(void)clickAddGoodsBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addShops)]) {
        [self.delegate addShops];
    }
}

-(void)clickBatchManagerBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(managerShops)]) {
        [self.delegate managerShops];
    }
}
@end
