//
//  CLSHBottomView.m
//  ClshMerchant
//
//  Created by arom on 16/9/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHBottomView.h"

@interface CLSHBottomView (){

    NSInteger TAG;
}

@end

@implementation CLSHBottomView

#pragma mark -- 懒加载
- (UIButton *)selectBtn{

    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_selectBtn setImage:[UIImage imageNamed:@"sele_normal"] forState:(UIControlStateNormal)];
        [_selectBtn setImage:[UIImage imageNamed:@"sele_sel"] forState:(UIControlStateSelected)];
        [_selectBtn setTitle:@"  全选" forState:(UIControlStateNormal)];
        [_selectBtn setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
        _selectBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_selectBtn addTarget:self action:@selector(selectALL) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _selectBtn;
}

- (UILabel *)sumMoneyLabel{

    if (!_sumMoneyLabel) {
        _sumMoneyLabel = [[UILabel alloc] init];
        _sumMoneyLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _sumMoneyLabel.textColor = [UIColor redColor];
        _sumMoneyLabel.text = @"合计: ¥0.00";
        
    }
    return _sumMoneyLabel;
}

- (UIButton *)sureSettle{

    if (!_sureSettle) {
        _sureSettle = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_sureSettle setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_sureSettle setTitle:@"确认结算" forState:(UIControlStateNormal)];
        _sureSettle.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _sureSettle.backgroundColor = systemColor;
        [_sureSettle addTarget:self action:@selector(sureSettlebtn) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _sureSettle;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.selectBtn];
    [self addSubview:self.sumMoneyLabel];
    [self addSubview:self.sureSettle];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectAllCell:) name:@"selectAll" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelSelectAll:) name:@"cancelSelectAll" object:nil];
    [self updateConstraints];
}

- (void)selectAllCell:(NSNotification *)notification{

    _selectBtn.selected = YES;
    TAG = 1;
}

- (void)cancelSelectAll:(NSNotification *)notification{

    _selectBtn.selected = NO;
    TAG = 0;
}

- (void)selectALL{

    if (TAG == 0) {
        _selectBtn.selected = YES;
        TAG = 1;
        if (self.selectAllblock) {
            self.selectAllblock(YES);
        }
    }else{
    
        _selectBtn.selected = NO;
        TAG = 0;
        if (self.selectAllblock) {
            self.selectAllblock(NO);
        }
    }
}

- (void)sureSettlebtn{

    if (self.sureSettleblock) {
        self.sureSettleblock();
    }
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(8*AppScale);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.equalTo(@(80*AppScale));
    }];
    
    [_sumMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectBtn.mas_right).with.offset(8*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(_sureSettle.mas_left);
    }];
    
    [_sureSettle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.width.equalTo(@(SCREENWIDTH/3));
    }];
}


@end
