//
//  CLSHNeighbourhoodMerchantTopView.m
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeighbourhoodMerchantTopView.h"
#import "CLGSStarRate.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "CLSHNeighborhoodModel.h"

@interface CLSHNeighbourhoodMerchantTopView (){

    CLGSStarRate * kcLGSStarRate;
}

@property(nonatomic,strong)UILabel *shopName;
@property(nonatomic,strong)CLGSStarRate *cLGSStarRate;
@property(nonatomic,strong)UILabel *starRateCount;
@property(nonatomic,strong)UIImageView *purchaseIcon;
@property(nonatomic,strong)UILabel *purchaseCount;
@property(nonatomic,strong)UIImageView *remarkIcon;
@property(nonatomic,strong)UILabel *remarkCount;

@property(nonatomic,strong)UIImageView *backgroundView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView * discountView;
@property (nonatomic,strong)UIImageView * notiIcon;
@property (nonatomic,strong)UILabel * discountLabel;

@property (nonatomic,assign)CGFloat discountViewHeight;

@end

@implementation CLSHNeighbourhoodMerchantTopView

#pragma mark <lazyLoad>
-(UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIImageView alloc]init];
        _backgroundView.contentMode = UIViewContentModeScaleToFill;
        [_backgroundView sd_setImageWithURL:[NSURL URLWithString:@"http://imgstore.cdn.sogou.com/app/a/100540002/414193.jpg?f=download"] placeholderImage:nil];
    }
    return _backgroundView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
    }
    return _bottomView;
}


-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
        [_shopIcon sd_setImageWithURL:[NSURL URLWithString:@"http://img2.cache.netease.com/house/2016/5/26/201605261607473a146.jpg"] placeholderImage:nil];
        _shopIcon.layer.masksToBounds = YES;
        _shopIcon.layer.cornerRadius = 30*pro;
        _shopIcon.layer.borderWidth = 2*pro;
        _shopIcon.layer.borderColor = backGroundColor.CGColor;
        
    }
    return _shopIcon;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.text  = @"牛头梗专卖店";
        _shopName.textColor = backGroundColor;
        _shopName.font = [UIFont systemFontOfSize:16*pro];
    }
    return _shopName;
}

-(CLGSStarRate *)cLGSStarRate{
    if (!_cLGSStarRate) {
        _cLGSStarRate=[[CLGSStarRate alloc]initWithFrame:CGRectZero numberOfStars:5];
        _cLGSStarRate.scorePercent = 0.5;
    }
    return _cLGSStarRate;
}

-(UILabel *)starRateCount{
    if (!_starRateCount) {
        _starRateCount=[[UILabel alloc]init];
    }
    return _starRateCount;
}

-(UIImageView *)purchaseIcon{
    if (!_purchaseIcon) {
        _purchaseIcon=[[UIImageView alloc]init];
        _purchaseIcon.image = [UIImage imageNamed:@"时间"];
    }
    return _purchaseIcon;
}

-(UILabel *)purchaseCount{
    if (!_purchaseCount) {
        _purchaseCount=[[UILabel alloc]init];
        _purchaseCount.text = @"已有168人购买过";
        _purchaseCount.font = [UIFont systemFontOfSize:12*pro];
        _purchaseCount.textColor = [UIColor whiteColor];
        _purchaseCount.textAlignment=NSTextAlignmentLeft;
    }
    return _purchaseCount;
}

-(UIImageView *)remarkIcon{
    if (!_remarkIcon) {
        _remarkIcon=[[UIImageView alloc]init];
        _remarkIcon.image = [UIImage imageNamed:@"笑脸"];
    }
    return _remarkIcon;
}

-(UILabel *)remarkCount{
    if (!_remarkCount) {
        _remarkCount=[[UILabel alloc]init];
        _remarkCount.textAlignment=NSTextAlignmentLeft;
        _remarkCount.textColor = [UIColor whiteColor];
        _remarkCount.font = [UIFont systemFontOfSize:12*pro];
        _remarkCount.text = @"1688条评论";
    }
    return _remarkCount;
}

- (UIView *)discountView{

    if (!_discountView) {
        _discountView = [[UIView alloc] init];
        _discountView.backgroundColor = [UIColor orangeColor];
    }
    return _discountView;
}

- (UIImageView *)notiIcon{

    if (!_notiIcon) {
        _notiIcon = [[UIImageView alloc] init];
        _notiIcon.image = [UIImage imageNamed:@"notif"];
    }
    return _notiIcon;
}

- (UILabel *)discountLabel{

    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.font = [UIFont systemFontOfSize:12*pro];
        _discountLabel.text = @"............";
    }
    return _discountLabel;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.bottomView];
    [_bottomView addSubview:self.shopIcon];
    [_bottomView addSubview:self.shopName];
    [_bottomView addSubview:self.cLGSStarRate];
    [_bottomView addSubview:self.starRateCount];
    [_bottomView addSubview:self.purchaseIcon];
    [_bottomView addSubview:self.purchaseCount];
    [_bottomView addSubview:self.remarkIcon];
    [_bottomView addSubview:self.remarkCount];
    [self addSubview:self.discountView];
    [_discountView addSubview:self.notiIcon];
    [_discountView addSubview:self.discountLabel];
    
    [self updateConstraints];
    
    kcLGSStarRate=[[CLGSStarRate alloc]initWithFrame:CGRectMake(0, 0, 60*pro, 15*pro) numberOfStars:5];
    kcLGSStarRate.userInteractionEnabled=NO;
    
}
-(void)updateConstraints{
    
    [super updateConstraints];
    WS(weakSelf);
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_discountView.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(100*pro));
    }];
    [_discountView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.mas_equalTo(@(30*pro));
    }];
//    [_discountView mas_updateConstraints:^(MASConstraintMaker *make) {
//       
//        make.height.mas_equalTo(@(self.discountViewHeight));
//    }];
    
    [_notiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_discountView.mas_left).with.offset(10*pro);
        make.top.equalTo(_discountView.mas_top).with.offset(7*pro);
        make.bottom.equalTo(_discountView.mas_bottom).with.offset(-7*pro);
        make.width.mas_equalTo(@(20*pro));
    }];
    
    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_notiIcon.mas_right).with.offset(5*pro);
        make.centerY.equalTo(_discountView.mas_centerY);
        make.right.equalTo(_discountView.mas_right).with.offset(-5*pro);
    }];
    
    //add bottom subviews
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView.mas_left).with.offset(10*pro);
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60*pro, 60*pro));
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shopIcon.mas_top);
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.right.equalTo(_bottomView.mas_right).with.offset(-10*pro);
        make.height.mas_equalTo(@(20*pro));
    }];
    
    [_cLGSStarRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(120*pro, 18*pro));
    }];
    
    [_starRateCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.left.equalTo(_cLGSStarRate.mas_right).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(120*pro, 18*pro));
    }];
    
    [_purchaseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_shopIcon.mas_bottom);
        make.left.equalTo(_shopIcon.mas_right).with.offset(10*pro);
        make.size.mas_equalTo(CGSizeMake(18*pro, 18*pro));
    }];
    
    [_purchaseCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_purchaseIcon.mas_bottom);
        make.left.equalTo(_purchaseIcon.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(120, 18));
    }];
    
    [_remarkIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_purchaseCount.mas_bottom);
        make.left.equalTo(_purchaseCount.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [_remarkCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_remarkIcon.mas_bottom);
        make.left.equalTo(_remarkIcon.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(120, 18));
    }];
}

- (void)setNeighbourhoodMerchantTopModel:(CLSHNeighborhoodMerchantLeftModel *)NeighbourhoodMerchantTopModel{

    _NeighbourhoodMerchantTopModel = NeighbourhoodMerchantTopModel;
    self.shopName.text = NeighbourhoodMerchantTopModel.name;
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:NeighbourhoodMerchantTopModel.iamge] placeholderImage:nil];
    self.purchaseCount.text = [NSString stringWithFormat:@"已有%.f人购买过",NeighbourhoodMerchantTopModel.salesCount];
    self.remarkCount.text = [NSString stringWithFormat:@"%.f条评论",NeighbourhoodMerchantTopModel.reviewCount];
    self.discountLabel.text = [NSString stringWithFormat:@"凡在本店购买，全场%@",NeighbourhoodMerchantTopModel.giftTitle];
    
    if (NeighbourhoodMerchantTopModel.giftTitle.length == 0) {
        self.discountView.hidden = YES;
//        _discountViewHeight = 0.01;
    }else{
    
        _discountViewHeight = 30*pro;
    }
    kcLGSStarRate.scorePercent = NeighbourhoodMerchantTopModel.score/5;
    [_cLGSStarRate addSubview:kcLGSStarRate];
}


@end
