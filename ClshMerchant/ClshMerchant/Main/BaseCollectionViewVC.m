//
//  BaseCollectionViewVC.m
//  ClshMerchant
//
//  Created by kobe on 16/7/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "BaseCollectionViewVC.h"

@interface BaseCollectionViewVC ()
@property (nonatomic, copy) leftBarButtonBlock leftBarButtonBlock;
@property (nonatomic, copy) rightBarButtonBlock rightBarButtonBlock;
@end

@implementation BaseCollectionViewVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}


-(void)configureLeftBarButtonWithTitle:(NSString *)title
                             normalImg:(NSString *)normal
                             selectImg:(NSString *)selectImg
                                action:(leftBarButtonBlock)action{
    
    self.leftBarButtonBlock=action;
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem normalTitle:title selectTitle:title normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:normal selectImage:selectImg target:self action:@selector(back) size:CGSizeMake(50*AppScale, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}


-(void)back{
    if (self.leftBarButtonBlock) {
        self.leftBarButtonBlock();
    }
}

-(void)configureRightBarButtonWithTitle:(NSString *)title
                              normalImg:(NSString *)normal
                              selectImg:(NSString *)selectImg
                                 action:(rightBarButtonBlock)action{
    
    self.rightBarButtonBlock=action;
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem normalTitle:title selectTitle:title normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] normalImage:normal selectImage:selectImg target:self action:@selector(rightAction) size:CGSizeMake(50*AppScale, 20) titleFont:[UIFont systemFontOfSize:14*AppScale]];
}

-(void)rightAction{
    if (self.rightBarButtonBlock) {
        self.rightBarButtonBlock();
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
