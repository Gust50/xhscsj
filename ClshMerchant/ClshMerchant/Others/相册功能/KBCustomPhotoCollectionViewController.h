//
//  KBCustomPhotoCollectionViewController.h
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


#import <UIKit/UIKit.h>

@protocol KBCustomPhotoCollectionViewControllerDelegate <NSObject>

/**
 *  上传头像
 *
 *  @param image      图片
 *  @param baseString 图片转换成字符串格式
 */
-(void)KBPhotoUpLoadUserIcon:(UIImage *)image imageBaseString:(NSString *)baseString;
/**
 *  上传图片
 *
 *  @param images       图片数组
 *  @param imgStringArr 图片转换好字符串格式的数组
 */
-(void)KBPhotoUpLoadImages:(NSArray *)images imageBaseStringArr:(NSArray *)imgStringArr;
@end

@interface KBCustomPhotoCollectionViewController : UICollectionViewController
@property (nonatomic, weak) id<KBCustomPhotoCollectionViewControllerDelegate>delegate;
@property (nonatomic, assign) BOOL allowsMultipleSelection;    ///<是否允许多选
@property (nonatomic, assign) NSInteger maxNumber;            ///<最多可以选择多少张
@property (nonatomic, assign) BOOL isCamera;                  ///>provide camera function
-(void)KBCamera;
@end
