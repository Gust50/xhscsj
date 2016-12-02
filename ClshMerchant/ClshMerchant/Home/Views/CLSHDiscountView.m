//
//  CLSHDiscountView.m
//  ClshMerchant
//
//  Created by arom on 16/9/8.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHDiscountView.h"
#import "PopMenu.h"
#import "CLSHSelectDiscountViewOne.h"
#import "CLSHHomeModel.h"

@interface CLSHDiscountView()<MyPopMenuDelegate>{

    BOOL tag;
    NSString * discountID;
    CGFloat contentHeight;
    CLSHDiscountdataModel * discountDataModel;
    CLSHDiscountListModel * discountListModel;
    CLSHApplyDiscountDataModel * applyDiscountModel;
    
}

@property (nonatomic,strong)UIView * contentView;      ///<view
@property (nonatomic,strong)UILabel * messageLabel;    ///<提示
@property (nonatomic,strong)UILabel * describLabel;    ///<描述label
@property (nonatomic,strong)UIButton * discountLabel;    ///<选择折扣
@property (nonatomic,strong)UIImageView * arraowImage; ///<箭头
@property (nonatomic,strong)UIButton * sureBtn;        ///<确定按钮
@property (nonatomic,strong)CLSHSelectDiscountViewOne * listView;
@property (nonatomic,strong)NSMutableArray * dataArray; ///<数组
@end

@implementation CLSHDiscountView
#pragma mark -- 懒加载
- (UIView *)contentView{

    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 10*AppScale;
    }
    return _contentView;
}

- (UILabel *)messageLabel{

    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"折扣绑定提示";
        _messageLabel.textColor = systemColor;
        _messageLabel.font = [UIFont systemFontOfSize:17*AppScale];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

- (UILabel *)describLabel{

    if (!_describLabel) {
        _describLabel = [[UILabel alloc] init];
        _describLabel.text = @"请选择绑定折扣";
        _describLabel.textColor = RGBColor(51, 51, 51);
        _describLabel.font = [UIFont systemFontOfSize:14*AppScale];
        _describLabel.textAlignment = NSTextAlignmentRight;
    }
    return _describLabel;
}

- (UIButton *)discountLabel{

    if (!_discountLabel) {
        _discountLabel = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_discountLabel setTitle:@"请选择" forState:(UIControlStateNormal)];
        [_discountLabel setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
        _discountLabel.titleLabel.font = [UIFont systemFontOfSize:12*AppScale];
        [_discountLabel addTarget:self action:@selector(clickDiscount) forControlEvents:(UIControlEventTouchUpInside)];
        _discountLabel.layer.masksToBounds = YES;
        _discountLabel.layer.borderWidth = 1;
        _discountLabel.layer.borderColor = RGBColor(153, 153, 153).CGColor;
        _discountLabel.layer.cornerRadius = 5*AppScale;
        _discountLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _discountLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    }
    return _discountLabel;
}

//- (UILabel *)discountLabel{
//
//    if (!_discountLabel) {
//        _discountLabel = [[UILabel alloc] init];
//        _discountLabel.text = @" 请选择";
//        _discountLabel.textAlignment = NSTextAlignmentLeft;
//        _discountLabel.font = [UIFont systemFontOfSize:12*AppScale];
//        _discountLabel.textColor = RGBColor(51, 51, 51);
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickDiscount)];
//        [_discountLabel addGestureRecognizer:tap];
//        _discountLabel.layer.masksToBounds = YES;
//        _discountLabel.layer.borderWidth = 1;
//        _discountLabel.layer.borderColor = RGBColor(153, 153, 153).CGColor;
//        _discountLabel.layer.cornerRadius = 5*AppScale;
//    }
//    return _discountLabel;
//}

- (UIImageView *)arraowImage{

    if (!_arraowImage) {
        _arraowImage = [[UIImageView alloc] init];
        _arraowImage.image = [UIImage imageNamed:@"arrow_t"];
    }
    return _arraowImage;
}

- (UIButton *)sureBtn{

    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_sureBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        [_sureBtn setBackgroundColor:systemColor];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 3;
//        _sureBtn.layer.borderColor = RGBColor(102, 102, 102).CGColor;
//        _sureBtn.layer.borderWidth = 1;
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _sureBtn;
}

- (CLSHSelectDiscountViewOne *)listView{

    if (!_listView) {
        _listView = [[CLSHSelectDiscountViewOne alloc] init];
        _listView.backgroundColor = [UIColor whiteColor];
        _listView.layer.masksToBounds = YES;
        _listView.layer.borderWidth = 1;
        _listView.layer.borderColor = RGBColor(153, 153, 153).CGColor;
    }
    return _listView;
}

- (NSMutableArray *)dataArray{

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initUI];
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
        [self loadDiscountData];
    }
    return self;
}

- (void)clickDiscount{

    self.listView.dataSource = self.dataArray;
    if (!tag) {
//        contentHeight = 250*AppScale;
        CGRect rect = _discountLabel.frame;
        _contentView.frame = CGRectMake(10, SCREENHEIGHT/2-125*AppScale, SCREENWIDTH-20, 250*AppScale);
        self.listView.frame = CGRectMake(rect.origin.x+10*AppScale, SCREENHEIGHT/2-25*AppScale, 100*AppScale, 100*AppScale);
        _listView.layer.masksToBounds = YES;
        _listView.layer.cornerRadius = 5;
        [self addSubview:_listView];
        [UIView animateWithDuration:0.1 animations:^{
            
            _arraowImage.transform=CGAffineTransformMakeRotation(M_PI);
            
        }];
        tag = 1;
    }else{
    
//       contentHeight = 200*AppScale;
        [_listView removeFromSuperview];
        [UIView animateWithDuration:0.1 animations:^{
            _arraowImage.transform = CGAffineTransformIdentity;
        }];
        tag = 0;
    }
    
   

}

- (void)sureBtnClick{

    NSLog(@"....");
    //点击确认
    applyDiscountModel = [[CLSHApplyDiscountDataModel alloc]init];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"discountRateId"] = discountID;
    [applyDiscountModel fetchApplyDiscountData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
        
            self.showDiscountblock();
            
        }else{
        
            [MBProgressHUD showSuccess:@"提交失败"];
        }
        
    }];
}

- (void)initUI{

    [self addSubview:self.contentView];
    [_contentView addSubview:self.messageLabel];
    [_contentView addSubview:self.describLabel];
    [_contentView addSubview:self.discountLabel];
    [_discountLabel addSubview:self.arraowImage];
    [_contentView addSubview:self.sureBtn];
    contentHeight = 200*AppScale;
    self.listView.selectDiscountblockOne = ^(NSInteger row){
    
        discountListModel = [[CLSHDiscountListModel alloc] init];
        discountListModel = [_dataArray objectAtIndexCheck:row];
        discountID = discountListModel.discountID;
        [_discountLabel setTitle:[NSString stringWithFormat:@"%@",discountListModel.discount] forState:(UIControlStateNormal)];
        tag = 0;
        [UIView animateWithDuration:0.1 animations:^{
            _arraowImage.transform = CGAffineTransformIdentity;
        }];
        
    };
    
    [self updateConstraints];
}

- (void)loadDiscountData{

    discountDataModel = [[CLSHDiscountdataModel alloc]init];
    [discountDataModel fetchDiscountData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
       
        if (isSuccess) {
            discountDataModel = result;
            self.dataArray = [NSMutableArray arrayWithArray:discountDataModel.modelMapList];
        }else{
        }
    }];
}

- (void)updateConstraints{

    [super updateConstraints];
    WS(weakSelf);
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(10*AppScale);
        make.right.equalTo(weakSelf.mas_right).with.offset(-10*AppScale);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@(200*AppScale));
    }];
//    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(contentHeight));
//    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).with.offset(10*AppScale);
        make.left.equalTo(_contentView.mas_left).with.offset(10*AppScale);
        make.right.equalTo(_contentView.mas_right).with.offset(-10*AppScale);
        make.height.equalTo(@(20*AppScale));
    }];
    
    [_describLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_contentView.mas_centerX);
        make.top.equalTo(_messageLabel.mas_bottom).with.offset(20*AppScale);
        make.height.equalTo(@(20*AppScale));
        make.width.equalTo(@(100*AppScale));
    }];
    [_discountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_centerX).with.offset(5*AppScale);
        //make.top.equalTo(_messageLabel.mas_bottom).with.offset(20*AppScale);
        make.centerY.equalTo(_describLabel.mas_centerY);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(100*AppScale));
    }];
    
    [_arraowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_discountLabel.mas_right).with.offset(-5);
        make.top.equalTo(_discountLabel.mas_top).with.offset(10);
        make.bottom.equalTo(_discountLabel.mas_bottom).with.offset(-10);
        make.width.equalTo(@(16*AppScale));
    }];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView.mas_centerX);
        make.bottom.equalTo(_contentView.mas_bottom).with.offset(-20*AppScale);
        make.height.equalTo(@(30*AppScale));
        make.width.equalTo(@(60*AppScale));
    }];
    
}

@end
