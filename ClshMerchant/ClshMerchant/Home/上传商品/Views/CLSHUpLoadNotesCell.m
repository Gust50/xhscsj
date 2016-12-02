//
//  CLSHUpLoadNotesCell.m
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


#import "CLSHUpLoadNotesCell.h"
#import "KBTextView.h"
@interface CLSHUpLoadNotesCell ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *notesLab;
@property (nonatomic, strong) KBTextView *kBTextView;
@end

@implementation CLSHUpLoadNotesCell

-(UILabel *)notesLab{
    if (!_notesLab) {
        _notesLab=[UILabel new];
        _notesLab.text=@"备    注";
        _notesLab.textColor=RGBColor(51, 51, 51);
        _notesLab.textAlignment=NSTextAlignmentLeft;
        _notesLab.font=[UIFont systemFontOfSize:13*AppScale];
    }
    return _notesLab;
}

-(KBTextView *)kBTextView{
    if (!_kBTextView) {
        _kBTextView=[KBTextView new];
        _kBTextView.delegate=self;
        _kBTextView.placeHolder=@"请对商品进行描述";
        _kBTextView.placeHolderFont=[UIFont systemFontOfSize:13*AppScale];
        _kBTextView.placeHolderColor=[UIColor lightTextColor];
    }
    return _kBTextView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.notesLab];
    [self addSubview:self.kBTextView];
    
    [self updateConstraints];
}
-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    [_notesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(60*AppScale, 20*AppScale));
    }];
    
    [_kBTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(2);
        make.left.equalTo(_notesLab.mas_right);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-5*AppScale);
    }];
}

#pragma mark <UITextViewDelegate>
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textView:)]) {
        [self.delegate textView:textView.text];
    }
}


-(void)setContentText:(NSString *)contentText{
    _contentText=contentText;
    _kBTextView.text=contentText;
}

@end
