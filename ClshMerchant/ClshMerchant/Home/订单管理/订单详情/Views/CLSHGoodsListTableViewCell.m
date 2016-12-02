//
//  CLSHGoodsListTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/5/31.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHGoodsListTableViewCell.h"

@interface CLSHGoodsListTableViewCell()

@property (nonatomic,strong)UIImageView * Goodsicon;//商品图标
@property (nonatomic,strong)UILabel * nameLabel;//商品名称
@property (nonatomic,strong)UILabel * numLable;//数量
@property (nonatomic,strong)UILabel * priceLabel;//价格
@end

@implementation CLSHGoodsListTableViewCell

#pragma mark <lazyload>
- (UIImageView *)Goodsicon{

    if (!_Goodsicon) {
        _Goodsicon = [[UIImageView alloc] init];
//        _Goodsicon.layer.borderWidth = 1;
//        _Goodsicon.layer.borderColor = RGBColor(102, 102, 102).CGColor;
        _Goodsicon.image = [UIImage imageNamed:@"OrderImage"];
    }
    return _Goodsicon;
    
}

-(UILabel *)nameLabel{

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"冰镇黄瓜";
        _nameLabel.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _nameLabel;
}

- (UILabel *)numLable{

    if (!_numLable) {
        _numLable = [[UILabel alloc] init];
        _numLable.text = @"x4";
        _numLable.textColor = RGBColor(248, 31, 0);
        _numLable.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _numLable;
}

- (UILabel *)priceLabel{

    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = @"￥168.00";
        _priceLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

#pragma mark init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.Goodsicon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.numLable];
    [self addSubview:self.priceLabel];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    
    [_Goodsicon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50*AppScale, 50*AppScale));
        
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.Goodsicon.mas_right).with.offset(10*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
    [_numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_Goodsicon.mas_right).with.offset(10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*AppScale);
        make.width.equalTo(@(60*AppScale));
        make.height.equalTo(@(20*AppScale));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-10*AppScale);
         make.left.equalTo(_numLable.mas_right).with.offset(10*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
}



@end
