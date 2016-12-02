//
//  KBCustomPhotoTableViewController.m
//  KBCustomPhoto
//
//  Created by kobe on 16/3/23.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBCustomPhotoTableViewController.h"
#import <Photos/Photos.h>


@interface KBCustomPhotoTableViewController ()

/** 保存相册 */
@property(nonatomic,strong)NSArray *photoGroups;



@end

@implementation KBCustomPhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/**
 *  Get All PhotoGroups(获取所有的相册组数据)
 */
-(void)fetchAllPhotoGroups{
    
    NSMutableArray *allPhotos=[NSMutableArray array];
    //Fetch All PhotoGroups (获取所有的相册资源)
    PHFetchResult *allGroups=[PHAssetCollection fetchMomentsWithOptions:nil];
    
    //Traverse All PhotoGroups(遍历所有的相册资源)
    for (PHAssetCollection *collection in allGroups) {
        PHFetchResult *group=[PHAsset fetchAssetsInAssetCollection:collection options:nil];
        //Traverse All PHAsset In PhotoGroups(遍历每个相册里面的资源文件（图片）)
        for (PHAsset *asset in group) {
            [allPhotos addObject:asset];
        }
    }
    self.photoGroups=@[allPhotos];
}


@end
