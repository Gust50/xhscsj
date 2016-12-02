//
//  CLGSPaymentOrderController.h
//  粗粮
//
//  Created by 吴桃波 on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSPaymentOrderController.h"


@interface CLGSPaymentOrderController : UITableViewController


@property (nonatomic, copy) NSString *typeID;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) CGFloat amount;   ///<收支金额
@end
