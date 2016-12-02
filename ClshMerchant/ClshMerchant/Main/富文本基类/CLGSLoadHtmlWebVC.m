//
//  CLGSLoadHtmlWebVC.m
//  粗粮
//
//  Created by kobe on 16/5/10.
//  Copyright © 2016年 胡天虎. All rights reserved.
//

#import "CLGSLoadHtmlWebVC.h"
#import "Masonry.h"

@interface CLGSLoadHtmlWebVC ()<UIWebViewDelegate>
{
    MBProgressHUD *mBProgressHUD;
}


@end

@implementation CLGSLoadHtmlWebVC


-(UIWebView *)webView{
    if (!_webView) {
        
        _webView=[[UIWebView alloc]init];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    self.view.backgroundColor=[UIColor whiteColor];
    
    _webView.scrollView.bounces=NO;
    _webView.userInteractionEnabled=YES;
    _webView.scrollView.showsHorizontalScrollIndicator=NO;
    
    [self updateViewConstraints];
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _webView.delegate=self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _webView.delegate=nil;
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

-(void)dealloc{
    [mBProgressHUD removeFromSuperview];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
//    mBProgressHUD=[toastView showDefaultInview:[UIApplication sharedApplication].keyWindow];
    _webView.hidden=YES;
    _webView.alpha=0.1;
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [mBProgressHUD hide:YES];
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '60%'";
    
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
    _webView.hidden=NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _webView.alpha=1.0;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
@end
