//
//  CLSHSetupMyIconCell.m
//  ClshUser
//
//  Created by wutaobo on 16/5/30.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSetupMyIconCell.h"
#import "CLSHSetUpCenterModel.h"

@interface CLSHSetupMyIconCell ()
//约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *iconHeight;
/** 我的头像label */
@property (strong, nonatomic) IBOutlet UILabel *myIconLabel;
/** 头像图片 */
@end

@implementation CLSHSetupMyIconCell

//修改字体
- (void)modify
{
    self.iconHeight.constant = 50*AppScale;
    self.iconWidth.constant = 50*AppScale;
    self.myIconLabel.textColor = RGBColor(51, 51, 51);
    self.myIconImage.layer.cornerRadius = 25*AppScale;
    self.myIconImage.layer.masksToBounds = YES;
    self.myIconLabel.font = [UIFont systemFontOfSize:15*AppScale];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self modify];
}


//-(void)setSetUpCenterModel:(CLSHSetUpCenterModel *)setUpCenterModel
//{
//    _setUpCenterModel = setUpCenterModel;
//    
//    if (setUpCenterModel.avatar == nil) {
//        NSLog(@"头像1");
//        self.myIconImage.image = [UIImage imageNamed:@"IconImage"];
//    }else
//    {NSLog(@"头像2.。。");
//        [self.myIconImage sd_setImageWithURL:[NSURL URLWithString:setUpCenterModel.avatar] placeholderImage:nil];
//    }
//}

- (void)setIconUrl:(NSString *)iconUrl{
    _iconUrl = iconUrl;
    if (!iconUrl) {
        self.myIconImage.image = [UIImage imageNamed:@"IconImage"];
   }else{
        [self.myIconImage sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:nil];
   }

}


@end
