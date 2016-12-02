//
//  NSNull+KBExtension.m
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


#import "NSNull+KBExtension.h"
#import <objc/runtime.h>

#ifdef NULLSAFE_ENABLED
#define NULLSAFE_ENABLED 1
#endif

#pragma GCC diagnostic ignored "-Wgnu-conditional-omitted-operand"

@implementation NSNull (KBExtension)

#if NULLSAFE_ENABLED
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    @synchronized([self class])
    {
        
        NSMethodSignature *signature=[super methodSignatureForSelector:aSelector];
        if (!signature)
        {
            static NSMutableSet *classList=nil;
            static NSMutableDictionary *signatureCache=nil;
            if (signatureCache==nil)
            {
                classList=[[NSMutableSet alloc]init];
                signatureCache=[[NSMutableDictionary alloc]init];
                
                //get class list
                int numClasses=objc_getClassList(NULL, 0);
                Class *classes=(Class *)malloc(sizeof(Class)*(unsigned long)numClasses);
                numClasses=objc_getClassList(classes, numClasses);
                
                NSMutableSet *excluded=[NSMutableSet set];
                for (int i=0; i<numClasses; i++)
                {
                    Class someClass=classes[i];
                    Class superclass=class_getSuperclass(someClass);
                    while (superclass)
                    {
                        if (superclass==[NSObject class])
                        {
                            [classList addObject:someClass];
                            break;
                        }
                        [excluded addObject:NSStringFromClass(superclass)];
                        superclass=class_getSuperclass(superclass);
                    }
                }
                
                for (Class someClass in excluded)
                {
                    [classList removeObject:someClass];
                }
                
                free(classes);
            }
            
            NSString *selectorString=NSStringFromSelector(aSelector);
            signature=signatureCache[selectorString];
            if (!signature)
            {
                for (Class someClass in classList)
                {
                    if ([someClass instanceMethodSignatureForSelector:aSelector])
                    {
                        signature=[someClass instanceMethodSignatureForSelector:aSelector];
                        break;
                    }
                }
                signatureCache[selectorString]=signature ?: [NSNull null];
            }
            
            else if ([signature isKindOfClass:[NSNull class]])
            {
                signature=nil;
            }
        }
        return signature;
    }
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    anInvocation.target=nil;
    [anInvocation invoke];
}

#endif

@end
