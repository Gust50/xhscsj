//
//  CLSHFisrtLoadViewController.m
//  ClshUser
//
//  Created by arom on 16/5/27.
//  Copyright © 2016年 kobe. All rights reserved.
//

#import "CLSHFisrtLoadViewController.h"


@interface CLSHFisrtLoadViewController ()<UIScrollViewDelegate>{

    NSArray * _imgArray;//图片数组
    NSMutableArray * _imagMarr;
    UIPageControl * _pageControll;
    UIScrollView * _scrollView;
}

@end

@implementation CLSHFisrtLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = backGroundColor;
    
    NSDictionary * returnData = [[NSUserDefaults standardUserDefaults] objectForKey:@"yinfao"];
    NSDictionary * imgDict = returnData[@"guideAD"];
    for (NSDictionary * dict in imgDict) {
        [_imagMarr addObject:dict[@"imgPath"]];
    }
    
    _imgArray = [[NSArray alloc] init];
    _imgArray = @[@"1",@"2",@"3",@"4"];
    
    [self initUI];
}


- (void)initUI{
    
    [self createSrollView];
    [self addPageController];
}
//创建滚动视图
- (void)createSrollView{

    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH*_imgArray.count, SCREENHEIGHT);
    _scrollView.pagingEnabled = YES;//设置分页
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator=NO;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Refresh"]) {
        
        for (int i = 0; i<_imagMarr.count; i++) {
            
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, SCREENHEIGHT)];
            [imageView sd_setImageWithURL:_imagMarr[i] placeholderImage:nil];
            
            if (i == _imagMarr.count-1) {
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoHome)];
                [imageView addGestureRecognizer:tap];
            }
            [_scrollView addSubview:imageView];
        }
    }else{
    
        for (int i = 0; i<_imgArray.count; i++) {
            UIImage * image = [UIImage imageNamed:_imgArray[i]];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, SCREENHEIGHT)];
            imageView.image = image;
            
            if (i == _imgArray.count-1) {
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoHome)];
                [imageView addGestureRecognizer:tap];
            }
            [_scrollView addSubview:imageView];
        }
    }
    
}

//跳转到首页
- (void)gotoHome{

    self.pushHome();
}

//创建分页控制器
- (void)addPageController{

    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-50, SCREENWIDTH, 20)];
    _pageControll.numberOfPages = _imgArray.count;
    _pageControll.currentPage = 0;
    _pageControll.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControll.pageIndicatorTintColor = [UIColor orangeColor];
    [_pageControll addTarget:self action:@selector(pageChanged) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_pageControll];
}

- (void)pageChanged{

    [_scrollView setContentOffset:CGPointMake(_pageControll.currentPage * SCREENWIDTH, 0) animated:YES];
}

#pragma mark delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    float page = scrollView.contentOffset.x/SCREENWIDTH+0.5;
    _pageControll.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
