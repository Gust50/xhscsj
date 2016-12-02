//
//  CLSHOnSaleCell.m
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


#import "CLSHOnSaleCell.h"
#import "KBtopImgBottomTextBtn.h"
#import "CLSHHomeShopListModel.h"

@interface CLSHOnSaleCell ()<KBtopImgBottomTextBtnDelegate>

@property (nonatomic, strong) UIImageView *arrow;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *stock;
@property (nonatomic, strong) UILabel *saleCount;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIButton *expandBtn;
@property (nonatomic, strong) KBtopImgBottomTextBtn *editBtn;
@property (nonatomic, strong) KBtopImgBottomTextBtn *saleOutBtn;
@property (nonatomic, strong) KBtopImgBottomTextBtn *categoryBtn;
@property (nonatomic, strong) KBtopImgBottomTextBtn *deleteBtn;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) BOOL expand;
@property (nonatomic, assign) CGFloat leftMargin;
@end

@implementation CLSHOnSaleCell

#pragma mark <lazyLoad>


-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow=[UIImageView new];
        _arrow.image=[UIImage imageNamed:@"Select_normal"];
        _arrow.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(arrowGesture:)];
        [_arrow addGestureRecognizer:tap];
    }
    return _arrow;
}
-(UIImageView *)icon{
    if (!_icon) {
        _icon=[UIImageView new];
    }
    return _icon;
}

-(UILabel *)productName{
    if (!_productName) {
        _productName=[UILabel new];
        _productName.font=[UIFont systemFontOfSize:13*AppScale];
        _productName.text=@"黑莓专属宠物狗,欢迎前来购买";
        _productName.numberOfLines=2;
    }
    return _productName;
}

-(UILabel *)stock{
    if (!_stock) {
        _stock=[UILabel new];
        _stock.font=[UIFont systemFontOfSize:11*AppScale];
        _stock.text=@"库存:100只";
        _stock.textColor=RGBColor(165, 165, 165);
    }
    return _stock;
}

-(UILabel *)saleCount{
    if (!_saleCount) {
        _saleCount=[UILabel new];
        _saleCount.font=[UIFont systemFontOfSize:11*AppScale];
        _saleCount.text=@"销量:98只";
        _saleCount.textColor=RGBColor(165, 165, 165);
    }
    return _saleCount;
}

-(UILabel *)price{
    if (!_price) {
        _price=[UILabel new];
        _price.text=@"价格:￥1999";
        _price.font=[UIFont systemFontOfSize:11*AppScale];
        _price.textColor=RGBColor(165, 165, 165);
    }
    return _price;
}

-(UIButton *)expandBtn{
    if (!_expandBtn) {
        _expandBtn=[UIButton new];
        [_expandBtn setImage:[UIImage imageNamed:@"ShowBottom"] forState:0];
        [_expandBtn addTarget:self action:@selector(clickExpandBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandBtn;
}

-(UIView *)topLine{
    if (!_topLine) {
        _topLine=[UIView new];
        _topLine.backgroundColor=backGroundColor;
    }
    return _topLine;
}

-(KBtopImgBottomTextBtn *)editBtn{
    if (!_editBtn) {
        _editBtn=[KBtopImgBottomTextBtn new];
        _editBtn.delegate=self;
        _editBtn.iconUrl=@"Edit";
        _editBtn.nameContent=@"编辑";
        _editBtn.textColor=systemColor;
        _editBtn.textFont=[UIFont systemFontOfSize:11*AppScale];
    }
    return _editBtn;
}

-(KBtopImgBottomTextBtn *)saleOutBtn{
    if (!_saleOutBtn) {
        _saleOutBtn=[KBtopImgBottomTextBtn new];
        _saleOutBtn.delegate=self;
        if (_isSaleOut) {
            _saleOutBtn.iconUrl=@"ShelvesTop";
            _saleOutBtn.nameContent=@"上架";
        }else{
            _saleOutBtn.iconUrl=@"Shelves";
            _saleOutBtn.nameContent=@"下架";
        }
        _saleOutBtn.textColor=systemColor;
        _saleOutBtn.textFont=[UIFont systemFontOfSize:11*AppScale];
    }
    return _saleOutBtn;
}

-(KBtopImgBottomTextBtn *)categoryBtn{
    if (!_categoryBtn) {
        _categoryBtn=[KBtopImgBottomTextBtn new];
        _categoryBtn.delegate=self;
        _categoryBtn.iconUrl=@"Classfy";
        _categoryBtn.nameContent=@"类别";
        _categoryBtn.textColor=systemColor;
        _categoryBtn.textFont=[UIFont systemFontOfSize:11*AppScale];
    }
    return _categoryBtn;
}

-(KBtopImgBottomTextBtn *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn=[KBtopImgBottomTextBtn new];
        _deleteBtn.delegate=self;
        _deleteBtn.iconUrl=@"Delete";
        _deleteBtn.nameContent=@"删除";
        _deleteBtn.textFont=[UIFont systemFontOfSize:11*AppScale];
        _deleteBtn.textColor=systemColor;
    }
    return _deleteBtn;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[UIView new];
    }
    return _bottomView;
}


#pragma mark <initWithStyle>
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.expand=NO;
        self.bottomView.hidden=YES;
        self.leftMargin=10*AppScale;
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    
    if (_isEdit) {
        [self addSubview:self.arrow];
    }
    [self addSubview:self.icon];
    [self addSubview:self.productName];
    [self addSubview:self.stock];
    [self addSubview:self.saleCount];
    [self addSubview:self.price];
    [self addSubview:self.expandBtn];
    [self addSubview:self.bottomView];
    [_bottomView addSubview:self.topLine];
    if (!_isSaleOut) {
        
        [_bottomView addSubview:self.editBtn];
        [_bottomView addSubview:self.saleOutBtn];
        [_bottomView addSubview:self.categoryBtn];
    }else{
        [_bottomView addSubview:self.editBtn];
        [_bottomView addSubview:self.saleOutBtn];
        [_bottomView addSubview:self.categoryBtn];
        [_bottomView addSubview:self.deleteBtn];
    }
    
    [self updateConstraints];
}

-(void)updateConstraints{
    [super updateConstraints];
    WS(weakSelf);
    
    
    if (_isEdit) {
        
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(20*AppScale, 20*AppScale));
        }];
        
    }
    
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(5*AppScale);
//        make.left.equalTo(weakSelf.mas_left).with.offset(_leftMargin);
        make.size.mas_equalTo(CGSizeMake(80*AppScale, 80*AppScale));
    }];
    
    [_icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(_leftMargin);
    }];
    
    
    [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(5*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(30*AppScale));
    }];
    
    [_stock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productName.mas_bottom).with.offset(5*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
        make.right.equalTo(_saleCount.mas_left);
        make.width.equalTo(_saleCount.mas_width);
    }];
    
    [_saleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productName.mas_bottom).with.offset(5*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.mas_equalTo(@(20*AppScale));
        make.width.equalTo(_stock.mas_width);
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stock.mas_bottom).with.offset(5*AppScale);
        make.left.equalTo(_icon.mas_right).with.offset(5*AppScale);
        make.size.mas_equalTo(CGSizeMake(150*AppScale, 20*AppScale));
    }];
    
    [_expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.bottom.equalTo(_icon.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(18*AppScale, 18*AppScale));
    }];
    
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_icon.mas_bottom).with.offset(5*AppScale);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(40*AppScale));
    }];
    
    
    //add to _bottomView
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView.mas_top).with.offset(0);
        make.left.equalTo(_bottomView.mas_left);
        make.right.equalTo(_bottomView.mas_right);
        make.height.mas_equalTo(@(1));
    }];
    
    if (!_isSaleOut) {
        
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_saleOutBtn.mas_left).with.offset(-40*AppScale);
            make.top.equalTo(_topLine.mas_bottom).with.offset(5*AppScale);
            make.size.mas_equalTo(CGSizeMake(60*AppScale, 40*AppScale));
        }];
        
        [_saleOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topLine.mas_bottom).with.offset(5*AppScale);
            make.centerX.equalTo(_bottomView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(60*AppScale, 40*AppScale));
        }];
        
        [_categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_saleOutBtn.mas_right).with.offset(40*AppScale);
            make.top.equalTo(_topLine.mas_bottom).with.offset(5*AppScale);
            make.size.mas_equalTo(CGSizeMake(60*AppScale, 40*AppScale));
        }];
 
    }else{
        
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(20*AppScale);
            make.top.equalTo(_topLine.mas_bottom).with.offset(5*AppScale);
            make.size.mas_equalTo(CGSizeMake(60*AppScale, 40*AppScale));
        }];
        
        [_saleOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_centerX).with.offset(-10*AppScale);
            make.top.equalTo(_topLine.mas_bottom).with.offset(5*AppScale);
            make.size.mas_equalTo(CGSizeMake(60*AppScale, 40*AppScale));
        }];
        
        [_categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_centerX).with.offset(10*AppScale);
            make.top.equalTo(_topLine.mas_bottom).with.offset(5*AppScale);
            make.size.mas_equalTo(CGSizeMake(60*AppScale, 40*AppScale));
        }];
        
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-20*AppScale);
            make.top.equalTo(_topLine.mas_bottom).with.offset(5*AppScale);
            make.size.mas_equalTo(CGSizeMake(60*AppScale, 40*AppScale));
        }];
    }
  }



#pragma mark <KBtopImgBottomTextBtnDelegate>

-(void)clickKBtopImgBottomTextBtn:(NSString *)name{
    if ([name isEqualToString:@"编辑"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(editShop:)]) {
            [self.delegate editShop:_indexPath];
        }
    }else if ([name isEqualToString:@"下架"]){
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(saleOutShop:)]) {
            [self.delegate saleOutShop:_indexPath];
        }
    }else if ([name isEqualToString:@"上架"]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(onSaleShop:)]) {
            [self.delegate onSaleShop:_indexPath];
        }
        
    }else if ([name isEqualToString:@"类别"]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(editShopCategory:)]) {
            [self.delegate editShopCategory:_indexPath];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteShop:)]) {
            [self.delegate deleteShop:_indexPath];
        }
    }
}


#pragma mark <otherResponse>
-(void)clickExpandBtn:(UIButton *)btn{
    if (_expand) {
        _expand=NO;
        self.bottomView.hidden=YES;
    }else{
        _expand=YES;
        self.bottomView.hidden=NO;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(expandBtn:indexPath:)]) {
        [self.delegate expandBtn:_expand indexPath:_indexPath];
    }
}

//click arrow
-(void)arrowGesture:(UITapGestureRecognizer *)gesture{
    if (_itemModel.isArrow) {
        _itemModel.isArrow=NO;
         _arrow.image=[UIImage imageNamed:@"Select_normal"];
    }else{
        _itemModel.isArrow=YES;
         _arrow.image=[UIImage imageNamed:@"Select_select"];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickArrow)]) {
        [self.delegate clickArrow];
    }
}

#pragma mark <getter setter>
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
}


-(void)setIsEdit:(BOOL)isEdit{
    _isEdit=isEdit;
    if (isEdit) {
        _leftMargin=40*AppScale;
        [self initUI];
    }else{
        _leftMargin=10*AppScale;
         [self initUI];
    }
}

-(void)setIsSaleOut:(BOOL)isSaleOut{
    _isSaleOut=isSaleOut;
    for (KBtopImgBottomTextBtn *btn in _bottomView.subviews) {
        [btn removeFromSuperview];
    }
    if (_isSaleOut) {
        _saleOutBtn.iconUrl=@"ShelvesTop";
        _saleOutBtn.nameContent=@"上架";
    }else{
        _saleOutBtn.iconUrl=@"Shelves";
        _saleOutBtn.nameContent=@"下架";
    }
    [self initUI];
}

-(void)setItemModel:(CLSHHomeShopListItemModel *)itemModel{
    _itemModel=itemModel;
    _productName.text=itemModel.name;
    _stock.text=[NSString stringWithFormat:@"库存：%ld件",itemModel.stock];
    NSString *priceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:itemModel.price]];
    _price.text=[NSString stringWithFormat:@"价格：%@",priceStr];
    [NSString labelString:_price font:[UIFont systemFontOfSize:11*AppScale] range:NSMakeRange(3, _price.text.length-3) color:[UIColor redColor]];
    _saleCount.text=[NSString stringWithFormat:@"累计销量：%ld件",itemModel.sales];
    [_icon sd_setImageWithURL:[NSURL URLWithString:itemModel.image[0]] placeholderImage:nil];
    if (itemModel.isArrow) {
        _arrow.image=[UIImage imageNamed:@"Select_select"];
    }else{
        _arrow.image=[UIImage imageNamed:@"Select_normal"];
    }
    [self isExpand:itemModel.isExpand];
}

-(void)isExpand:(BOOL)expanded{
    if (expanded) {
        _bottomView.hidden=NO;
        [UIView animateWithDuration:0.25 animations:^{
            
            _expandBtn.transform=CGAffineTransformMakeRotation(M_PI);
        }];
        
    }else{
        _bottomView.hidden=YES;
        [UIView animateWithDuration:0.25 animations:^{
            _expandBtn.transform=CGAffineTransformIdentity;
        }];
    }
}

@end
