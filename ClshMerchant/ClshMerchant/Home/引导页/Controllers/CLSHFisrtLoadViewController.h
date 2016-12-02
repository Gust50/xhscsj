//
//  CLSHFisrtLoadViewController.h
//  ClshUser
//
//  Created by arom on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidPushHome)();

@interface CLSHFisrtLoadViewController : UIViewController

@property (nonatomic, copy) DidPushHome pushHome;

@end
