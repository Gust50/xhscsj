//
//  CLGSApplicationFooterView.m
//  粗粮
//
//  Created by 吴桃波 on 16/4/25.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSApplicationFooterView.h"

@implementation CLGSApplicationFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)awakeFromNib{
    self.confirmTap.constant = 50*AppScale;
    self.confirmHeight.constant = 40*AppScale;
    //背景色
    self.backgroundColor=RGBColor(240, 240, 243);
    
    //设置圆角
    self.confirmBtn.layer.cornerRadius = 5.0;
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.backgroundColor = RGBColor(0, 149, 68);
    self.confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15*AppScale];
}

//确认提现按钮通知控制器跳转
- (IBAction)footerBtn:(UIButton *)sender {
    
    if (self.withdrawalsBlock) {
        self.withdrawalsBlock();
    }
}
- (IBAction)ApplyDrawalsBtn:(id)sender {
    if (self.recordApplyDrawalsblock) {
        self.recordApplyDrawalsblock();
    }
}

@end
