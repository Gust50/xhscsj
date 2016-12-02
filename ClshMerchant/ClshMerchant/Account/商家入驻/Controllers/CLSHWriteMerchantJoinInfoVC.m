//
//  CLSHWriteMerchantJoinInfoVC.m
//  ClshMerchant
//
//  Created by wutaobo on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHWriteMerchantJoinInfoVC.h"
#import "CLSHWriteJoinInfoFooter.h"
#import "CLSHinputMerchantJoinCell.h"
#import "CLSHIndetityImageCell.h"
#import "CLSHBusinessStyleCell.h"
#import "CLSHMerchantJoinSelectAddressCell.h"
#import "CLSHIsJoinDiscountCell.h"
#import "CLSHLocationAddressCell.h"
#import "CLSMerchantJoinSuccessVC.h"
#import "CLSHMerchantJoinModel.h"
#import "KBCustomPhotoCollectionViewController.h"
#import "CLSHUploadImageModel.h"
#import "CLSHSelectDiscountCell.h"
#import "CLSHHomeModel.h"
#import "CLSHSelectDiscountView.h"
#import "CLSHJoinDiscountView.h"
#import "UIImage+KBExtension.h"

#import "CLSHApplicationSubmitSucVC.h"
#import <AMapLocationKit/AMapLocationKit.h>

#import "MapController.h"//@2高德地图界面

@interface CLSHWriteMerchantJoinInfoVC ()<UITableViewDelegate, UITableViewDataSource, CLSHinputMerchantJoinCellDelegate,CLSHIndetityImageCellDelegate,KBCustomPhotoCollectionViewControllerDelegate, CLSHIsJoinDiscountCellDelegate,AMapLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
     AMapLocationManager *aMapLocationManager;
    CLSHMerchantJoinInfoModel *infoModel; ///<填写商家入驻资料
    CLSHDiscountdataModel * discountDataModel;
    CLSHDiscountListModel * discountListModel;
    NSString * discountID;
    NSInteger tag;
    
    NSString * discountNum;      ///<折扣
    NSString *addressId;        ///<地址id
    NSString *shopName;         ///<店铺名称
    NSString *detailAddress1;    ///<详细地址
    NSString *discountValues;
    BOOL isAgreeProtcol;       ///<是否同意协议
    
    NSString *selectAddress;
    NSString *longitude1;        ///<经度
    NSString *latitude1;         ///<纬度
    
    CGFloat longitude;
    CGFloat latitude;
    
    NSMutableDictionary *imgDict;
    NSString *tempImgStr;
    NSString *tempTypeName;
    CLSHUploadImageModel *cLSHUploadImageModel;
    NSMutableDictionary *infoParams;
    
    BOOL isJoinDiscount;    ///<判断是否参加打折
    NSString *loccotionAddress;//定位地址

    MBProgressHUD * hud;

}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray * discountArray;
@property (nonatomic,strong)CLSHJoinDiscountView * DiscountlistView;
@property (nonatomic, strong) NSIndexPath *tempIndexPath;
@property (nonatomic, strong)CLSHMerchantJoinModel *merchantjoinModel;

@end

static NSString *const inputMerchantJoinID = @"CLSHinputMerchantJoinCell";
static NSString *const indetityImageID = @"CLSHIndetityImageCell";
static NSString *const businessStyleID = @"CLSHBusinessStyleCell";
static NSString *const selectAddressID = @"CLSHMerchantJoinSelectAddressCell";
static NSString *const isJoinPromotionID = @"CLSHIsJoinDiscountCell";
static NSString *const locationAddressID = @"CLSHLocationAddressCell";
@implementation CLSHWriteMerchantJoinInfoVC

#pragma mark - lazyLoad

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}

- (NSMutableArray *)discountArray{

    if (!_discountArray) {
        _discountArray = [NSMutableArray array];
    }
    return _discountArray;
}

- (CLSHJoinDiscountView *)DiscountlistView{
    
    if (!_DiscountlistView) {
        _DiscountlistView = [[CLSHJoinDiscountView alloc] initWithFrame:CGRectMake(0, 0,SCREENWIDTH,SCREENHEIGHT)];
        _DiscountlistView.backgroundColor = [UIColor clearColor];
    }
    return _DiscountlistView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self loadFooter];
    self.view.backgroundColor = backGroundColor;
    [self.navigationItem setTitle:@"填写商家入驻资料"];
    infoParams = [NSMutableDictionary dictionary];
    [self loadDiscountListData];
    
    imgDict=[NSMutableDictionary dictionary];
    
    infoModel = [[CLSHMerchantJoinInfoModel alloc] init];
    cLSHUploadImageModel=[CLSHUploadImageModel new];
    
    //注册cell
    [self.tableView registerClass:[CLSHinputMerchantJoinCell class] forCellReuseIdentifier:inputMerchantJoinID];
    [self.tableView registerClass:[CLSHIndetityImageCell class] forCellReuseIdentifier:indetityImageID];
    [self.tableView registerClass:[CLSHBusinessStyleCell class] forCellReuseIdentifier:businessStyleID];
    [self.tableView registerClass:[CLSHMerchantJoinSelectAddressCell class] forCellReuseIdentifier:selectAddressID];
    [self.tableView registerClass:[CLSHSelectDiscountCell class] forCellReuseIdentifier:isJoinPromotionID];
    [self.tableView registerClass:[CLSHLocationAddressCell class] forCellReuseIdentifier:locationAddressID];
    //接收地址通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressName:) name:@"selectAddress" object:nil];
    
    //@2
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getLocationInformation:) name:@"LocationInformation" object:nil];
     _merchantjoinModel = [[CLSHMerchantJoinModel alloc] init];
}

//地址id
- (void)addressName:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    addressId = dic[@"areaId"];
    selectAddress=dic[@"shopAddress"];
}
#pragma mark - loaddiscountListData
- (void)loadDiscountListData{

    discountDataModel = [[CLSHDiscountdataModel alloc]init];
    [discountDataModel fetchDiscountData:nil callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            discountDataModel = result;
            self.discountArray = [NSMutableArray arrayWithArray:discountDataModel.modelMapList];
        }else{
        }
    }];
}

#pragma mark - loadData
- (void)loadData
{
    if ([self ValidateIsSuccess]) {
        
        infoParams[@"shopId"] = self.shopId;
        infoParams[@"shopName"] = shopName;
        
        infoParams[@"industryId"] = self.industryId;
        infoParams[@"areaId"] = addressId;
        infoParams[@"address"] = detailAddress1;
        infoParams[@"discountId"] = discountID;
        infoParams[@"longitude"] = @([longitude1 floatValue]);
        infoParams[@"latitude"] = @([latitude1 floatValue]);
    
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.6];
        hud.color=[UIColor colorWithWhite:1.0 alpha:0.6];
        hud.activityIndicatorColor=systemColor;
        [infoModel fetchMerchantJoinInfoData:infoParams callBack:^(BOOL isSuccess, id result){
            if (isSuccess) {
                [hud hide:YES];
                CLSHApplicationSubmitSucVC *sucVC = [[CLSHApplicationSubmitSucVC alloc] init];
                [self.navigationController pushViewController:sucVC animated:YES];
            }else
            {
                [hud hide:YES];
                [MBProgressHUD showError:result];
            }
        }];
    }
}

//表单验证
- (BOOL)ValidateIsSuccess
{
    NSString *strID = [NSString stringWithFormat:@"%zi", addressId];
    if (shopName.length == 0) {
        [MBProgressHUD showError:@"请输入店铺名称"];
        return NO;
    }else if (discountNum == 0){
    
        [MBProgressHUD showError:@"请选择折扣"];
        return NO;
    }
    else if (strID.length == 0)
    {
        [MBProgressHUD showError:@"请选择店铺地址"];
        return NO;
    } else if (longitude1 ==0 || latitude1 == 0)
    {
        [MBProgressHUD showError:@"请获取经纬度"];
        return NO;
    }
        else if (detailAddress1.length == 0)
    {
        [MBProgressHUD showError:@"请输入店铺详细地址"];
        return NO;
    }
    else if (longitude1 ==0 || latitude1 == 0)
    {
        [MBProgressHUD showError:@"选择店铺定位"];
        return NO;
    }else if (!isAgreeProtcol){
    
        [MBProgressHUD showError:@"您还没有同意嗅虎商城商家协议"];
        return NO;
    }
    else
    {
        return YES;
    }
    return nil;
}

- (void)loadFooter
{
    CLSHWriteJoinInfoFooter *footer = [[CLSHWriteJoinInfoFooter alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80*AppScale)];
    //立即申请
    footer.immediatelyApplicationBlock = ^(){
        [self loadData];
    };
    footer.agreeProtcolblock = ^(BOOL isAgree){
    
        isAgreeProtcol = isAgree;
    };
    self.tableView.tableFooterView = footer;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLSHinputMerchantJoinCell *inputMerchantJoinCell = [tableView dequeueReusableCellWithIdentifier:inputMerchantJoinID];
    CLSHIndetityImageCell *indetityImageCell = [tableView dequeueReusableCellWithIdentifier:indetityImageID];
    indetityImageCell.delegate=self;
    indetityImageCell.indexPath=indexPath;
    
    CLSHBusinessStyleCell *businessStyleCell = [tableView dequeueReusableCellWithIdentifier:businessStyleID];
    CLSHMerchantJoinSelectAddressCell *selectAddressCell = [tableView dequeueReusableCellWithIdentifier:selectAddressID];
    CLSHSelectDiscountCell *isJoinPromotionCell = [tableView dequeueReusableCellWithIdentifier:isJoinPromotionID];
    CLSHLocationAddressCell *locationAddressCell = [tableView dequeueReusableCellWithIdentifier:locationAddressID];
    if (!inputMerchantJoinCell) {
        inputMerchantJoinCell = [[CLSHinputMerchantJoinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inputMerchantJoinID];
    }
    if (!indetityImageCell) {
        indetityImageCell = [[CLSHIndetityImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetityImageID];
    }
    if (!businessStyleCell) {
        businessStyleCell = [[CLSHBusinessStyleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:businessStyleID];
    }
    if (!selectAddressCell) {
        selectAddressCell = [[CLSHMerchantJoinSelectAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectAddressID];
    }
    if (!isJoinPromotionCell) {
        isJoinPromotionCell = [[CLSHSelectDiscountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:isJoinPromotionID];
    }
    if (locationAddressCell) {
        locationAddressCell = [[CLSHLocationAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locationAddressID];
    }
    locationAddressCell.selectionStyle = UITableViewCellSelectionStyleNone;
    isJoinPromotionCell.selectionStyle = UITableViewCellSelectionStyleNone;
    selectAddressCell.selectionStyle = UITableViewCellSelectionStyleNone;
    businessStyleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    inputMerchantJoinCell.selectionStyle = UITableViewCellSelectionStyleNone;
    indetityImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    inputMerchantJoinCell.delegate = self;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            inputMerchantJoinCell.leftName.userInteractionEnabled = YES;
            inputMerchantJoinCell.leftName.text = @"店铺名称:";
            
            if (shopName==nil) {
                inputMerchantJoinCell.inputInfo.placeholder = @"请输入店铺名称";
            }else{
                 inputMerchantJoinCell.inputInfo.text=shopName;
            }
            
            inputMerchantJoinCell.name = @"店铺名称";
            NSLog(@"店铺名%@",shopName);
            
            return inputMerchantJoinCell;
            
        
        }else if (indexPath.row == 1) {
            
            businessStyleCell.industryName = self.industryName;
            return businessStyleCell;
            
        }else if (indexPath.row == 2) {
            
//            isJoinPromotionCell.delegate = self;
//            isJoinPromotionCell.isOn=isJoinDiscount;
            WS(weakSelf);
//            self.listView.selectDiscountblock = ^(NSInteger row){
                
//                discountListModel = [[CLSHDiscountListModel alloc] init];
//                discountListModel = [weakSelf.discountArray objectAtIndexCheck:row];
//                discountID = discountListModel.discountID;
//                [isJoinPromotionCell.selectBtn setTitle:[NSString stringWithFormat:@"%@",discountListModel.discount] forState:(UIControlStateNormal)];
//                discountNum = discountListModel.discountID;
//                tag = 0;
//                [UIView animateWithDuration:0.1 animations:^{
//                    isJoinPromotionCell.arrowIcon.transform = CGAffineTransformIdentity;
//                }];
//                
//            };
            if (discountValues.length == 0) {
                [isJoinPromotionCell.selectBtn setTitle:[NSString stringWithFormat:@"请选择折扣"] forState:(UIControlStateNormal)];
            }else{
            
                [isJoinPromotionCell.selectBtn setTitle:[NSString stringWithFormat:@"%@",discountValues] forState:(UIControlStateNormal)];
            }
        
            weakSelf.DiscountlistView.joinDiscountblock = ^(NSInteger row){
            
                [weakSelf.DiscountlistView removeFromSuperview];
                discountListModel = [[CLSHDiscountListModel alloc] init];
                discountListModel = [weakSelf.discountArray objectAtIndexCheck:row];
                discountID = discountListModel.discountID;
                discountValues = discountListModel.discount;
                [isJoinPromotionCell.selectBtn setTitle:[NSString stringWithFormat:@"%@",discountValues] forState:(UIControlStateNormal)];
                discountNum = discountListModel.discountID;
                tag = 0;
                [UIView animateWithDuration:0.1 animations:^{
                    isJoinPromotionCell.arrowIcon.transform = CGAffineTransformIdentity;
                }];
            };
            
            isJoinPromotionCell.Discountblock = ^(){
                NSLog(@"---%ld",self.DiscountlistView.dataArray.count);
                if (!tag) {
                    [UIView animateWithDuration:0.1 animations:^{
                        [weakSelf.view addSubview:weakSelf.DiscountlistView];
                        isJoinPromotionCell.arrowIcon.transform=CGAffineTransformMakeRotation(M_PI);
                        
                    }];
                    tag = 1;
                }else{
                    
                    [UIView animateWithDuration:0.1 animations:^{
                        [weakSelf.DiscountlistView removeFromSuperview];
                        isJoinPromotionCell.arrowIcon.transform = CGAffineTransformIdentity;
                    }];
                    tag = 0;
                }
                
            };
            return isJoinPromotionCell;
            
        }else if (indexPath.row == 3)
        {
            selectAddressCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            selectAddressCell.shopAddress=selectAddress;
            
            return selectAddressCell;
            
        }else if (indexPath.row == 4) {
            
            inputMerchantJoinCell.leftName.text = @"详细地址:";
            inputMerchantJoinCell.inputInfo.placeholder = @"请输入您的店铺详细地址";
                      
           
            inputMerchantJoinCell.name = @"详细地址";
            if (detailAddress1==nil) {
                inputMerchantJoinCell.inputInfo.placeholder = @"请输入您的店铺详细地址";
            }else{
               inputMerchantJoinCell.inputInfo.text = detailAddress1;
            }

             
            
            NSLog(@"详细名%@",detailAddress1);
            return inputMerchantJoinCell;
            
        }else if (indexPath.row == 5) {
            
            //定位当前地址
            locationAddressCell.locationAddressBlock = ^(){
                
                if (selectAddress == NULL) {
                    [MBProgressHUD showError:@"请先选择店铺地址"];
                    
                }else{
                
                MapController *map = [[MapController alloc] init];
                    map.address = selectAddress;
                    
                    [self.navigationController pushViewController:map animated:YES];
              
                }
                NSLog(@"点击了一次");
                //[self configLocationManager];
            };
//            locationAddressCell.AmapAddressblock = ^(){
//            
//                NSLog(@"点击了两次");
//            };
            locationAddressCell.detailAddress= loccotionAddress;
            return locationAddressCell;
            
        }else if (indexPath.row == 6) {
            
            inputMerchantJoinCell.leftName.text = @"经   度:";
            inputMerchantJoinCell.inputInfo.userInteractionEnabled = NO;

            if (longitude1!=0) {
                  inputMerchantJoinCell.inputInfo.text=[NSString stringWithFormat:@"%@",longitude1];
            }
            inputMerchantJoinCell.inputInfo.placeholder = @"";
            inputMerchantJoinCell.name = @"经度";
            
            return inputMerchantJoinCell;
           
        }else{
            
            inputMerchantJoinCell.leftName.text = @"纬   度:";
            inputMerchantJoinCell.inputInfo.placeholder = @"";
            inputMerchantJoinCell.inputInfo.userInteractionEnabled = NO;
            if (latitude1!=0) {
                inputMerchantJoinCell.inputInfo.text=[NSString stringWithFormat:@"%@",latitude1];
            }
            inputMerchantJoinCell.name = @"纬度";
            return inputMerchantJoinCell;
            
        }
        
    }else
    {
        [indetityImageCell.upload setTitle:@"请上传店铺图片" forState:UIControlStateNormal];
        NSString *key=[NSString stringWithFormat:@"%ld%ld",self.tempAppendNumber,indexPath.row];
        
        if (imgDict[key]!=nil) {
            indetityImageCell.icon.image=imgDict[key];
        }else{
            indetityImageCell.icon.image=[UIImage imageNamed:@"IdentityCardFront"];
        }
        
        return indetityImageCell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40*AppScale;
    }else
    {
        return 190*AppScale;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40*AppScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40*AppScale)];
    view.backgroundColor = backGroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10*AppScale, 10*AppScale, SCREENWIDTH-2*AppScale, 20*AppScale)];
    label.backgroundColor = backGroundColor;
    label.font = [UIFont systemFontOfSize:13*AppScale];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"店铺信息";
    }else
    {
        label.text = @"上传店铺图片";
    }
    return view;
}

#pragma mark - setter getter
-(void)setIndustryName:(NSString *)industryName
{
    _industryName = industryName;
    [self.tableView reloadData];
}

-(void)setTempAppendNumber:(NSInteger)tempAppendNumber
{
    _tempAppendNumber = tempAppendNumber;
}

-(void)setIndustryId:(NSString *)industryId
{
    _industryId = industryId;
}

-(void)setShopId:(NSString *)shopId
{
    _shopId = shopId;
}

#pragma mark <CLSHIndetityImageCellDelegate>

-(void)upLoadImgTypeName:(NSString *)typeName isPerson:(BOOL)isPersion indexPath:(NSIndexPath *)indexPath{
    
    self.tempIndexPath=indexPath;
    tempTypeName=typeName;
    
//    KBCustomPhotoCollectionViewController *kBCustomPhotoCollectionViewController=[KBCustomPhotoCollectionViewController new];
//    kBCustomPhotoCollectionViewController.maxNumber=1;
//    kBCustomPhotoCollectionViewController.delegate=self;
//    kBCustomPhotoCollectionViewController.allowsMultipleSelection=YES;
//    [self.navigationController pushViewController:kBCustomPhotoCollectionViewController animated:YES];
    
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
        kBCustomPhotoCollectionViewController.maxNumber=1;
        kBCustomPhotoCollectionViewController.allowsMultipleSelection=YES;
        kBCustomPhotoCollectionViewController.isCamera = NO;
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^(){
        
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        image= [UIImage imageByScalingToMaxSize:image];
        
        NSData *originImgData=UIImageJPEGRepresentation(image, 1.0f);
        NSString *imgStr=[originImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSString *key=[NSString stringWithFormat:@"%ld%ld",_tempAppendNumber,_tempIndexPath.row];
        imgDict[key]= image;
        [self upLoadImg:key imgStr:imgStr typeName:tempTypeName];
    }];
}


#pragma mark <KBCustomPhotoCollectionViewControllerDelegate>
-(void)KBPhotoUpLoadImages:(NSArray *)images imageBaseStringArr:(NSArray *)imgStringArr{
    
    NSString *key=[NSString stringWithFormat:@"%ld%ld",self.tempAppendNumber,_tempIndexPath.row];
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>%@",key);
    imgDict[key]=images[0];
    [self upLoadImg:key imgStr:imgStringArr[0] typeName:tempTypeName];
}

-(void)upLoadImg:(NSString *)upLoadName imgStr:(NSString *)imgStr typeName:(NSString *)upLoadImgName{
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"fileName"]=[NSString stringWithFormat:@"%@.jpg",upLoadName];
    needParams[@"fileType"]=@"image";
    needParams[@"base64Data"]=imgStr;
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"图片上传中...";
    hud.dimBackground=YES;
    hud.backgroundColor=backGroundColor;
    
    dispatch_async(dispatch_get_global_queue(2, 0), ^{
       
       [cLSHUploadImageModel upLoadImageData:needParams callBack:^(BOOL isSuccess, id result) {
           
           if (isSuccess) {
               
               cLSHUploadImageModel=result;
               hud.labelText=@"图片上传成功";
               
               if ([upLoadImgName isEqualToString:@"请上传店铺图片"]) {
                   
                   infoParams[@"avatar"]=cLSHUploadImageModel.url;
               }
               
               [hud hide:YES afterDelay:0.8];
               dispatch_async(dispatch_get_main_queue(), ^{
                   NSIndexPath *index=[NSIndexPath indexPathForRow:_tempIndexPath.row inSection:_tempIndexPath.section];
                   [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationAutomatic];
               });
               
           }else{
               hud.labelText=@"图片上传失败";
               [hud hide:YES afterDelay:0.8];
           }
       }];
    });
}


#pragma mark - CLSHinputMerchantJoinCellDelegate
- (void)nameLabel:(NSString *)nameLabel inputName:(NSString *)name
{
    if ([nameLabel isEqualToString:@"店铺名称:"]) {
        shopName = name;
        NSLog(@"编辑结束%@",shopName);
    }else if ([nameLabel isEqualToString:@"详细地址:"]) {
        detailAddress1 = name;
        NSLog(@"详细text%@",detailAddress1);
    }else if ([nameLabel isEqualToString:@"经度"]) {
//        longitude = name;
    }else if ([nameLabel isEqualToString:@"纬度"]) {
//        latitude = name;
    }
}

#pragma mark - CLSHIsJoinDiscountCellDelegate
-(void)clickSwitch:(BOOL)isUse
{
    isJoinDiscount = isUse;
}



#pragma mark <location>
-(void)configLocationManager{
    aMapLocationManager=[AMapLocationManager new];
    aMapLocationManager.delegate=self;
    aMapLocationManager.pausesLocationUpdatesAutomatically=NO;
    aMapLocationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
    
    //iOS9.0后
    //    aMapLocationManager.allowsBackgroundLocationUpdates=YES;
    [self getLocation];
}

-(void)startLocation{
    [aMapLocationManager startUpdatingLocation];
}

-(void)stopLocation{
    [aMapLocationManager stopUpdatingLocation];
}

-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    
}

-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    
    [FetchAppPublicKeyModel shareAppPublicKeyManager].latitude=location.coordinate.latitude;
    [FetchAppPublicKeyModel shareAppPublicKeyManager].longitude=location.coordinate.longitude;
    
    [self stopLocation];
}


-(void)getLocation{
    
    [aMapLocationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            
        }
        latitude=location.coordinate.latitude;
        longitude=location.coordinate.longitude;

        if (regeocode) {
            
            NSString *address=[NSString stringWithFormat:@"%@%@",regeocode.street,regeocode.building];
//            detailAddress1=address;
            
            NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:4 inSection:0];
            NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:5 inSection:0];
            NSIndexPath *indexPath3=[NSIndexPath indexPathForRow:6 inSection:0];
            NSIndexPath *indexPath4=[NSIndexPath indexPathForRow:7 inSection:0];
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath1,indexPath2,indexPath3,indexPath4] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            NSLog(@"------>>>>>%@",address);
            
        }
        
    }];
}


//@2传回的位置信息
- (void)getLocationInformation:(NSNotification *)info{
    NSLog(@"50gust双氧水");
    NSDictionary * dict = info.userInfo;
    
    latitude1 = [dict objectForKey:@"latitude"];
    longitude1 = [dict objectForKey:@"longitude"];
    loccotionAddress = [dict objectForKey:@"address"];
    NSLog(@"传回来的经度%f %f",longitude,latitude);
  
    NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:5 inSection:0];
    NSIndexPath *indexPath3=[NSIndexPath indexPathForRow:6 inSection:0];
    NSIndexPath *indexPath4=[NSIndexPath indexPathForRow:7 inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath2,indexPath3,indexPath4] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    [self.tableView reloadData];
}


@end
