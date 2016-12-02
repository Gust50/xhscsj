//
//  KBtopImgBottomTextBtn.h
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


#import <UIKit/UIKit.h>

@protocol KBtopImgBottomTextBtnDelegate <NSObject>
-(void)clickKBtopImgBottomTextBtn:(NSString *)name;
@end

@interface KBtopImgBottomTextBtn : UIView
@property (nonatomic, copy) NSString *iconUrl;         ///<imgUrl
@property (nonatomic, copy) NSString *nameContent;     ///<content
@property (nonatomic, strong) UIColor *textColor;      ///<textColor
@property (nonatomic, strong) UIFont *textFont;        ///<textFont
@property (nonatomic, weak) id <KBtopImgBottomTextBtnDelegate>delegate;
@end
