//
//  KBTimer.m
//  ClshUser
//
//  Created by kobe on 16/6/6.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBTimer.h"
#import "KBLabel.h"

@implementation KBTimer

-(void)countDown:(UILabel *)lable{
    __block NSInteger timeout=59;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t  _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<=0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置Label属性
                lable.text=@"获取语音验证码";
                lable.userInteractionEnabled=YES;
                
            });
        }else{
            NSInteger seconds=timeout%60;
            NSString *strTime=[NSString stringWithFormat:@"%0.2ld",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的显示界面
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                lable.text=[NSString stringWithFormat:@"%@秒重新发送",strTime];
                [UIView commitAnimations];
                lable.userInteractionEnabled=NO;
                timeout--;
            });
        }
    });
    dispatch_resume(_timer);
}

@end
