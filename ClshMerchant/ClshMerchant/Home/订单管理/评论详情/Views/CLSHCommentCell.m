//
//  CLSHCommentCell.m
//  ClshMerchant
//
//  Created by arom on 16/8/16.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHCommentCell.h"
#import "CLGSStarRate.h"
#import "CLSHOrderManageModel.h"
#import "KBDateFormatter.h"

@interface CLSHCommentCell (){

    CGFloat contentHeight;   ///<评论高度
}

@end

@implementation CLSHCommentCell

#pragma mark -- 懒加载
- (UIImageView *)iconView{

    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 15*AppScale;
        
    }
    return _iconView;
}

- (UILabel *)nameLable{

    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.text = @"安息香";
        _nameLable.textColor = RGBColor(102, 102, 102);
        _nameLable.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _nameLable;
}

- (UILabel *)timeLable{

    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.text = @"2016.06.03";
        _timeLable.textColor = RGBColor(102, 102, 102);
        _timeLable.font = [UIFont systemFontOfSize:12*AppScale];
    }
    return _timeLable;
}

- (UILabel *)contentLabel{

    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"很好吃，服务很赞，物流很快，果断好评啊，为了凑满15个字我也是蛮拼的";
        _contentLabel.textColor = RGBColor(53, 53, 53);
        _contentLabel.font = [UIFont systemFontOfSize:12*AppScale];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _contentLabel;
}

- (UIView *)imgView{

    if (!_imgView) {
        _imgView = [[UIView alloc] init];
    }
    return _imgView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{

    [self addSubview:self.iconView];
    [self addSubview:self.nameLable];
    [self addSubview:self.timeLable];
    [self addSubview:self.contentLabel];
    [self addSubview: self.imgView];
    
    [self updateConstraints];
}

- (void)updateConstraints{

    [super updateConstraints];
    
    WS(weakSelf);
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(5*AppScale);
        make.top.equalTo(weakSelf.mas_top).with.offset(5*AppScale);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(30*AppScale));
    }];
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_iconView.mas_right).with.offset(10*AppScale);
        make.centerY.equalTo(_iconView.mas_centerY);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(120*AppScale));
    }];
    
    [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLable.mas_centerY);
//        make.top.equalTo(weakSelf.mas_top).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(130*AppScale));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_bottom).with.offset(0*AppScale);
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
    }];
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(@(contentHeight));
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.top.equalTo(_contentLabel.mas_bottom).with.offset(10*AppScale);
        make.height.equalTo(@((SCREENWIDTH-50*AppScale)/4));
    }];
}

- (void)setModel:(CLSHCommentDataModel *)model{

    _model = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.memberAvatar] placeholderImage:[UIImage imageNamed:@"defaultIcon"]];
    if (model.memberName.length == 0) {
        self.nameLable.text = @"匿名用户";
    }else{
    
        self.nameLable.text = model.memberName;
    }
    
    NSDate * date = [[KBDateFormatter shareInstance] dateFromTimeInterval:([model.reviewCreateDate doubleValue]/1000.0)];
    NSString * timeStr = [[KBDateFormatter shareInstance] stringFromDate:date];
    self.timeLable.text = timeStr;
    self.contentLabel.text = model.reviewContent;
    CGSize size = [NSString sizeWithStr:self.contentLabel.text font:[UIFont systemFontOfSize:12*AppScale] width:SCREENWIDTH-20*AppScale];
    contentHeight = size.height;
    
    if (model.reviewImages.count) {
        for (int i = 0; i < model.reviewImages.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*AppScale+i*(SCREENWIDTH-50*AppScale)/4+i*10*AppScale, 0, (SCREENWIDTH-50*AppScale)/4, (SCREENWIDTH-50*AppScale)/4)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.reviewImages[i]] placeholderImage:nil];
            [self.imgView addSubview:imageView];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
