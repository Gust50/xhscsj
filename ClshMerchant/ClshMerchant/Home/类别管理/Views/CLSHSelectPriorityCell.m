//
//  CLSHSelectPriorityCell.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/27.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHSelectPriorityCell.h"

@interface CLSHSelectPriorityCell ()
{
    NSInteger selectTag;    ///<设置全局选中哪个按钮
    NSMutableDictionary *dic;
}


@property (nonatomic, strong) NSMutableArray *btnArr;
@end
@implementation CLSHSelectPriorityCell

-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr=[NSMutableArray array];
    }
    return _btnArr;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        dic = [NSMutableDictionary dictionary];
         self.priority = 1;
        dic[@"priority"] = @(self.priority);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getPriority" object:nil userInfo:dic];
        [_btnArr removeAllObjects];
        for (int i = 0; i < 7; i++) {
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*(SCREENWIDTH/7), 0, SCREENWIDTH/7, 40*AppScale)];
            backView.backgroundColor = [UIColor whiteColor];
            UIButton *select= [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH/14-8*AppScale, 40*AppScale/2-8*AppScale, 16*AppScale, 16*AppScale)];
            select.layer.cornerRadius = 8.0*AppScale;
            select.layer.masksToBounds = YES;
            select.titleLabel.font = [UIFont systemFontOfSize:10*AppScale];
            select.tag = i+1;
            NSString *titleStr = [NSString stringWithFormat:@"%zi", select.tag];
            [select setTitle:titleStr forState:UIControlStateNormal];
            [backView addSubview:select];
            [self addSubview:backView];
            [select addTarget:self action:@selector(isSelectPriority:) forControlEvents:UIControlEventTouchUpInside];
            //默认选中第一个
            if (i == 0) {
                select.selected = YES;
                select.backgroundColor = systemColor;
            }else
            {
               select.selected = NO;
               select.backgroundColor = RGBColor(142, 142, 142);
            }
            
            [self.btnArr addObject:select];
        }
        
    }
    return self;
}

- (void)isSelectPriority:(UIButton *)sender
{
    [self cancelAll];
    sender.backgroundColor = systemColor;

    self.priority = sender.tag;
    dic[@"priority"] = @(self.priority);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getPriority" object:nil userInfo:dic];
}

-(void)cancelAll{
    for (UIButton *btn in _btnArr) {
        btn.selected=NO;
        btn.backgroundColor = RGBColor(142, 142, 142);
    }
}

@end
