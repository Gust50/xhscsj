//
//  CLSHIntroduceTableViewCell.h
//  ClshUser
//
//  Created by arom on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBlock)();
typedef void(^NavigationBlock)();


@class CLSHNeighborhoodMerchantIntroductModel;
@interface CLSHIntroduceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bussinessTimelabel;

@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *TelephoneLabel;

@property (nonatomic, copy)CallBlock callblock;
@property (nonatomic, copy)NavigationBlock navigationblock;
@property (nonatomic,strong)CLSHNeighborhoodMerchantIntroductModel * model;

@end
