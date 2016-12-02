//
//  LRGuidePageViewController.m
//  ClshMerchant
//
//  Created by arom on 16/8/19.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "LRGuidePageViewController.h"
#import "LRGuidePageViewCell.h"

@interface LRGuidePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{

    UICollectionView *collectionView;
    UIPageControl * _pageControll;
}
@end

@implementation LRGuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCollectionView];
    [self addPageController];
}

- (void)addCollectionView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置cell 大小
    layout.itemSize = self.view.bounds.size;
    
    // 设置滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置间距
    layout.minimumLineSpacing = 0;
    
    collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.delegate = self;
    
    collectionView.dataSource = self;
    // 隐藏滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置分页效果
    collectionView.pagingEnabled = YES;
    
    // 设置弹簧效果
    collectionView.bounces =  NO;
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[LRGuidePageViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)addPageController{

    _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-30, SCREENWIDTH, 20)];
    _pageControll.numberOfPages = _dataArray.count;
    _pageControll.currentPage = 0;
    _pageControll.currentPageIndicatorTintColor = [UIColor clearColor];
    _pageControll.pageIndicatorTintColor = [UIColor clearColor];
    [_pageControll addTarget:self action:@selector(pageChanged) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:_pageControll];
}

- (void)pageChanged{
    
    [collectionView setContentOffset:CGPointMake(_pageControll.currentPage * SCREENWIDTH, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    float page = scrollView.contentOffset.x/SCREENWIDTH+0.5;
    _pageControll.currentPage = page;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LRGuidePageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.imageviewbg.image = [UIImage imageNamed:_dataArray[indexPath.item]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _dataArray.count - 1) {
        [self presentViewController:self.viewController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray=dataArray;
}

@end
