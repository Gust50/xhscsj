//
//  CLGSApplicationFooterView.h
//  粗粮
//
//  Created by 吴桃波 on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^confirmWithdrawalsBlock)();
typedef void(^recordApplyDrawalsBlock)();

//申请提现2
@interface CLGSApplicationFooterView : UIView
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmTap;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *confirmHeight;

//确认提现
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic, copy) confirmWithdrawalsBlock withdrawalsBlock;
@property (nonatomic, copy) recordApplyDrawalsBlock recordApplyDrawalsblock;
@end
