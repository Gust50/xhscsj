//
//  CLSHUpLoadGoodsVC.m
//  ClshMerchant
//
//  Created by kobe on 16/7/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHUpLoadGoodsVC.h"
#import "CLSHUpLoadImgCell.h"
#import "CLSHUpLoadNameCell.h"
#import "CLSHUpLoadPropertyCell.h"
#import "CLSHUpLoadCategoryCell.h"
#import "CLSHUpLoadNotesCell.h"
#import "CLSHUpLoadPropertyHeader.h"
#import "CLSHUpLoadPropertyFooter.h"
#import "KBCustomPhotoCollectionViewController.h"
#import "CLSHupLoadGoodsModel.h"
#import "CLSHUploadImageModel.h"
#import "CLSHSelectCategoryView.h"
#import "KBDropMenuView.h"
#import "CLSHAddCategoryVC.h"
#import "CLSHHomeShopListModel.h"
#import "CLSHCategoryManageModel.h"
#import "CLSHIsJoinDiscountCell.h"
#import "UIImage+KBExtension.h"

@interface CLSHUpLoadGoodsVC ()<UITableViewDataSource,UITableViewDelegate,CLSHUpLoadImgCellDelegate,KBCustomPhotoCollectionViewControllerDelegate,CLSHUpLoadNameCellDelegate,CLSHUpLoadPropertyCellDelegate,CLSHUpLoadPropertyFooterDelegate,CLSHUpLoadCategoryCellDelegate,CLSHUpLoadNotesCellDelegate, CLSHIsJoinDiscountCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    CLSHupLoadGoodsModel *upLoadGoodsModel;
    CLSHUploadImageModel *upLoadImageModel;
    CLSHHomeShopItemDetailModel *shopItemDetailModel;
    CLSHHomeEditShopModel *editShopModel;
    MBProgressHUD *hud;
    NSInteger completionCount;
    KBDropMenuView *kBDropMenuView;
    CLSHSelectCategoryView * selectCategoryView;
    
    CLSHCategoryManageModel * categoryManageModel;  ///<类别数据模型
    
    NSString *categoryID;  ///<类别ID
    NSString * categoryName; //分类名字
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *upLoadImgArr;
@property (nonatomic, strong) NSMutableArray *upLoadPropertyArr;
@property (nonatomic, strong) NSMutableArray *upLoadImgStrArr;

@end

@implementation CLSHUpLoadGoodsVC
static NSString *const upLoadImgCellID=@"upLoadImgCellID";
static NSString *const uplLoadNameCellID=@"uplLoadNameCellID";
static NSString *const upLoadPropertyCellID=@"upLoadPropertyCellID";
static NSString *const upLoadCategoryCellID=@"upLoadCategoryCellID";
static NSString *const upLoadNotesCellID=@"upLoadNotesCellID";
static NSString *const upLoadPropertyHeaderID=@"upLoadPropertyHeaderID";
static NSString *const upLoadPropertyFooterID=@"upLoadPropertyFooterID";
static NSString *const isJoinDiscountID=@"CLSHIsJoinDiscountCell";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

-(NSMutableArray *)upLoadImgArr{
    if (!_upLoadImgArr) {
        _upLoadImgArr=[NSMutableArray array];
    }
    return _upLoadImgArr;
}

-(NSMutableArray *)upLoadPropertyArr{
    if (!_upLoadPropertyArr) {
        _upLoadPropertyArr=[NSMutableArray array];
    }
    return _upLoadPropertyArr;
}

-(NSMutableArray *)upLoadImgStrArr{
    if (!_upLoadImgStrArr) {
        _upLoadImgStrArr=[NSMutableArray array];
    }
    return _upLoadImgStrArr;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=backGroundColor;
    [self.view addSubview:self.tableView];
    self.navigationItem.title=@"添加商品";
    //init data
    UIImage *img=[UIImage imageNamed:@"compose_pic_add"];
    [self.upLoadImgArr addObject:img];
    CLSHupLoadPropertyModel *tempModel=[CLSHupLoadPropertyModel new];
    [self.upLoadPropertyArr addObject:tempModel];
    completionCount=0;
    
    [_tableView registerClass:[CLSHUpLoadImgCell class] forCellReuseIdentifier:upLoadImgCellID];
    [_tableView registerClass:[CLSHUpLoadNameCell class] forCellReuseIdentifier:uplLoadNameCellID];
    [_tableView registerClass:[CLSHUpLoadPropertyCell class] forCellReuseIdentifier:upLoadPropertyCellID];
    [_tableView registerClass:[CLSHUpLoadCategoryCell class] forCellReuseIdentifier:upLoadCategoryCellID];
    [_tableView registerClass:[CLSHUpLoadNotesCell class] forCellReuseIdentifier:upLoadNotesCellID];
    [_tableView registerClass:[CLSHUpLoadPropertyHeader class] forHeaderFooterViewReuseIdentifier:upLoadPropertyHeaderID];
    [_tableView registerClass:[CLSHUpLoadPropertyFooter class] forHeaderFooterViewReuseIdentifier:upLoadPropertyFooterID];
    [_tableView registerClass:[CLSHIsJoinDiscountCell class] forCellReuseIdentifier:isJoinDiscountID];
    
    [self setupFooterView];
    [self initModel];
    
    if (_isEditShop) {
        [self loadData];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryName:) name:@"postCategoryName" object:nil];
}

- (void)categoryName:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    categoryID = dic[@"categoryId"];
    [kBDropMenuView hideMenu];
    upLoadGoodsModel.categoryId = [categoryID integerValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"informArrow" object:nil userInfo:dic];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadCategoryData];
}

-(void)initModel{
    upLoadGoodsModel=[CLSHupLoadGoodsModel new];
    upLoadGoodsModel.isDiscount=@"true";
    upLoadImageModel=[CLSHUploadImageModel new];
    shopItemDetailModel=[CLSHHomeShopItemDetailModel new];
    editShopModel=[CLSHHomeEditShopModel new];
}

#pragma mark - loadData
-(void)loadData{
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionary];
    needParams[@"goodsId"]=_goodsId;
    [shopItemDetailModel fetchShopDetailData:needParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            shopItemDetailModel=result;
            [self loadImgWithUrl:shopItemDetailModel.image];
            
  
            [_upLoadPropertyArr removeAllObjects];


            
            [self.upLoadPropertyArr addObjectsFromArray:shopItemDetailModel.specifications];
            upLoadGoodsModel.name=shopItemDetailModel.goodsName;
            upLoadGoodsModel.remark=shopItemDetailModel.remark;
            upLoadGoodsModel.categoryId=shopItemDetailModel.categoryId;
            upLoadGoodsModel.isDiscount=shopItemDetailModel.isJoinPromotion;
            
            [self loadCategoryData];
            
            [_tableView reloadData];
        }else{
            
        }
    }];
}

//加载类别数据
- (void)loadCategoryData
{
    categoryManageModel =[[CLSHCategoryManageModel alloc] init];
    [categoryManageModel fetchCategoryManageData:nil callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess) {
            categoryManageModel = result;
            
            for (CLSHCategoryListModel * model in categoryManageModel.classification) {

                if (model.categoryID == shopItemDetailModel.categoryId){
                    categoryName = model.name;
                }
            }
            [self.tableView reloadData];
        }else{
            
            [MBProgressHUD showError:result];
        }
    }];
}

-(void)setupFooterView{
    UIButton *publishBtn=[UIButton buttonWithType:0];
    publishBtn.frame=CGRectMake(10*AppScale, 40*AppScale, SCREENWIDTH-20*AppScale, 40*AppScale);
    [publishBtn setTitleColor:[UIColor whiteColor] forState:0];
    [publishBtn setTitle:@"发布商品" forState:0];
    publishBtn.backgroundColor=systemColor;
    publishBtn.layer.cornerRadius=5.0;
    publishBtn.layer.masksToBounds=YES;
    [publishBtn addTarget:self action:@selector(publishGoods:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*AppScale)];
    [view addSubview:publishBtn];
    _tableView.tableFooterView=view;
}

#pragma mark <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return _upLoadPropertyArr.count;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        CLSHUpLoadImgCell *upLoadImgCell=[tableView dequeueReusableCellWithIdentifier:upLoadImgCellID forIndexPath:indexPath];
        upLoadImgCell.delegate=self;
        upLoadImgCell.imgArr=_upLoadImgArr;
      
        return upLoadImgCell;
        
    }else if (indexPath.section==1){
        
        CLSHUpLoadNameCell *upLoadNameCell=[tableView dequeueReusableCellWithIdentifier:uplLoadNameCellID forIndexPath:indexPath];
        upLoadNameCell.delegate=self;
        if (shopItemDetailModel.goodsName!=nil) {
            upLoadNameCell.nameText=shopItemDetailModel.goodsName;
        }
        return upLoadNameCell;
        
    }else if (indexPath.section==2){
        
        CLSHUpLoadPropertyCell *upLoadPropertyCell=[tableView dequeueReusableCellWithIdentifier:upLoadPropertyCellID forIndexPath:indexPath];
        upLoadPropertyCell.selectionStyle=UITableViewCellSelectionStyleNone;
        upLoadPropertyCell.model=_upLoadPropertyArr[indexPath.row];
        upLoadPropertyCell.delegate=self;
        upLoadPropertyCell.indexPath=indexPath;
        return upLoadPropertyCell;
        
    }else if (indexPath.section==3){
        
        CLSHUpLoadCategoryCell *upLoadCategoryCell=[tableView dequeueReusableCellWithIdentifier:upLoadCategoryCellID forIndexPath:indexPath];
        if (categoryManageModel.classification.count) {
            upLoadCategoryCell.isCanRotate = YES;
        }else
        {
            upLoadCategoryCell.isCanRotate = NO;
        }
        if (categoryName !=nil) {
            upLoadCategoryCell.categoryName= categoryName;
        }
        upLoadCategoryCell.delegate=self;
        return upLoadCategoryCell;
        
    }else if(indexPath.section==4){
        CLSHUpLoadNotesCell *upLoadNotesCell=[tableView dequeueReusableCellWithIdentifier:upLoadNotesCellID forIndexPath:indexPath];
        if (shopItemDetailModel.remark!=nil) {
            upLoadNotesCell.contentText=shopItemDetailModel.remark;
        }
        upLoadNotesCell.delegate=self;
        return upLoadNotesCell;
    }else
    {
        CLSHIsJoinDiscountCell *isJoinDiscountCell = [tableView dequeueReusableCellWithIdentifier:isJoinDiscountID forIndexPath:indexPath];
        isJoinDiscountCell.leftLabel.text = @"参与折扣";
        isJoinDiscountCell.delegate = self;
        //应要求修改
        isJoinDiscountCell.hidden = YES;
        if (upLoadGoodsModel.isDiscount!=nil) {
            if ([upLoadGoodsModel.isDiscount isEqualToString:@"true"]) {
                isJoinDiscountCell.isOn=YES;
            }else{
                isJoinDiscountCell.isOn=NO;
            }
        }
        return isJoinDiscountCell;
    }
}

#pragma mark <UITableViewDelegate>
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100*AppScale;
    }else if (indexPath.section==4){
        return 150*AppScale;
    }else if (indexPath.section == 5){
    
        return 0.01;
    }else{
        return 44.0*AppScale;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        CLSHUpLoadPropertyFooter *upLoadPropertyFooter=[tableView dequeueReusableHeaderFooterViewWithIdentifier:upLoadPropertyFooterID];
        upLoadPropertyFooter.delegate=self;
        return upLoadPropertyFooter;
    }else{
        UIView *view=[[UIView alloc]initWithFrame:CGRectZero];
        return view;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==2) {
        CLSHUpLoadPropertyHeader *upLoadPropertyHeader=[tableView dequeueReusableHeaderFooterViewWithIdentifier:upLoadPropertyHeaderID];
        return upLoadPropertyHeader;
    }else{
        UIView *view=[[UIView alloc]initWithFrame:CGRectZero];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 40.0*AppScale;
    }else{
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 40.0*AppScale;
    }else if (section==5)
    {
        return 10*AppScale;
    }else{
        return 0.01;
    }
}

#pragma mark <CLSHUpLoadImgCellDelegate>
-(void)clickUpLoadImgBtn{
    
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

-(void)deleteImgBtn:(UIImage *)img{
    [_upLoadImgArr removeObject:img];
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:0];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark <CLSHUpLoadNameCellDelegate>
-(void)upLoadNameCellDone:(NSString *)content{
    upLoadGoodsModel.name=content;
}

#pragma mark <CLSHUpLoadPropertyCellDelegate>
-(void)upLoadGoodsProperty:(NSString *)property indexPath:(NSIndexPath *)indexPath{
    CLSHupLoadPropertyModel *tempModel=_upLoadPropertyArr[indexPath.row];
    tempModel.name=property;
}
-(void)upLoadGoodsPrice:(NSString *)price indexPath:(NSIndexPath *)indexPath{
    CLSHupLoadPropertyModel *tempModel=_upLoadPropertyArr[indexPath.row];
    tempModel.price=[price floatValue];
}
-(void)upLoadGoodsStock:(NSString *)stock indexPath:(NSIndexPath *)indexPath{
    CLSHupLoadPropertyModel *tempModel=_upLoadPropertyArr[indexPath.row];
    tempModel.stock=[stock integerValue];
}

-(void)deletePropery:(CLSHupLoadPropertyModel *)model{
    [_upLoadPropertyArr removeObject:model];
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark <CLSHUpLoadPropertyFooterDelegate>
-(void)addProperty{
    CLSHupLoadPropertyModel *tempModel=[CLSHupLoadPropertyModel new];
    [_upLoadPropertyArr addObject:tempModel];
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark <CLSHUpLoadCategoryCellDelegate>
-(void)chooseCategory:(BOOL)isExpand{
    CGRect rect=[_tableView rectForSection:4];
    if (categoryManageModel.classification.count) {
        if (isExpand) {
            selectCategoryView.hidden=NO;
            if (kBDropMenuView.menuState==MenuShow) return;
            selectCategoryView=[CLSHSelectCategoryView new];
            selectCategoryView.categoryModel = categoryManageModel;
            
            kBDropMenuView=[[KBDropMenuView alloc]initWithFrame:CGRectMake(0, 0, 150*AppScale,120*AppScale)];
            kBDropMenuView.contentView=selectCategoryView;
            kBDropMenuView.anchorPoint=CGPointMake(0.5, 0);
            kBDropMenuView.origin=CGPointMake(0,0);
            kBDropMenuView.backGroundImg=@"BackCartBack";
            [kBDropMenuView shoViewFromPoint:CGPointMake(70*AppScale, rect.origin.y)];
            [_tableView addSubview:kBDropMenuView];
            
        }else{
            
            [kBDropMenuView hideMenu];
        }
        
    }else
    {
        [MBProgressHUD showError:@"请添加类别！"];
    }
    
//    upLoadGoodsModel.categoryId=2;
}

-(void)addCategory{
    CLSHAddCategoryVC *cLSHAddCategoryVC=[CLSHAddCategoryVC new];
    [self.navigationController pushViewController:cLSHAddCategoryVC animated:YES];
}

#pragma mark <CLSHUpLoadNotesCellDelegate>
-(void)textView:(NSString *)content{
    upLoadGoodsModel.remark=content;
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
        
        NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:0];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

#pragma mark <KBCustomPhotoCollectionViewControllerDelegate>
-(void)KBPhotoUpLoadImages:(NSArray *)images imageBaseStringArr:(NSArray *)imgStringArr{
    
    [_upLoadImgArr removeLastObject];
    [self.upLoadImgArr addObjectsFromArray:images];
    [self.upLoadImgStrArr addObjectsFromArray:imgStringArr];
    UIImage *img=[UIImage imageNamed:@"compose_pic_add"];
    [_upLoadImgArr addObject:img];
    NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:0];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)loadImgWithUrl:(NSArray *)urlArr{
    
    [_upLoadImgStrArr removeAllObjects];
    [_upLoadImgArr removeAllObjects];
    
    MBProgressHUD *loadImgHud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loadImgHud.dimBackground=YES;
    loadImgHud.labelText=@"正在下载图片中...";
    loadImgHud.backgroundColor=backGroundColor;
    __block NSInteger loadCount=0;
    
    //create queue
    dispatch_group_t  group=dispatch_group_create();
    
    
    
    for (int i=0; i<urlArr.count; i++) {
        
        
        dispatch_group_async(group, dispatch_get_global_queue(2, 0), ^{
           
            UIImage *result;
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlArr[0]]];
            result=[UIImage imageWithData:data];
            
            NSData *originImgData=UIImageJPEGRepresentation(result, 0.5f);
            NSString *imgStr=[originImgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            [self.upLoadImgStrArr addObject:imgStr];
            [self.upLoadImgArr addObject:result];
            loadCount++;
            loadImgHud.labelText=[NSString stringWithFormat:@"已经下载%ld张",loadCount];

        });
    }
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *img=[UIImage imageNamed:@"compose_pic_add"];
            [_upLoadImgArr addObject:img];
            [loadImgHud hide:YES afterDelay:0.8];
            [_tableView reloadData];
        });
    });

}

-(void)KBPhotoUpLoadUserIcon:(UIImage *)image imageBaseString:(NSString *)baseString{
    
}

#pragma mark <otherResponse>
-(void)publishGoods:(UIButton *)btn{
    [self.view endEditing:YES];
    upLoadGoodsModel.specifications=_upLoadPropertyArr;
    if ([self validateUpLoadModel]) {
        [self upLoadImageProgress];
    }else{
        NSLog(@"failure");
    }
}


-(void)upLoadImageProgress{
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"图片上传中....";
    hud.dimBackground=YES;
    hud.backgroundColor=backGroundColor;
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
                        upLoadGoodsModel.images=temp;
                        [hud hide:YES];
                        [self upLoad];
                    }else{
                        hud.labelText=[NSString stringWithFormat:@"已经上传了%ld张",completionCount];
                    }
                    
                }else{
                    completionCount++;
                    if (completionCount==_upLoadImgStrArr.count) {
                        hud.labelText=[NSString stringWithFormat:@"上传已经完成"];
                        upLoadGoodsModel.images=temp;
                        [hud hide:YES];
                        [self upLoad];
                    }else{
                        hud.labelText=[NSString stringWithFormat:@"已经上传了%ld张",completionCount];
                    }
                    
                }
            }];
        });
        
    }
}


-(void)upLoad{
    
    NSDictionary *needParams=[upLoadGoodsModel mj_keyValues];
    
    
    if (_isEditShop) {
        
        NSMutableDictionary *tempParams=[NSMutableDictionary dictionary];
        tempParams[@"goodsid"]=_goodsId;
        tempParams[@"goodsName"]=needParams[@"name"];
        [tempParams addEntriesFromDictionary:needParams];
        [tempParams removeObjectForKey:@"name"];
        
//        needParams[@"goodsid"]=_goodsId;
//        needParams[@"goodsName"]=needParams[@"name"];
        
        [editShopModel fetchEditShopData:tempParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
            
            if (isSuccess) {
                [MBProgressHUD showSuccess:result];//@"产品编辑成功"
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showError:@"产品编辑失败"];
            }
        }];
        
    }else{
        DLog(@"----->%@",needParams);
        
        [upLoadGoodsModel fetchUploadGoodsData:needParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
            
            if (isSuccess) {
                
                [MBProgressHUD showSuccess:@"产品上传成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [MBProgressHUD showError:result];
            }
        }];
    }
}


-(BOOL)validateProperty{
    
    BOOL temp=NO;
    
    for (CLSHupLoadPropertyModel *model in _upLoadPropertyArr) {
        
        if (model.name.length==0 || model.stock==0 || model.price==0) {
            temp=NO;
            break;
        }else{
            temp=YES;
            continue;
        }
    }
    return temp;
}

-(BOOL)validateUpLoadModel{
    if (_upLoadImgStrArr.count==0) {
        [MBProgressHUD showError:@"请选择你需要上传的图片"];
        return NO;
    }else if (upLoadGoodsModel.name.length==0){
        [MBProgressHUD showError:@"请输入商品名称"];
        return NO;
    }else if (upLoadGoodsModel.specifications.count==0){
        [MBProgressHUD showError:@"请输入商品的规格属性"];
        return NO;
    }else if (upLoadGoodsModel.categoryId==0){
        [MBProgressHUD showError:@"请选择商品的类别"];
        return NO;
    }else if (upLoadGoodsModel.remark.length==0){
        [MBProgressHUD showError:@"请输入备注信息"];
        return NO;
    }else{
        
        if (![self validateProperty]) {
            [MBProgressHUD showError:@"请完善商品规格属性信息"];
            return NO;
        }
        return YES;
    }
}

#pragma mark <getter setter>
-(void)setItemModel:(CLSHHomeShopListItemModel *)itemModel{
    _itemModel=itemModel;
}

-(void)setIsEditShop:(BOOL)isEditShop{
    _isEditShop=isEditShop;
}

-(void)setGoodsId:(NSString *)goodsId{
    _goodsId=goodsId;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//参与折扣
#pragma mark - <CLSHIsJoinDiscountCellDelegate>
-(void)clickSwitch:(BOOL)isUse
{
//    if (isUse) {
//        upLoadGoodsModel.isDiscount=@"true";
//    }else{
//         upLoadGoodsModel.isDiscount=@"false";
//    }
}

@end
