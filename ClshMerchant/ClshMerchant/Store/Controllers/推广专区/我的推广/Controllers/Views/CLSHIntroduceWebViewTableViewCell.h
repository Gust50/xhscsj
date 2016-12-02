//
//  CLSHIntroduceWebViewTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLSHNeighborhoodMerchantIntroductModel;

@interface CLSHIntroduceWebViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIWebView *introduceWebView;

@property (nonatomic,strong)CLSHNeighborhoodMerchantIntroductModel * model;
@end
