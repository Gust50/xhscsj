//
//  CLSHNeightbourhoodShopRightCell.m
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeightbourhoodShopRightCell.h"
#import "KBCountView.h"
#import "Masonry.h"
#import "CLSHNeighborhoodModel.h"

@interface CLSHNeightbourhoodShopRightCell ()<KBCountViewDelegate>

@property(nonatomic,strong)UIImageView *shopIcon;
@property(nonatomic,strong)UILabel *shopName;
@property(nonatomic,strong)UILabel *monthSaleCount;
@property(nonatomic,strong)UILabel *shopPrice;
@property(nonatomic,strong)KBCountView *kBCountView;

@property(nonatomic,strong) UIButton *selectSpecification;  ///<选择商品规格

@end

@implementation CLSHNeightbourhoodShopRightCell

#pragma mark <lazyLoad>
-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        _shopIcon.layer.cornerRadius=5.0;
        _shopIcon.layer.masksToBounds=YES;
        _shopIcon.image = [UIImage imageNamed:@"产品"];
    }
    return _shopIcon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.textColor = [UIColor blackColor];
        _shopName.font = [UIFont systemFontOfSize:13*pro];
        _shopName.text = @"地沟油炒粉";
    }
    return _shopName;
}

-(UILabel *)monthSaleCount{
    if (!_monthSaleCount) {
        _monthSaleCount=[[UILabel alloc]init];
        _monthSaleCount.font = [UIFont systemFontOfSize:11*pro];
        _monthSaleCount.textColor = RGBColor(102, 102, 102);
        _monthSaleCount.text = @"月售1024";
    }
    return _monthSaleCount;
}

-(UILabel *)shopPrice{
    if (!_shopPrice) {
        _shopPrice=[[UILabel alloc]init];
        _shopPrice.font = [UIFont systemFontOfSize:11*pro];
        _shopPrice.textColor = [UIColor redColor];
        _shopPrice.text = @"￥88/份";
    }
    return _shopPrice;
}

-(KBCountView *)kBCountView{
    if (!_kBCountView) {
        _kBCountView=[[KBCountView alloc]init];
        _kBCountView.currentNum=@"0";
        _kBCountView.delegate=self;
        _kBCountView.isUseOtherFunction=YES;
    }
    return _kBCountView;
}

- (UIButton *)selectSpecification
{
    if (!_selectSpecification) {
        _selectSpecification = [[UIButton alloc] init];
        _selectSpecification.layer.borderWidth = 1.0;
        _selectSpecification.layer.borderColor = systemColor.CGColor;
        _selectSpecification.layer.cornerRadius = 5.0;
        _selectSpecification.layer.masksToBounds = YES;
        [_selectSpecification setTitle:@"选择规格" forState:UIControlStateNormal];
        [_selectSpecification setTitleColor:systemColor forState:UIControlStateNormal];
        _selectSpecification.titleLabel.font = [UIFont systemFontOfSize:12*pro];
        [_selectSpecification addTarget:self action:@selector(selectMerchantSpecification) forControlEvents:UIControlEventTouchUpInside];
        _selectSpecification.userInteractionEnabled=NO;
    }
    return _selectSpecification;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.shopIcon];
    [self addSubview:self.shopName];
    [self addSubview:self.monthSaleCount];
    [self addSubview:self.shopPrice];
    [self addSubview:self.kBCountView];
    [self addSubview:self.selectSpecification];
    [self updateConstraints];
}


-(void)updateConstraints{
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopIcon.mas_top);
        make.left.equalTo(_shopIcon.mas_right).with.offset(5*pro);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_monthSaleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_shopIcon.mas_right).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(120*pro, 15*pro));
    }];
    
    [_shopPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIcon.mas_bottom);
        make.left.equalTo(_shopIcon.mas_right).with.offset(5*pro);
        make.size.mas_equalTo(CGSizeMake(90*pro, 20*pro));
    }];
    
    [_kBCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIcon.mas_bottom);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 25*pro));
    }];
    
    [_selectSpecification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIcon.mas_bottom);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*pro);
        make.size.mas_equalTo(CGSizeMake(80*pro, 25*pro));
    }];
}

#pragma mark <KBCountViewDelegate>
-(void)KBCountViewMinus:(NSString *)numner{
//    _model.selectCounts=[numner integerValue];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(addMerchantGoods:)]) {
//        [self.delegate addMerchantGoods:_model];
//    }
    
    
     CLSHNeighborhoodMerchantRightGoodsListProductsModel *productModel=_model.products[0];
    productModel.selectCounts=[numner integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addMerchantProductModel:)]) {
        [self.delegate addMerchantProductModel:productModel];
    }
    
}

-(void)KBCountViewPlus:(NSString *)number{
//     _model.selectCounts=[number integerValue];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(addMerchantGoods:)]) {
//        [self.delegate addMerchantGoods:_model];
//    }
    
    
    CLSHNeighborhoodMerchantRightGoodsListProductsModel *productModel=_model.products[0];
    productModel.selectCounts=[number integerValue];
    productModel.name=_model.name;
    productModel.thumbnail=_model.thumbnail;
    if (self.delegate && [self.delegate respondsToSelector:@selector(addMerchantProductModel:)]) {
        [self.delegate addMerchantProductModel:productModel];
    }
    
}

-(void)KBCountViewOther:(NSString *)number{
//     _model.selectCounts=[number integerValue];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteMerchantGoods:)]) {
//        [self.delegate deleteMerchantGoods:_model];
//    }
    
    CLSHNeighborhoodMerchantRightGoodsListProductsModel *productModel=_model.products[0];
    productModel.selectCounts=[number integerValue];
    productModel.name=_model.name;
    productModel.thumbnail=_model.thumbnail;
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteMerchantProductModel:)]) {
        [self.delegate deleteMerchantProductModel:productModel];
    }
    
}

- (void)setModel:(CLSHNeighborhoodMerchantRightGoodsListModel *)model{

    
    CLSHNeighborhoodMerchantRightGoodsListProductsModel *productModel=model.products[0];
    _model = model;
    
    _kBCountView.maxNumber=productModel.stock;
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:nil];
    self.shopName.text = model.name;
    _kBCountView.currentNum=[NSString stringWithFormat:@"%ld",productModel.selectCounts];
    self.monthSaleCount.text = [NSString stringWithFormat:@"月销%.0f份",model.monthSales];
    NSString *shopPriceStr = [[NSString numberFormatter] stringFromNumber:[NSNumber numberWithFloat:productModel.price]];
//    NSString *shopPriceStr=[NSString stringWithFormat:@"%0.2lf",productModel.price];
    if (model.unit == nil) {
        self.shopPrice.text = [NSString stringWithFormat:@"%@/份",shopPriceStr];
    }else
    {
        self.shopPrice.text = [NSString stringWithFormat:@"%@/%@",shopPriceStr,model.unit];
    }
    
    
    if (model.hasMoreProduct) {
        _kBCountView.hidden = YES;
        _selectSpecification.hidden = NO;
    }else
    {
        _selectSpecification.hidden = YES;
        _kBCountView.hidden = NO;
    }
}

-(void)setIsReset:(BOOL)isReset{
    _isReset=isReset;
    if (_isReset) {
        _kBCountView.currentNum=@"0";
    }
}

//选择规格
- (void)selectMerchantSpecification
{
    if (self.selectSpecificationBlock) {
        self.selectSpecificationBlock();
    }
}

@end
