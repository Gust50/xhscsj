//
//  UIButton+KBExtension.m
//  ClshMerchant
//
//  Created by kobe on 16/8/5.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "UIButton+KBExtension.h"
#import <objc/runtime.h>

#define kDefaultInterval 0.0

@implementation UIButton (KBExtension)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //get sel
        SEL selA=@selector(sendAction:to:forEvent:);
        SEL selB=@selector(customSendAction:to:forEvent:);
        
        //get method
        Method methodA=class_getInstanceMethod(self, selA);
        Method methodB=class_getInstanceMethod(self, selB);
        
        //add methodB to system
        BOOL isAddSuccess=class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        
        //if yes
        if (isAddSuccess) {
            
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

//custom action
-(void)customSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        self.timeInterval=self.timeInterval==0 ? kDefaultInterval:self.timeInterval;
        self.isEnableClickBtn=self.isEnableClickBtn==0? YES:self.isEnableClickBtn;
        if (!self.isEnableClickBtn) {
            return;
        }else if (self.timeInterval>0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }
    }
    self.isEnableClickBtn=NO;
    [self customSendAction:action to:target forEvent:event];
}

#pragma mark <otherResponse>
-(void)resetState{
    [self setIsEnableClickBtn:YES];
}

#pragma mark <getter setter>
-(void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

-(void)setIsEnableClickBtn:(BOOL)isEnableClickBtn{
    
    objc_setAssociatedObject(self, @selector(isEnableClickBtn), @(isEnableClickBtn), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isEnableClickBtn{
    //_cmd isqual @select(isEnaleClickBtn)
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
