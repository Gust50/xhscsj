//
//  KBCustomPhotoCollectionViewController.m
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


#import "KBCustomPhotoCollectionViewController.h"
#import <Photos/Photos.h>
#import "KBCustomPhotoCollectionViewCell.h"
#import "KBCustomPhotoCollectionReusableView.h"
#import "KBImageToolViewController.h"
#import "UIImage+KBExtension.h"
#import "UINavigationBar+Awesome.h"

@interface KBCustomPhotoCollectionViewController ()<UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,KBImageToolViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray *allPhotos;
@property(nonatomic,strong)NSMutableArray *selectedPhotos;

@end

@implementation KBCustomPhotoCollectionViewController

static NSString *const kID = @"Cell";
static NSString *const kFooter=@"Footer";



#pragma mark-LazyLoad
-(NSMutableArray *)allPhotos{
    if (!_allPhotos) {
        _allPhotos=[NSMutableArray array];
    }
    return _allPhotos;
}

-(NSMutableArray *)selectedPhotos{
    if (!_selectedPhotos) {
        _selectedPhotos=[NSMutableArray array];
    }
    return _selectedPhotos;
}


#pragma mark-LifeCycle
/**
 *  Overrides This Method(重写这个方法)
 *
 *  @return FlowLayout(返回一个流水布局)
 */
-(instancetype)init{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //Collumn spacing(列)
    flowLayout.minimumInteritemSpacing=1.0;
    //Row spacing(行)
    flowLayout.minimumLineSpacing=1.0;
    return [self initWithCollectionViewLayout:flowLayout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNaviagaionBar];
    [self loadPhotoResources];
    [self.collectionView registerClass:[KBCustomPhotoCollectionViewCell class] forCellWithReuseIdentifier:kID];
    [self.collectionView registerClass:[KBCustomPhotoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooter];
    if (_allowsMultipleSelection) {
        self.collectionView.allowsMultipleSelection=YES;
    }else{
        self.collectionView.allowsMultipleSelection=NO;
    }
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"Authorized");
            [self loadPhotoResources];
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
}

#pragma -mark nav
-(void)initWithNaviagaionBar{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelected)];
    
    
    self.navigationItem.title=@"相册";
    
    //导航栏标题的颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [right setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem=right;
}


#pragma mark-Fetch Photo Resources
-(void)loadPhotoResources{
    
    //Fetch All PhotoGroups(获取所有的相册资源)
    PHFetchResult *allPhotoGroups=[PHAssetCollection fetchMomentsWithOptions:nil];
    
    //Traverse All PhotoGroups(遍历所有的相册资源)
    for (PHAssetCollection *collection in allPhotoGroups) {
        
        //Fetch a collection of each photoGroups(获取每个相册的资源集合)
        PHFetchResult *group=[PHAsset fetchAssetsInAssetCollection:collection options:nil];
        
        //Traverse collection(遍历每个相册集合的资源)
        for (PHAsset *asset in group) {
            [self.allPhotos addObject:asset];
        }
    }
    //    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        
    });
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_isCamera) {
        return _allPhotos.count+1;
    }else{
        return _allPhotos.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KBCustomPhotoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kID forIndexPath:indexPath];
    
    PHCachingImageManager *imageManager=[[PHCachingImageManager alloc]init];
    PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
    options.synchronous=YES;
    
    if (_isCamera) {
        
        if (indexPath.item==0) {
            cell.thumbImage=nil;
            cell.showOverLayerWhenSelected=NO;
        }else{
            cell.showOverLayerWhenSelected=YES;
            PHAsset *asset=_allPhotos[indexPath.item-1];
            [imageManager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                cell.thumbImage=result;
                
            }];}
        
    }else{
        
        cell.showOverLayerWhenSelected=YES;
        PHAsset *asset=_allPhotos[indexPath.item];
        [imageManager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            cell.thumbImage=result;
            
        }];
    }
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind==UICollectionElementKindSectionFooter) {
        
        KBCustomPhotoCollectionReusableView *footer=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooter forIndexPath:indexPath];
        footer.photoNumbers=_allPhotos.count;
        return footer;
    }
    return nil;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.view.bounds.size.width-3)/4, (self.view.bounds.size.width-3)/4);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.bounds.size.width, 40.0);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isCamera) {
        
        if (indexPath.item==0) {
            //使用相机拍照功能
            [self camera];
        }else{
            
            PHAsset *asset=[_allPhotos objectAtIndex:(indexPath.item-1)];
            [self.selectedPhotos addObject:asset];
        }
        
    }else{
        
        PHAsset *asset=[_allPhotos objectAtIndex:(indexPath.item)];
        [self.selectedPhotos addObject:asset];
        
    }

}



-(BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_selectedPhotos.count>=_maxNumber) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"最多%ld张",_maxNumber]];
        return NO;
    }
    return YES;
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_isCamera) {
        
        if (indexPath.item==0) {
            
        }else{
            
            PHAsset *asset=[_allPhotos objectAtIndex:(indexPath.item-1)];
            [self.selectedPhotos removeObject:asset];
        }
    }else{
        
        PHAsset *asset=[_allPhotos objectAtIndex:(indexPath.item)];
        [self.selectedPhotos removeObject:asset];
        
    }

}


#pragma makr-otherResponse

-(void)finishSelected{
    PHCachingImageManager *imageManager=[[PHCachingImageManager alloc]init];
    PHImageRequestOptions *options=[[PHImageRequestOptions alloc]init];
    options.synchronous=YES;
    
    
    NSMutableArray *tempImageArr=[NSMutableArray array];
    NSMutableArray *tempImageStrArr=[NSMutableArray array];
    
    for (PHAsset *asset in _selectedPhotos) {
        
        [imageManager requestImageForAsset:asset targetSize:CGSizeMake(800, 800) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            
            if (result==NULL) {
                
            }else{
                
                [tempImageArr addObject:result];
                
                NSData *originImgData=UIImageJPEGRepresentation(result, 0.5f);
                NSString *imgStr=[originImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                [tempImageStrArr addObject:imgStr];
            }
            
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(KBPhotoUpLoadImages:imageBaseStringArr:)]) {
        [self.delegate KBPhotoUpLoadImages:tempImageArr imageBaseStringArr:tempImageStrArr];
    }
    [_selectedPhotos removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)camera{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        camera.allowsEditing=YES;
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            camera.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        camera.delegate = self;
        [self presentViewController:camera animated:YES completion:nil];
    }
}

-(void)KBCamera{
    
    [self camera];
}
//上传图片裁剪功能以及上传头像功能
-(void)imageCropper:(KBImageToolViewController *)mImageDealTool didFinished:(UIImage *)editedImage{
    NSData *originImgData=UIImageJPEGRepresentation(editedImage, 1.0f);
    NSString *imgStr=[originImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(KBPhotoUpLoadUserIcon:imageBaseString:)]) {
        [self.delegate KBPhotoUpLoadUserIcon:editedImage imageBaseString:imgStr];
    }
    [mImageDealTool dismissViewControllerAnimated:YES completion:nil];
}


//出栈
-(void)imageCropperCancel:(KBImageToolViewController *)mImageDealTool{
    [mImageDealTool dismissViewControllerAnimated:YES completion:nil];
}

//保存头像功能
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^(){
        
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        image= [UIImage imageByScalingToMaxSize:image];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSData *originImgData=UIImageJPEGRepresentation(image, 1.0f);
            NSString *imgStr=[originImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(KBPhotoUpLoadUserIcon:imageBaseString:)]) {
                [self.delegate KBPhotoUpLoadUserIcon:image imageBaseString:imgStr];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        });
    }];
}


//显示是否保存图片成功
-(void)showSaveImageStatus{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"Status" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveStatus=[UIAlertAction actionWithTitle:@"Save success" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:saveStatus];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark <getter setter>
-(void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection{
    _allowsMultipleSelection=allowsMultipleSelection;
}


-(void)setMaxNumber:(NSInteger)maxNumber{
    _maxNumber=maxNumber;
}

-(void)setIsCamera:(BOOL)isCamera{
    
    _isCamera=isCamera;
}
@end
