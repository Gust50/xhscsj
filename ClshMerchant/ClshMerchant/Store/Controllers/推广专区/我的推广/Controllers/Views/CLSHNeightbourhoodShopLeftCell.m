//
//  CLSHNeightbourhoodShopLeftCell.m
//  ClshUser
//
//  Created by kobe on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHNeightbourhoodShopLeftCell.h"
#import "Masonry.h"
#import "CLSHNeighborhoodModel.h"


@interface CLSHNeightbourhoodShopLeftCell ()

@end

@implementation CLSHNeightbourhoodShopLeftCell

#pragma mark <lazyLoad>
-(UILabel *)categoryName{
    if (!_categoryName) {
        _categoryName=[[UILabel alloc]init];
        _categoryName.text = @"南昌炒粉";
        _categoryName.font = [UIFont systemFontOfSize:13*pro];
        _categoryName.textColor = RGBColor(102, 102, 102);
    }
    return _categoryName;
}

-(UIView *)indicatorLine{
    if (!_indicatorLine) {
        _indicatorLine=[[UIView alloc]init];
        _indicatorLine.backgroundColor = backGroundColor;
    }
    return _indicatorLine;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}



-(void)initUI{
    
    [self addSubview:self.categoryName];
    [self addSubview:self.indicatorLine];
    [self updateConstraints];
}

-(void)setSelected:(BOOL)selected{
    
    if (selected) {
         self.indicatorLine.backgroundColor = systemColor;
       
    }
}


-(void)updateConstraints{
    
    [super updateConstraints];
    
    WS(weakSelf);
    
    [_indicatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left);
        make.width.mas_equalTo(@(3));
        make.height.equalTo(weakSelf.mas_height);
    }];
    
    [_categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(_indicatorLine.mas_right).with.offset(10*pro);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(@(20*pro));
    }];
}

- (void)setNeighborhoodMerchantLeftCategoryListModel:(CLSHNeighborhoodMerchantLeftCategoryListModel *)NeighborhoodMerchantLeftCategoryListModel{

    _NeighborhoodMerchantLeftCategoryListModel = NeighborhoodMerchantLeftCategoryListModel;
    self.categoryName.text = NeighborhoodMerchantLeftCategoryListModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
     //self.backgroundColor = [UIColor whiteColor];
    // Configure the view for the selected state
}

@end
