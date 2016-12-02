//
//  CLSHIndetityImageCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHIndetityImageCell.h"

@interface CLSHIndetityImageCell ()

@end
@implementation CLSHIndetityImageCell

-(UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"IdentityCardFront"];
    }
    return _icon;
}

-(UIButton *)upload
{
    if (!_upload) {
        _upload = [[UIButton alloc] init];
        _upload.layer.cornerRadius = 2*AppScale;
        _upload.layer.masksToBounds = YES;
        _upload.layer.borderWidth = 1;
        _upload.layer.borderColor = RGBColor(213, 213, 215).CGColor;
        _upload.titleLabel.font = [UIFont systemFontOfSize:14*AppScale];
        [_upload setTitle:@"请上传身份证正面" forState:UIControlStateNormal];
        [_upload addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_upload setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _upload;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.icon];
    [self addSubview:self.upload];
    
    [self updateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    WS(weakSelf);
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10*AppScale);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200*AppScale, 120*AppScale));
    }];
    
    [_upload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(_icon.mas_bottom).offset(10*AppScale);
        make.size.mas_equalTo(CGSizeMake(150*AppScale, 40*AppScale));
    }];
}

-(void)clickBtn:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(upLoadImgTypeName:isPerson:indexPath:)]) {
        [self.delegate upLoadImgTypeName:btn.titleLabel.text isPerson:_isPerson indexPath:_indexPath];
    }
}


#pragma mark <getter setter>
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath=indexPath;
}

-(void)setIsPerson:(BOOL)isPerson{
    _isPerson=isPerson;
}

@end
