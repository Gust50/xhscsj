//
//  CLSHPersonalSettingViewController.m
//  ClshMerchant
//
//  Created by arom on 16/7/29.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHPersonalSettingViewController.h"
#import "CLSHSetupMyIconCell.h"
#import "CLSHSetupCenterCell.h"
#import "CLSHSetupMyNickNameVC.h"
#import "CLSHModifyPhoneNumberVC.h"
#import "CLSHModifyPasswordVC.h"
#import "KBCustomPhotoCollectionViewController.h"
#import "CLSHSetUpCenterModel.h"
#import "CLSHStoreModel.h"
#import "CLSHLoginViewController.h"
#import "CLSHRemindPasswordVC.h"
#import "UIImage+KBExtension.h"

@interface CLSHPersonalSettingViewController ()<UITableViewDelegate,UITableViewDataSource,KBCustomPhotoCollectionViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CLSHSetUpCenterModel *setUpModel;   ///<设置中心
    CLSHAccountLogoutModel * loginOutModel; ///<退出登录
    CLSHIconUploadModel * FileUploadModel;
    CLSHIconChangeModel * iconChangeModel;
    NSMutableArray *arrayImage;
    
    CLSHStoreModel *storeModel;  //@2///<店铺管理数据模型
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray *  iconArray;   //图标数组//@1
@property (nonatomic,strong)NSArray * titleArray;   //标题数组

@end

@implementation CLSHPersonalSettingViewController

static NSString *const myIconID = @"CLSHSetupMyIconCell";
static NSString *const setupCenterID = @"CLSHSetupCenterCell";

#pragma mark -- 懒加载
- (UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+AppScale*10, SCREENWIDTH, SCREENHEIGHT-64-10*AppScale) style:(UITableViewStylePlain)];
        self.tableView.backgroundColor = backGroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)iconArray{

    if (!_iconArray) {
        _iconArray = [[NSMutableArray alloc] initWithObjects:@"IconImage",@"NickNameIcon",@"PhoneNumberIcon",@"BankIcon", nil];
//        _iconArray = @[@"IconImage",@"NickNameIcon",@"PhoneNumberIcon",@"BankIcon"];
    }
    return _iconArray;
}

- (NSArray *)titleArray{

    if (!_titleArray) {
        _titleArray = [NSArray array];
        _titleArray = @[@"我的头像",@"我的昵称",@"我的手机",@"重置密码"];
    }
    return _titleArray;
}

#pragma mark -- life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = backGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"个人中心";
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHSetupMyIconCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:myIconID];
    [self.tableView registerNib:[UINib nibWithNibName:@"CLSHSetupCenterCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:setupCenterID];

    
    //尾视图
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*AppScale)];
    UIButton *signOut= [UIButton buttonWithType:(UIButtonTypeSystem)];
    signOut.frame = CGRectMake(10, 30*AppScale, SCREENWIDTH-20, 40*AppScale);
    signOut.layer.cornerRadius=5.0;
    signOut.layer.masksToBounds=YES;
    signOut.backgroundColor=systemColor;
    [signOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [signOut addTarget:self action:@selector(setupSignOut) forControlEvents:UIControlEventTouchUpInside];
    signOut.titleLabel.font=[UIFont systemFontOfSize:16*AppScale];
    [footer addSubview:signOut];
    
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*AppScale)];
    self.tableView.tableFooterView=footer;
    self.tableView.tableFooterView.backgroundColor = backGroundColor;
    
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:1.0]];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14*AppScale]};
    [self loadData];
    
    [self loadData1];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[RGBColor(0, 149, 68) colorWithAlphaComponent:0.0]];
}
- (void)loadData1
{
    storeModel = [[CLSHStoreModel alloc] init];
    [storeModel fetchStoreData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            storeModel = result;
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark - loadData
- (void)loadData
{
    setUpModel = [[CLSHSetUpCenterModel alloc] init];
    [setUpModel fetchStoreSetUpCenterData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            setUpModel = result;
            NSLog(@"0-------%@",setUpModel);
            [self.tableView reloadData];
        }else
        {
            [MBProgressHUD showError:result];
        }
        
    }];
}

- (void)setupSignOut{

    NSLog(@"退出登录");
    loginOutModel = [[CLSHAccountLogoutModel alloc] init];
    [loginOutModel postAppLogoutData:nil callBack:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            [MBProgressHUD showSuccess:result];
            [FetchAppPublicKeyModel shareAppPublicKeyManager].isLogin=NO;
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"info"]];
            dict[@"password"] = nil;
            [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"info"];
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogined"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                
                CLSHLoginViewController *loginViewController=[[CLSHLoginViewController alloc]init];
                //loginViewController.isBackRootTabbar=YES;
                [self.parentViewController presentViewController:loginViewController animated:YES completion:nil];
            });
        }else{
        
            [MBProgressHUD showError:result];
        }
    }];
}

#pragma mark -- table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 60*AppScale;
    }
    return 44*AppScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CLSHSetupMyIconCell *myIconCell = [tableView dequeueReusableCellWithIdentifier:myIconID];
    CLSHSetupCenterCell *setupCenterCell = [tableView dequeueReusableCellWithIdentifier:setupCenterID];
    myIconCell.selectionStyle = UITableViewCellSelectionStyleNone;
    setupCenterCell.selectionStyle = UITableViewCellEditingStyleNone;
    if (!myIconCell) {
        myIconCell = [[CLSHSetupMyIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIconID];
    }
    if (!setupCenterCell) {
        setupCenterCell = [[CLSHSetupCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setupCenterID];
    }
    
        switch (indexPath.row) {
            case 0:{

//                myIconCell.imageView.image =[UIImage imageNamed:_iconArray[0]];
                
            //myIconCell.setUpCenterModel = setUpModel;
                //myIconCell.iconUrl = setUpModel.avatar;//数据为空
                myIconCell.iconUrl = storeModel.modelMap.avatar;//@2
                NSLog(@"%@ ",storeModel.modelMap.avatar);
                return myIconCell;
            }
                
                break;
//            case 1:{
//            
//                setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconArray[1]];
//                setupCenterCell.imageLabel.text = self.titleArray[1];
//                if ([setUpModel.nickname isEqualToString:@""]) {
//                    setupCenterCell.displayRightLabel.text = @"还没有昵称";
//                }else
//                {
//                    setupCenterCell.displayRightLabel.text = setUpModel.nickname;
//                }
//                return setupCenterCell;
//            }
//                break;
            case 1:{
            
                setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconArray[2]];
                setupCenterCell.imageLabel.text = self.titleArray[2];
                if ([setUpModel.mobile isEqualToString:@""]) {
                    setupCenterCell.displayRightLabel.text = @"还没有手机号";
                }else
                {
                    setupCenterCell.displayRightLabel.text = [setUpModel.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                }
                
                return setupCenterCell;
            }
                break;
            case 2:{
                setupCenterCell.imageIcon.image = [UIImage imageNamed:self.iconArray[3]];
                setupCenterCell.imageLabel.text = self.titleArray[3];
                setupCenterCell.displayRightLabel.text = @"可修改";
                return setupCenterCell;
            }
                break;
            default:
                return nil;
                break;
        }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:{
            
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
            break;
        case 1:{
        
            CLSHModifyPhoneNumberVC *phoneNumber = [[CLSHModifyPhoneNumberVC alloc] init];
            [self.navigationController pushViewController:phoneNumber animated:YES];
        }
            break;
        case 2:{
        
            CLSHModifyPasswordVC *modifyPasswordVC = [[CLSHModifyPasswordVC alloc] init];
            modifyPasswordVC.phoneNumber = setUpModel.mobile;
            [self.navigationController pushViewController:modifyPasswordVC animated:YES];
        }
            break;
        default:
            break;
    }
}

//保存头像功能
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^(){
        
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        image= [UIImage imageByScalingToMaxSize:image];
        
        NSData *originImgData=UIImageJPEGRepresentation(image, 1.0f);
        NSString *imgStr=[originImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        if (![imgStr isEqualToString:@""]) {
            FileUploadModel = [[CLSHIconUploadModel alloc] init];
            NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
            needsParams[@"fileName"] = @"aa.jpg";
            needsParams[@"fileType"] = @"image";
            needsParams[@"base64Data"] = imgStr;
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
                [FileUploadModel fetchAccountIconUploadModel:needsParams callBack:^(BOOL isSuccess, id result) {
                    
                    if (isSuccess) {
                        
                        FileUploadModel = result;
                        if (![FileUploadModel.url isEqualToString:@""]) {
                            
                            iconChangeModel = [[CLSHIconChangeModel alloc] init];
                            NSMutableDictionary * params = [NSMutableDictionary dictionary];
                            params[@"avatar"] = FileUploadModel.url;
                            
                            [iconChangeModel fetchAccountChangeIconModel:params callBack:^(BOOL isSuccess, id result) {
                                
                                if (isSuccess) {
                                    [MBProgressHUD showSuccess:@"更换成功"];
                                    [self loadData];
                                    [self loadData1];//@2
                                }else{
                                    
                                    [MBProgressHUD showError:@"上传失败"];
                                }
                            }];
                        }
                    }else{
                        
                        [MBProgressHUD showError:@"上传失败"];
                    }
                    
                }];
            });

        }
    }];
}


#pragma mark <KBCustomPhotoCollectionViewControllerDelegate>
////上传个人头像 //拍照
//-(void)KBPhotoUpLoadUserIcon:(UIImage *)image imageBaseString:(NSString *)baseString{
//    
//    if (![baseString isEqualToString:@""]) {
//        
//        
//    }
//}

//上传图片数组 //相机
-(void)KBPhotoUpLoadImages:(NSArray *)images imageBaseStringArr:(NSArray *)imgStringArr{
    NSLog(@">>>>>>>>>>>>%@%@",images,imgStringArr);
//    _iconArray[0] = [UIImage imageNamed:images[0]];
    
    if (imgStringArr.count) {
        FileUploadModel = [[CLSHIconUploadModel alloc] init];
        NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
        needsParams[@"fileName"] = @"aa.jpg";
        needsParams[@"fileType"] = @"image";
        needsParams[@"base64Data"] = imgStringArr[0];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [FileUploadModel fetchAccountIconUploadModel:needsParams callBack:^(BOOL isSuccess, id result) {
                
                if (isSuccess) {
                    
                    FileUploadModel = result;
                    if (![FileUploadModel.url isEqualToString:@""]) {
                        
                        iconChangeModel = [[CLSHIconChangeModel alloc] init];
                        NSMutableDictionary * params = [NSMutableDictionary dictionary];
                        params[@"avatar"] = FileUploadModel.url;
                        
                        
                        [iconChangeModel fetchAccountChangeIconModel:params callBack:^(BOOL isSuccess, id result) {
                            
                            if (isSuccess) {
                                [MBProgressHUD showSuccess:@"更换成功"];
                                
                                [self loadData];
                                [self loadData1];//@2
                            }else{
                                
                                [MBProgressHUD showError:@"上传失败"];
                            }
                        }];
                    }
                }else{
                    
                    [MBProgressHUD showError:@"上传失败"];
                }
                
            }];
        });
        
    }

}










//    [_upLoadImgArr removeObjectAtIndex:_upLoadImgArr.count - 1];
//    [_upLoadImgStrArr removeObjectAtIndex:_upLoadImgStrArr.count - 1];
//    
//    [_upLoadImgArr addObjectsFromArray:images];
//    [_upLoadImgStrArr addObjectsFromArray:imgStringArr];
//    
//    UIImage *img=[UIImage imageNamed:@"compose_pic_add"];
//    [_upLoadImgArr addObject:img];
//    
//    _addAddvertisementView.imgArr=_upLoadImgArr;

    

//    if (imgStringArr.count) {
//        FileUploadModel = [[CLSHIconUploadModel alloc] init];
//        NSMutableDictionary * needsParams = [NSMutableDictionary dictionary];
//        needsParams[@"fileName"] = @"aa.jpg";
//        needsParams[@"fileType"] = @"image";
//        needsParams[@"base64Data"] = imgStringArr[0];
//        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            
//            [FileUploadModel fetchAccountIconUploadModel:needsParams callBack:^(BOOL isSuccess, id result) {
//                
//                if (isSuccess) {
//                    
//                    FileUploadModel = result;
//                    if (![FileUploadModel.url isEqualToString:@""]) {
//                        
//                        iconChangeModel = [[CLSHIconChangeModel alloc] init];
//                        NSMutableDictionary * params = [NSMutableDictionary dictionary];
//                        params[@"avatar"] = FileUploadModel.url;
//                        [iconChangeModel fetchAccountChangeIconModel:params callBack:^(BOOL isSuccess, id result) {
//                            
//                            if (isSuccess) {
//                                [MBProgressHUD showSuccess:@"更换成功"];
//                                
//                                [self loadData];
//                            }else{
//                                
//                                [MBProgressHUD showError:@"上传失败"];
//                            }
//                        }];
//                    }
//                }else{
//                    
//                    [MBProgressHUD showError:@"上传失败"];
//                }
//                
//            }];
//        });
//        
//    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
