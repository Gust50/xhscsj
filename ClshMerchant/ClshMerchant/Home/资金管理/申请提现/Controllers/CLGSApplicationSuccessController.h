//
//  CLGSApplicationSuccessController.h
//  粗粮
//
//  Created by 吴桃波 on 16/4/26.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSApplicationSuccessController.h"
//提现成功
@interface CLGSApplicationSuccessController : UIViewController

//右边提现金额
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;

@property(nonatomic,copy)NSString  *money;
@property (nonatomic,assign)BOOL notHomePage;
@end
