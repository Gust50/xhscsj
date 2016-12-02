//
//  CLSHIntroduceTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/6/1.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHIntroduceTableViewCell.h"
#import "CLSHNeighborhoodModel.h"

@implementation CLSHIntroduceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)navigationButton:(id)sender {

    if (self.navigationblock) {
        self.navigationblock();
    }
}

- (IBAction)callButton:(id)sender {
    
    if (self.callblock) {
        self.callblock();
    }
}

- (void)setModel:(CLSHNeighborhoodMerchantIntroductModel *)model{

    _model = model;
    self.AddressLabel.text = model.address;
    self.bussinessTimelabel.text = [NSString stringWithFormat:@"%@-%@",model.dailyOpenTime,model.dailyClosedTime];
    self.TelephoneLabel.text = [NSString stringWithFormat:@"电话：%@",model.phoneNumber];
}

@end
