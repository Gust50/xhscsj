//
//  NSString+KBExtension.m
//  ClshUser
//
//  Created by kobe on 16/6/13.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "NSString+KBExtension.h"

@implementation NSString (KBExtension)

+(CGSize)sizeWithStr:(NSString *)str
                font:(UIFont *)font
               width:(CGFloat)width
{
    
    NSDictionary *dict=@{NSFontAttributeName:font};
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:dict
                                     context:nil].size;
    return size;

}

+(void)labelString:(UILabel *)lable
              font:(UIFont *)font
             range:(NSRange)range
             color:(UIColor *)color
{
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:lable.text];
    [str addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} range:range];
    lable.attributedText=str;
}

+(NSNumberFormatter *)numberFormatter{
    //修改金额格式
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //数字格式化
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.locale=locale;
    formatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    
    return formatter;
}



+(CGSize)caculatorTextSize:(CGFloat)maxWidth
                  textFont:(UIFont *)textFont
               textContent:(NSString *)textContent{
    
    NSDictionary *dict=@{NSFontAttributeName:textFont};
    CGSize size=[textContent boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, MAXFLOAT)
                                            options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                         attributes:dict
                                            context:nil].size;
    return size;
}

@end
