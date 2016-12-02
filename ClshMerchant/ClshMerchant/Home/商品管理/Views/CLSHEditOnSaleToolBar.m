//
//  CLSHEditOnSaleToolBar.m
//  ClshMerchant
//
//  Created by kobe on 16/8/2.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHEditOnSaleToolBar.h"
#import "KBtopImgBottomTextBtn.h"

@interface CLSHEditOnSaleToolBar ()<KBtopImgBottomTextBtnDelegate>
@property (nonatomic, strong) KBtopImgBottomTextBtn *selectAllBtn;
@property (nonatomic, strong) KBtopImgBottomTextBtn *saleOutAllBtn;
@property (nonatomic, strong) KBtopImgBottomTextBtn *deleteBtn;
@property (nonatomic, strong) UIButton *complishBtn;
//@property (nonatomic, assign) BOOL isSelectAll;
@end

@implementation CLSHEditOnSaleToolBar


#pragma mark <getter setter>

-(KBtopImgBottomTextBtn *)selectAllBtn{
    if (!_selectAllBtn) {
        _selectAllBtn=[KBtopImgBottomTextBtn new];
        _selectAllBtn.delegate=self;
        _selectAllBtn.textFont=[UIFont systemFontOfSize:11*AppScale];
        _selectAllBtn.textColor=[UIColor blackColor];
        _selectAllBtn.iconUrl=@"Select_normal";
        _selectAllBtn.nameContent=@"全选";
    }
    return _selectAllBtn;
}

-(KBtopImgBottomTextBtn *)saleOutAllBtn{
    if (!_saleOutAllBtn) {
        _saleOutAllBtn=[KBtopImgBottomTextBtn new];
        _saleOutAllBtn.delegate=self;
        _saleOutAllBtn.textColor=[UIColor blackColor];
        _saleOutAllBtn.textFont=[UIFont systemFontOfSize:11*AppScale];
        _saleOutAllBtn.iconUrl=@"Shelves";
        _saleOutAllBtn.nameContent=@"下架";
    }
    return _saleOutAllBtn;
}


-(KBtopImgBottomTextBtn *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn=[KBtopImgBottomTextBtn new];
        _deleteBtn.delegate=self;
        _deleteBtn.textFont=[UIFont systemFontOfSize:11*AppScale];
        _deleteBtn.textColor=[UIColor blackColor];
        _deleteBtn.iconUrl=@"Delete";
        _deleteBtn.nameContent=@"删除";
    }
    return _deleteBtn;
}

-(UIButton *)complishBtn{
    if (!_complishBtn) {
        _complishBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _complishBtn.backgroundColor=systemColor;
        [_complishBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_complishBtn addTarget:self action:@selector(clickComplishBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_complishBtn setTitle:@"完成" forState:0];
        _complishBtn.layer.cornerRadius=3.0;
        _complishBtn.layer.masksToBounds=YES;
        _complishBtn.titleLabel.font=[UIFont systemFontOfSize:14*AppScale];
        
    }
    return _complishBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = backGroundColor;
        self.isSelectAll=NO;
    }
    return self;
}


-(void)initUI{
    
    [self addSubview:self.selectAllBtn];
    [self addSubview:self.saleOutAllBtn];
    [self addSubview:self.complishBtn];
    
    if (_isSaleOut) {
        [self addSubview:self.deleteBtn];
    }
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    
    [_selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
//        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerY.mas_equalTo(@(weakSelf.height/2));
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 35*AppScale));
    }];
    
    [_saleOutAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectAllBtn.mas_right).with.offset(5*AppScale);
//        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerY.mas_equalTo(@(weakSelf.height/2));
        make.size.mas_equalTo(CGSizeMake(40*AppScale, 35*AppScale));
    }];
    
    
    if (_isSaleOut) {
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_saleOutAllBtn.mas_right).with.offset(5);
//            make.centerY.equalTo(weakSelf.mas_centerY);
            make.centerY.mas_equalTo(@(weakSelf.height/2));
            make.size.mas_equalTo(CGSizeMake(40*AppScale, 35*AppScale));
        }];
    }
    
    [_complishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_saleOutAllBtn.mas_right).with.offset(100*AppScale);
//        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerY.mas_equalTo(@(weakSelf.height/2));
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 35*AppScale));
    }];
    
    
}

#pragma mark <KBtopImgBottomTextBtnDelegate>
-(void)clickKBtopImgBottomTextBtn:(NSString *)name{
    
    if ([name isEqualToString:@"全选"]) {
        
        if (_isSelectAll) {
            _isSelectAll=NO;
            _selectAllBtn.iconUrl=@"Select_normal";
        }else{
            _isSelectAll=YES;
            _selectAllBtn.iconUrl=@"Select_select";
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectAllShops:)]) {
            [self.delegate selectAllShops:_isSelectAll];
        }
        
    }else if ([name isEqualToString:@"上架"]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(onSaleShops)]) {
            [self.delegate onSaleShops];
        }
        
    }else if ([name isEqualToString:@"下架"]){
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(saleOutShops)]) {
            [self.delegate saleOutShops];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(delectShops)]) {
            [self.delegate delectShops];
        }
    }
}


#pragma mark <otherResponse>
-(void)clickComplishBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doneEditing)]) {
        [self.delegate doneEditing];
    }
}



#pragma mark <getter setter>
-(void)setIsSaleOut:(BOOL)isSaleOut{
    
    _isSaleOut=isSaleOut;
    
    if (_isSaleOut) {
        _saleOutAllBtn.iconUrl=@"ShelvesTop";
        _saleOutAllBtn.nameContent=@"上架";
    }else{
        _saleOutAllBtn.iconUrl=@"Shelves";
        _saleOutAllBtn.nameContent=@"下架";
    }
    
    for (KBtopImgBottomTextBtn *btn in self.subviews) {
        [btn removeFromSuperview];
    }
    [self initUI];
}

-(void)setIsSelectAll:(BOOL)isSelectAll{
    _isSelectAll=isSelectAll;
    if (_isSelectAll) {
          _selectAllBtn.iconUrl=@"Select_select";
    }else{
          _selectAllBtn.iconUrl=@"Select_normal";
    }
}

@end
