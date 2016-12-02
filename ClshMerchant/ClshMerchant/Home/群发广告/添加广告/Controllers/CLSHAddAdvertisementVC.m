//
//  CLSHAddAdvertisementVC.m
//  ClshMerchant
//
//  Created by kobe on 16/8/3.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHAddAdvertisementVC.h"
#import "CLSHAddAdvertisementView.h"
#import "KBCustomPhotoCollectionViewController.h"
#import "KBDatePicker.h"
#import "CLSHAdManagerModel.h"
#import "CLSHSelectUserVC.h"
#import "CLSHAdvertisePreviewVC.h"
#import "CLSHUploadImageModel.h"
#import "KBRegexp.h"
#import "UIImage+KBExtension.h"



@interface CLSHAddAdvertisementVC ()<CLSHAddAdvertisementViewDelegate,KBCustomPhotoCollectionViewControllerDelegate,KBDatePickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableDictionary *adNeedParams;
    NSMutableDictionary *preNeedParams;
    CLSHUploadImageModel *upLoadImageModel;
    CLSHAddAdModel *cLSHAddAdModel;
    MBProgressHUD *hud;
    NSInteger completionCount;
    
    NSMutableArray *imageArray;    ///<设置全局图片数组
    

}
@property (nonatomic, strong) CLSHAddAdvertisementView *addAddvertisementView;
@property (nonatomic, strong) NSMutableArray *upLoadImgArr;
@property (nonatomic, strong) NSMutableArray *upLoadImgStrArr;

//@2定义一个判断相册/相机的属性 0/1
@property(nonatomic,assign)BOOL photoORcamera;


@end

@implementation CLSHAddAdvertisementVC

-(CLSHAddAdvertisementView *)addAddvertisementView{
    if (!_addAddvertisementView) {
        _addAddvertisementView=[[CLSHAddAdvertisementView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
        _addAddvertisementView.delegate=self;
    }
    return _addAddvertisementView;
}

-(NSMutableArray *)upLoadImgArr{
    if (!_upLoadImgArr) {
        _upLoadImgArr=[NSMutableArray array];
    }
    return _upLoadImgArr;
}

-(NSMutableArray *)upLoadImgStrArr{
    if (!_upLoadImgStrArr) {
        _upLoadImgStrArr=[NSMutableArray array];
    }
    return _upLoadImgStrArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"添加广告"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    adNeedParams=[NSMutableDictionary dictionary];
#warning <#message#>
    adNeedParams[@"longitude"]=@([FetchAppPublicKeyModel shareAppPublicKeyManager].longitude);
    adNeedParams[@"latitude"]=@([FetchAppPublicKeyModel shareAppPublicKeyManager].latitude);
    completionCount=0;

    
    UIImage *img=[UIImage imageNamed:@"compose_pic_add"];
    [self.upLoadImgArr addObject:img];
   
    [self.view addSubview:self.addAddvertisementView];
     _addAddvertisementView.imgArr=_upLoadImgArr;
    
    [self initModel];
    
}

-(void)initModel{
    preNeedParams=[NSMutableDictionary dictionary];
    upLoadImageModel=[CLSHUploadImageModel new];
    cLSHAddAdModel=[CLSHAddAdModel new];
}


#pragma mark <CLSHAddAdvertisementViewDelegate>
-(void)deleteImage:(UIImage *)img{
    [_upLoadImgArr removeObject:img];
    _addAddvertisementView.imgArr=_upLoadImgArr;
}

-(void)addImage{
    
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:@"请选择上传图片的方式" message: @"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
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
        
    }];
    
    UIAlertAction *photo =  [UIAlertAction actionWithTitle:@"相册" style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        KBCustomPhotoCollectionViewController *kBCustomPhotoCollectionViewController=[KBCustomPhotoCollectionViewController new];
        kBCustomPhotoCollectionViewController.delegate=self;
        kBCustomPhotoCollectionViewController.maxNumber=8;
        kBCustomPhotoCollectionViewController.isCamera = NO;
        kBCustomPhotoCollectionViewController.allowsMultipleSelection=YES;
        [self.navigationController pushViewController:kBCustomPhotoCollectionViewController animated:YES];
    }];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [camera setValue:systemColor forKey:@"_titleTextColor"];
    [photo setValue:systemColor forKey:@"_titleTextColor"];
    [cancel setValue:systemColor forKey:@"_titleTextColor"];

    [alterVC addAction:camera];
    [alterVC addAction:photo];
    [alterVC addAction:cancel];
    [self presentViewController:alterVC animated:YES completion:nil];
    
    
}



//保存头像功能
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^(){
        
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        image= [UIImage imageByScalingToMaxSize:image];
        
        NSData *originImgData=UIImageJPEGRepresentation(image, 1.0f);
        NSString *imgStr=[originImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        //添加
        [_upLoadImgArr removeLastObject];
        [self.upLoadImgArr addObject:image];
        [self.upLoadImgStrArr addObject:imgStr];
        
        UIImage *img=[UIImage imageNamed:@"compose_pic_add"];
        [_upLoadImgArr addObject:img];
        
        _addAddvertisementView.imgArr=_upLoadImgArr;
    }];
}

-(void)datePicker{
    [self.view endEditing:YES];
    KBDatePicker *datePicker=[KBDatePicker new];
    datePicker.currentDate=[NSDate date];
    datePicker.delegate=self;
    datePicker.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [datePicker showDatePicker];
}

-(void)nextStepBtn{
    
    [self.view endEditing:YES];

    if ([self validateSuccess]) {
        [self upLoadImageProgress];
    }
    
}

-(void)previewBtn{
    
    if ([self validateSuccess]) {
        CLSHAdvertisePreviewVC *cLSHAdvertisePreviewVC=[CLSHAdvertisePreviewVC new];
        cLSHAdvertisePreviewVC.dic = preNeedParams;
        
        [self.navigationController pushViewController:cLSHAdvertisePreviewVC animated:YES];
    }else{
        
    }
   
}

-(void)titleName:(NSString *)name{
    adNeedParams[@"title"]=name;
    preNeedParams[@"title"]=name;
}

-(void)textContent:(NSString *)content{
    adNeedParams[@"content"]=content;
    preNeedParams[@"content"]=content;
}

#pragma mark <KBCustomPhotoCollectionViewControllerDelegate>
-(void)KBPhotoUpLoadImages:(NSArray *)images imageBaseStringArr:(NSArray *)imgStringArr{
    
    [_upLoadImgArr removeLastObject];
    [self.upLoadImgArr addObjectsFromArray:images];
    [self.upLoadImgStrArr addObjectsFromArray:imgStringArr];
//    preNeedParams[@"img"] = _upLoadImgArr;
    NSMutableArray * imageArrayone = [NSMutableArray arrayWithArray:_upLoadImgArr];
    
    preNeedParams[@"img"] = imageArrayone;
    UIImage *img=[UIImage imageNamed:@"compose_pic_add"];
    [_upLoadImgArr addObject:img];
    
    _addAddvertisementView.imgArr=_upLoadImgArr;


}
-(void)KBPhotoUpLoadUserIcon:(UIImage *)image imageBaseString:(NSString *)baseString{
    
}


-(void)upLoadImageProgress{
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"图片上传中....";
    [self upLoadImg];
}

-(void)upLoadImg{
    
    NSMutableArray *temp=[NSMutableArray array];
    for (int i=0; i<_upLoadImgStrArr.count; i++) {
        
        __block CLSHUploadImageModel *tempModel=[CLSHUploadImageModel new];
        NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
        needParams[@"fileName"]=[NSString stringWithFormat:@"%d.jpg",i];
        needParams[@"fileType"]=@"image";
        needParams[@"base64Data"]=_upLoadImgStrArr[i];
        
        dispatch_async(dispatch_get_global_queue(2, 0), ^{
            
            [tempModel upLoadImageData:needParams callBack:^(BOOL isSuccess, id result) {
                if (isSuccess) {
                    tempModel=result;
                    completionCount++;
                    [temp addObject:tempModel.url];
                    
                    if (completionCount==_upLoadImgStrArr.count) {
                        hud.labelText=[NSString stringWithFormat:@"上传已经完成"];
                        adNeedParams[@"iamges"]=temp;
                        [hud hide:YES];
//                        [self upLoad];
                        
                        CLSHSelectUserVC *cLSHSelectUserVC=[CLSHSelectUserVC new];
                        cLSHSelectUserVC.needParams=adNeedParams;
                        [self.navigationController pushViewController:cLSHSelectUserVC animated:YES];
                        completionCount=0;
                    }else{
                        hud.labelText=[NSString stringWithFormat:@"已经上传了%ld张",completionCount];
                    }
                    
                    
                }else{
                    completionCount++;
                    if (completionCount==_upLoadImgStrArr.count) {
                        hud.labelText=[NSString stringWithFormat:@"上传已经完成"];
                         adNeedParams[@"iamges"]=temp;
                        [hud hide:YES];
//                        [self upLoad];
                        CLSHSelectUserVC *cLSHSelectUserVC=[CLSHSelectUserVC new];
                         cLSHSelectUserVC.needParams=adNeedParams;
                        [self.navigationController pushViewController:cLSHSelectUserVC animated:YES];
                        completionCount=0;
                    }else{
                        hud.labelText=[NSString stringWithFormat:@"已经上传了%ld张",completionCount];
                    }
                    
                }
            }];
        });
        
    }
}


//-(void)upLoad{
//    
//    [cLSHAddAdModel fetchAddAdData:adNeedParams callBack:^(BOOL isSuccess, id result) {
//       
//        if (isSuccess) {
//              [MBProgressHUD showSuccess:@"添加广告成功"];
//            CLSHSelectUserVC *cLSHSelectUserVC=[CLSHSelectUserVC new];
//            [self.navigationController pushViewController:cLSHSelectUserVC animated:YES];
//        }else{
//             [MBProgressHUD showError:result];
//        }
//    }];
//}


-(BOOL)validateSuccess{
    
    if ([adNeedParams[@"title"] length]==0 || adNeedParams[@"title"] == nil || [KBRegexp isBlankString:adNeedParams[@"title"]]) {
        [MBProgressHUD showError:@"标题名称不能为空"];
        return NO;
    }else if ([adNeedParams[@"endDate"] length]==0){
        [MBProgressHUD showError:@"请选择时间"];
        return NO;
    }else if ([adNeedParams[@"content"] length]==0 || [KBRegexp isBlankString:adNeedParams[@"content"]]){
        [MBProgressHUD showError:@"广告内容不能为空"];
        return NO;
    }else if (_upLoadImgStrArr.count==0){
        [MBProgressHUD showError:@"请选择图片"];
        return NO;
    }else{
        
        return YES;
    }
}

#pragma mark <KBDatePickerDelegate>
-(void)showDataPicker:(NSString *)string timeString:(NSString *)timeString{
    adNeedParams[@"endDate"]=timeString;
    _addAddvertisementView.showDatePickerTime=string;
    NSLog(@"%@",timeString);
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
//    NSDate *dateTime = [[NSDate alloc] init];
//    NSDate *now = [[NSDate alloc] init];
//    NSString *dateNow = [dateFormatter stringFromDate:[NSDate date]];
//
//    dateTime = [dateFormatter dateFromString:timeString];
//    now = [dateFormatter dateFromString:dateNow];
//    
//    NSComparisonResult result = [dateTime compare:now];
//    if (result == NSOrderedSame) {
//        
//    }
//    else if(result == NSOrderedAscending){
//        [MBProgressHUD showError:@"所选时间小于当前时间"];
//        
//    }else if(result == NSOrderedDescending){
//        
//    }
    
}

@end
