//
//  CLSHAddAdvertisementView.m
//  ClshMerchant
//
//  Created by kobe on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHAddAdvertisementView.h"
#import "KBTextView.h"

@interface CLSHAddAdvertisementView ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UILabel *deadLineLab;
@property (nonatomic, strong) UITextField *deadLineField;
@property (nonatomic, strong) UIButton *deadLineBtn;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *seperatorLine;

@property (nonatomic, strong) KBTextView *textView;
@property (nonatomic, strong) UIView *imgView;
@property (nonatomic, strong) UIView *preview;
@property (nonatomic, strong) UIButton *previewBtn;
@property (nonatomic, strong) UILabel *describeLab;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, assign) CGFloat textViewHeight;
@property (nonatomic, assign) CGFloat imgViewHeiht;
@end

@implementation CLSHAddAdvertisementView

#pragma mark <lazyLoad>
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[UIScrollView new];
        _scrollView.showsVerticalScrollIndicator=NO;
    }
    return _scrollView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.text=@"标       题:";
        _titleLab.font=[UIFont systemFontOfSize:13*AppScale];
    }
    return _titleLab;
}

-(UITextField *)titleField{
    if (!_titleField) {
        _titleField=[UITextField new];
        _titleField.borderStyle=UITextBorderStyleNone;
        _titleField.delegate=self;
        _titleField.placeholder=@"请输入广告标题";
        _titleField.font=[UIFont systemFontOfSize:13*AppScale];
    }
    return _titleField;
}

-(UILabel *)deadLineLab{
    if (!_deadLineLab) {
        _deadLineLab=[UILabel new];
        _deadLineLab.text=@"截止日期:";
        _deadLineLab.font=[UIFont systemFontOfSize:13*AppScale];
    }
    return _deadLineLab;
}

-(UITextField *)deadLineField{
    if (!_deadLineField) {
        _deadLineField=[UITextField new];
        _deadLineField.placeholder=@"请选择时间";
        _deadLineField.font=[UIFont systemFontOfSize:13*AppScale];
        _deadLineField.borderStyle=UITextBorderStyleNone;
    }
    return _deadLineField;
}

-(UIButton *)deadLineBtn{
    if (!_deadLineBtn) {
        _deadLineBtn=[UIButton buttonWithType:0];
        _deadLineBtn.backgroundColor=[UIColor clearColor];
        _deadLineBtn.timeInterval=0.2;
        [_deadLineBtn addTarget:self action:@selector(datePickerBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deadLineBtn;
}

-(UIView *)topView{
    if (!_topView) {
        _topView=[UIView new];
        _topView.backgroundColor=[UIColor whiteColor];
    }
    return _topView;
}

-(UIView *)seperatorLine{
    if (!_seperatorLine) {
        _seperatorLine=[UIView new];
        _seperatorLine.backgroundColor=backGroundColor;
    }
    return _seperatorLine;
}

-(KBTextView *)textView{
    if (!_textView) {
        _textView=[KBTextView new];
        _textView.delegate=self;
        _textView.placeHolder=@"请输入广告的详细内容(限200字)";
        _textView.placeHolderFont=[UIFont systemFontOfSize:12*AppScale];
        _textView.placeHolderColor=[UIColor lightGrayColor];
    }
    return _textView;
}

-(UIView *)imgView{
    if (!_imgView) {
        _imgView=[UIView new];
        _imgView.backgroundColor=[UIColor whiteColor];
    }
    return _imgView;
}

-(UIView *)preview{
    if (!_preview) {
        _preview=[UIView new];
        _preview.backgroundColor=[UIColor whiteColor];
    }
    return _preview;
}

-(UIButton *)previewBtn{
    if (!_previewBtn) {
        _previewBtn=[UIButton new];
        _previewBtn.layer.cornerRadius=3.0;
        _previewBtn.layer.masksToBounds=YES;
        _previewBtn.layer.borderColor=systemColor.CGColor;
        _previewBtn.layer.borderWidth=1.0;
        [_previewBtn setTitleColor:systemColor forState:0];
        [_previewBtn addTarget:self action:@selector(clickPreviewBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_previewBtn setTitle:@"效果预览" forState:0];
    }
    return _previewBtn;
}

-(UILabel *)describeLab{
    if (!_describeLab) {
        _describeLab=[UILabel new];
        _describeLab.text=@"*广告图请限制在8张以内";
        [NSString labelString:_describeLab font:[UIFont systemFontOfSize:13*AppScale] range:NSMakeRange(0, 1) color:[UIColor redColor]];
        _describeLab.font=[UIFont systemFontOfSize:13*AppScale];
        _describeLab.textAlignment=NSTextAlignmentCenter;
    }
    return _describeLab;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn=[UIButton new];
        _nextBtn.backgroundColor=systemColor;
        _nextBtn.layer.cornerRadius=5.0;
        _nextBtn.layer.masksToBounds=YES;
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_nextBtn setTitle:@"下一步" forState:0];
        [_nextBtn addTarget:self action:@selector(clickNextStepBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:0];
    }
    return _nextBtn;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor=backGroundColor;
        self.textViewHeight=120*AppScale;
        self.imgViewHeiht=70*AppScale;
    }
    return self;
}

-(void)initUI{
    
    [self addSubview:self.scrollView];
    
    [_scrollView addSubview:self.topView];
    [_topView addSubview:self.titleLab];
    [_topView addSubview:self.titleField];
    [_topView addSubview:self.seperatorLine];
    [_topView addSubview:self.deadLineLab];
    [_topView addSubview:self.deadLineField];
    [_deadLineField addSubview:self.deadLineBtn];
    
    [_scrollView addSubview:self.textView];
    [_scrollView addSubview:self.imgView];

    [_scrollView addSubview:self.preview];
    [_preview addSubview:self.previewBtn];
    [_scrollView addSubview:self.describeLab];
    [_scrollView addSubview:self.nextBtn];
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    //topView
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_top).with.offset(10*AppScale);
        make.left.equalTo(_scrollView.mas_left).with.offset(0);
        make.width.mas_equalTo(@(SCREENWIDTH));
        make.right.equalTo(_scrollView.mas_right).with.offset(0);
        make.height.mas_equalTo(@(61*AppScale));
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top);
        make.left.equalTo(_topView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 30*AppScale));
    }];
    [_titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top);
        make.left.equalTo(_titleLab.mas_right);
        make.height.mas_equalTo(@(30*AppScale));
        make.right.equalTo(_scrollView.mas_right).with.offset(-10*AppScale);
    }];
    
    [_seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom);
        make.left.equalTo(_topView.mas_left).with.offset(10*AppScale);
        make.right.equalTo(_topView.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(1));
    }];
    
    [_deadLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_seperatorLine.mas_bottom);
        make.left.equalTo(_topView.mas_left).with.offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 30*AppScale));
    }];
    
    [_deadLineField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_seperatorLine.mas_bottom);
        make.left.equalTo(_deadLineLab.mas_right);
        make.height.mas_equalTo(@(30*AppScale));
        make.right.equalTo(_scrollView.mas_right).with.offset(-10*AppScale);
    }];
    
    [_deadLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_deadLineField).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //add kbtextview
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).with.offset(1);
        make.left.equalTo(_scrollView.mas_left);
        make.right.equalTo(_scrollView.mas_right);
    }];
    
    [_textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(_textViewHeight));
    }];
    

    //add imgView
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.mas_bottom).with.offset(-1);
        make.left.equalTo(_scrollView.mas_left);
        make.right.equalTo(_scrollView.mas_right);
      
    }];
    
    [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(_imgViewHeiht));
    }];
    
    //add preview
    [_preview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom).with.offset(1);
        make.left.equalTo(_scrollView.mas_left);
        make.right.equalTo(_scrollView.mas_right);
        make.height.mas_equalTo(@(60*AppScale));
    }];

    [_previewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_preview.mas_centerX);
        make.centerY.equalTo(_preview.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(120*AppScale, 40*AppScale));
    }];
    
    //add describeLab
    [_describeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_preview.mas_bottom);
        make.left.equalTo(_scrollView.mas_left);
        make.right.equalTo(_scrollView.mas_right);
        make.height.mas_equalTo(@(30*AppScale));
    }];
    
    //add nextBtn
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_describeLab.mas_bottom).with.offset(30*AppScale);
        make.bottom.equalTo(_scrollView.mas_bottom).with.offset(-30*AppScale);
        make.left.equalTo(_scrollView.mas_left).with.offset(10*AppScale);
        make.right.equalTo(_scrollView.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(40*AppScale));
    }];
    
}

#pragma mark <UITextViewDelegate>
-(void)textViewDidChange:(UITextView *)textView{
    
    CGFloat textHeiht=[NSString caculatorTextSize:(SCREENWIDTH-20) textFont:[UIFont systemFontOfSize:14*AppScale] textContent:textView.text].height;
    
    if (textHeiht>120) {
        _textViewHeight=textHeiht;
        [self setNeedsUpdateConstraints];
    }else{}
    
    if (textView.text.length>200) {
        NSString *tempString=[textView.text substringToIndex:199];
        [MBProgressHUD showError:@"字数不能超过200个"];
        textView.text=tempString;
        
//        textView.userInteractionEnabled=YES;
    }else{
//        textView.userInteractionEnabled=YES;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textContent:)]) {
        [self.delegate textContent:textView.text];
    }
}

#pragma mark <UITextFieldDelegate>
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleName:)]) {
        [self.delegate titleName:textField.text];
    }
}

//layout imageview
-(void)setImgArr:(NSArray *)imgArr{
    _imgArr=imgArr;
    if (_imgArr.count<4) {
        _imgViewHeiht=(SCREENWIDTH-20*5)/4+20;
        [self addImg:imgArr];
    }else{
        _imgViewHeiht=2*((SCREENWIDTH-20*5)/4)+30;
        [self addImg:imgArr];
      
    }
      [self setNeedsUpdateConstraints];
}

-(void)addImg:(NSArray *)imgArr{
    
    
    for (UIImageView *imgView in _imgView.subviews) {
        [imgView removeFromSuperview];
    }
    
    CGFloat imgX=20;
    CGFloat imgY=10;
    CGFloat imgW=(SCREENWIDTH-20*5)/4;
    CGFloat imgH=imgW;
    CGFloat margin=20;
    
    
    for (int i=0; i<imgArr.count; i++) {
        UIImageView *imageView=[UIImageView new];
        
        if ((imgX+imgW+margin)<=SCREENWIDTH) {
            imageView.frame=CGRectMake(imgX, imgY, imgW, imgH);
            imgX=imgX+imgW+margin;
        }else{
            imgX=20;
            imgY+=imgW+10;
            imageView.frame=CGRectMake(imgX, imgY, imgW, imgH);
            imgX=imgX+imgW+margin;
        }
        imageView.image=imgArr[i];
        imageView.userInteractionEnabled=YES;
        if (i==imgArr.count-1) {
            
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageTap:)];
            [imageView addGestureRecognizer:tap];
        }else{
            
            UIButton *delectImg=[UIButton buttonWithType:0];
            delectImg.frame=CGRectMake(imgW-18, 0, 18, 18);
            [delectImg setImage:[UIImage imageNamed:@"delete"] forState:0];
            delectImg.tag=i;
            [delectImg addTarget:self action:@selector(deleteImgTap:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:delectImg];
        }
        
        [_imgView addSubview:imageView];
    }
    
}


-(void)addImageTap:(UITapGestureRecognizer *)gesture{

    
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addImage)]) {
        [self.delegate addImage];
    }
}

-(void)deleteImgTap:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteImage:)]) {
        [self.delegate deleteImage:_imgArr[btn.tag]];
    }
}

-(void)datePickerBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker)]) {
        [self.delegate datePicker];
    }
}

-(void)clickNextStepBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(nextStepBtn)]) {
        [self.delegate nextStepBtn];
    }
}

-(void)clickPreviewBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(previewBtn)]) {
        [self.delegate previewBtn];
    }
}

#pragma makr <getter setter>
-(void)setShowDatePickerTime:(NSString *)showDatePickerTime{
    _showDatePickerTime=showDatePickerTime;
    _deadLineField.text=showDatePickerTime;
}
@end
