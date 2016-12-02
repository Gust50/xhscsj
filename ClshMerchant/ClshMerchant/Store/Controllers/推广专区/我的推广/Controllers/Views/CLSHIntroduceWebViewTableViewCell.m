//
//  CLSHIntroduceWebViewTableViewCell.m
//  ClshUser
//
//  Created by arom on 16/6/2.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHIntroduceWebViewTableViewCell.h"
#import "CLSHNeighborhoodModel.h"

@interface CLSHIntroduceWebViewTableViewCell ()<UIWebViewDelegate>

@end
@implementation CLSHIntroduceWebViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _introduceWebView.scrollView.bounces=NO;
    _introduceWebView.scrollView.showsHorizontalScrollIndicator = NO;
    _introduceWebView.scrollView.showsVerticalScrollIndicator = NO;
    _introduceWebView.userInteractionEnabled=YES;
    _introduceWebView.opaque = NO;
    _introduceWebView.backgroundColor = [UIColor whiteColor];
   
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CLSHNeighborhoodMerchantIntroductModel *)model{

    _model = model;
     _introduceWebView.delegate = self;
    [_introduceWebView loadHTMLString:model.introduction baseURL:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '90%'";
    
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width-20];
    
    
    [webView stringByEvaluatingJavaScriptFromString:str];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    _introduceWebView.hidden=NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _introduceWebView.alpha=1.0;
    }];
}


@end
