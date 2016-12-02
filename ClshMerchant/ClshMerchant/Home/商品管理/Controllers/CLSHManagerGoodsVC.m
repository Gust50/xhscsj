//
//  CLSHManagerGoodsVC.m
//  ClshMerchant
//
//  Created by kobe on 16/8/1.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "CLSHManagerGoodsVC.h"
#import "CLSHOnSaleCell.h"
#import "CLSHOnSaleToolbar.h"
#import "CLSHOnSaleSegment.h"
#import "CLSHEditOnSaleToolBar.h"
#import "CLSHManagerModifyClassfyVC.h"
#import "CLSHHomeShopListModel.h"
#import "CLSHUpLoadGoodsVC.h"

@interface CLSHManagerGoodsVC ()<UITableViewDataSource,UITableViewDelegate,CLSHOnSaleCellDeleagate,CLSHOnSaleToolbarDelegate,CLSHEditOnSaleToolBarDelegate,CLSHOnSaleSegmentDelegate>
{
    CLSHHomeShopListModel *homeShopListModel;
    CLSHHomeOnSaleShopModel *homeOnSaleShopModel;
    CLSHHomeSaleOutShopModel *homeSaleOutShopModel;
    CLSHHomeDeleteShopModel *homeDeleteShopModel;
    CLSHHomeShopTypeNumbersModel *homeShopTypeNumbersModel;
    NSMutableDictionary *params;
    NSInteger currentPage;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CLSHOnSaleToolbar *onSaleToolBar;
@property (nonatomic, strong) CLSHEditOnSaleToolBar *editOnSaleToolBar;
@property (nonatomic, strong) CLSHOnSaleSegment *onSaleSegment;
@property (nonatomic, assign) BOOL expand;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger totalPages;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, assign) BOOL isOnSale;
@end

@implementation CLSHManagerGoodsVC
static NSString *const cellID=@"cellID";

#pragma mark <lazyLoad>
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40*AppScale, SCREENWIDTH, SCREENHEIGHT-64-49-40*AppScale) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

-(CLSHOnSaleToolbar *)onSaleToolBar{
    if (!_onSaleToolBar) {
        _onSaleToolBar=[[CLSHOnSaleToolbar alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    }
    return _onSaleToolBar;
}

-(CLSHOnSaleSegment *)onSaleSegment{
    if (!_onSaleSegment) {
        _onSaleSegment=[[CLSHOnSaleSegment alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 40*AppScale)];
        _onSaleSegment.delegate=self;
    }
    return _onSaleSegment;
}

-(CLSHEditOnSaleToolBar *)editOnSaleToolBar{
    if (!_editOnSaleToolBar) {
        _editOnSaleToolBar=[[CLSHEditOnSaleToolBar alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-49, SCREENWIDTH, 49)];
    }
    return _editOnSaleToolBar;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark <lifeCycle>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=backGroundColor;
    self.tableView.backgroundColor=backGroundColor;
    
    [self.navigationItem setTitle:@"商品管理"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.expand=NO;
    self.indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.view addSubview:self.editOnSaleToolBar];
    _editOnSaleToolBar.isSaleOut=NO;
    _editOnSaleToolBar.delegate=self;
    
    _editOnSaleToolBar.hidden=YES;
    [self.view addSubview:self.onSaleToolBar];
    _onSaleToolBar.delegate=self;
    
    [self.view addSubview:self.onSaleSegment];
    [self.view addSubview:self.tableView];
    _tableView.tableFooterView=[[UIView alloc]init];
    
    [_tableView registerClass:[CLSHOnSaleCell class] forCellReuseIdentifier:cellID];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self initModel];
    
    self.tableView.mj_header=[KBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer=[KBRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_header beginRefreshing];
}



-(void)initModel{
    
    self.isEdit=NO;
    self.isOnSale=YES;
    params=[NSMutableDictionary dictionary];
    homeShopListModel=[CLSHHomeShopListModel new];
    
    homeShopTypeNumbersModel=[CLSHHomeShopTypeNumbersModel new];
    [homeShopTypeNumbersModel addObserver:self forKeyPath:@"currentOnSaleCount" options:NSKeyValueObservingOptionNew context:nil];
    [homeShopTypeNumbersModel addObserver:self forKeyPath:@"currentSaleOutCount" options:NSKeyValueObservingOptionNew context:nil];
    
    homeSaleOutShopModel=[CLSHHomeSaleOutShopModel new];
    homeOnSaleShopModel=[CLSHHomeOnSaleShopModel new];
    homeDeleteShopModel=[CLSHHomeDeleteShopModel new];
}

-(void)loadNewData{
    currentPage=1;
    params[@"pageNumber"]=@(currentPage);
    params[@"pageSize"]=@(10);
    params[@"categoryId"] = _categoryId;
    
    [homeShopListModel fetchShopListData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            
            [_dataSource removeAllObjects];
            homeShopListModel=result;
            
            if (_isOnSale) {
                homeShopTypeNumbersModel.currentOnSaleCount=homeShopListModel.totalRecord;
            }else{
                homeShopTypeNumbersModel.currentSaleOutCount=homeShopListModel.totalRecord;
            }
            
            self.totalPages=homeShopListModel.totalPages;
            [self.dataSource addObjectsFromArray:homeShopListModel.items];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (homeShopListModel.items.count<10) {
                self.tableView.mj_footer.hidden=YES;
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                self.tableView.mj_footer.hidden=NO;
                [self.tableView.mj_footer resetNoMoreData];
            }
            
        }else{
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

-(void)loadMoreData{
    if (currentPage<_totalPages) {
        currentPage++;
        params[@"pageNumber"]=@(currentPage);
        [homeShopListModel fetchShopListData:params callBack:^(BOOL isSuccess, id  _Nonnull result) {
           
            if (isSuccess) {
                homeShopListModel=result;
                [_dataSource addObjectsFromArray:homeShopListModel.items];
                
                if (_isOnSale) {
                    homeShopTypeNumbersModel.currentOnSaleCount=homeShopListModel.totalRecord;
                }else{
                    homeShopTypeNumbersModel.currentSaleOutCount=homeShopListModel.totalRecord;
                }
                [self.tableView reloadData];
                if (homeShopListModel.items.count<10) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
            }
        }];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"currentOnSaleCount"]) {
        
        if (homeShopTypeNumbersModel.currentOnSaleCount==0) {
            
        }else{
            
             _onSaleSegment.onSaleText=[NSString stringWithFormat:@"出售中(%ld)",homeShopTypeNumbersModel.currentOnSaleCount];
        }
    }else if ([keyPath isEqualToString:@"currentSaleOutCount"]){
        if (homeShopTypeNumbersModel.currentSaleOutCount==0) {
            
        }else{
            _onSaleSegment.saleOutText=[NSString stringWithFormat:@"已下架(%ld)",homeShopTypeNumbersModel.currentSaleOutCount];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


-(void)dealloc{
    [homeShopTypeNumbersModel removeObserver:self forKeyPath:@"currentOnSaleCount" context:nil];
    [homeShopTypeNumbersModel removeObserver:self forKeyPath:@"currentSaleOutCount" context:nil];
}


#pragma mark <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLSHOnSaleCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.delegate=self;
    CLSHHomeShopListItemModel *tempModel=_dataSource[indexPath.row];
    cell.expanded=tempModel.isExpand;
    cell.indexPath=indexPath;
    cell.isEdit=_isEdit;
    cell.isSaleOut=!_isOnSale;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.itemModel=_dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CLSHHomeShopListItemModel *tempModel=_dataSource[indexPath.row];
    if (tempModel.isExpand) {
        return 140*AppScale;
    }else{
        return 100*AppScale;
    }
}
#pragma mark <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isEdit) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark <CLSHOnSaleCellDeleagate>
-(void)expandBtn:(BOOL)expand indexPath:(NSIndexPath *)indexPath{
    [self reset];
    CLSHHomeShopListItemModel *tempModel=_dataSource[indexPath.row];
    tempModel.isExpand=expand;
//    NSIndexPath *index=[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
//    [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadData];
}

-(void)editShop:(NSIndexPath *)indexPath{
    CLSHHomeShopListItemModel *tempModel=_dataSource[indexPath.row];
    CLSHUpLoadGoodsVC *cLSHUpLoadGoodsVC=[CLSHUpLoadGoodsVC new];
    cLSHUpLoadGoodsVC.goodsId=tempModel.goodsId;
    cLSHUpLoadGoodsVC.isEditShop=YES;
    [self.navigationController pushViewController:cLSHUpLoadGoodsVC animated:YES];
}

-(void)onSaleShop:(NSIndexPath *)indexPath{
     CLSHHomeShopListItemModel *tempModel=_dataSource[indexPath.row];
    [self onSaleShopRequest:@[tempModel.goodsId] indexPath:indexPath isSelectAll:NO];
    
}

-(void)deleteShop:(NSIndexPath *)indexPath{
     CLSHHomeShopListItemModel *tempModel=_dataSource[indexPath.row];
    [self deleteShopRequest:@[tempModel.goodsId] indexPath:indexPath isSelectAll:NO];
}

-(void)editShopCategory:(NSIndexPath *)indexPath{
    CLSHHomeShopListItemModel *tempModel=_dataSource[indexPath.row];
    CLSHManagerModifyClassfyVC *classifyVC = [[CLSHManagerModifyClassfyVC alloc] init];
    classifyVC.goodsId = tempModel.goodsId;
    [self.navigationController pushViewController:classifyVC animated:YES];
}

-(void)saleOutShop:(NSIndexPath *)indexPath{
    CLSHHomeShopListItemModel *tempModel=_dataSource[indexPath.row];
    [self saleOutShopRequest:@[tempModel.goodsId] indexPath:indexPath isSelectAll:NO];
}

-(void)clickArrow{
    _editOnSaleToolBar.isSelectAll=[self isSelectAllShops];
}

-(BOOL)isSelectAllShops{
    
    BOOL temp=NO;
    for (CLSHHomeShopListItemModel *model in _dataSource) {
        
        if (!model.isArrow) {
            temp=NO;
            break;
        }else{
            temp=YES;
            continue;
        }
    }
    
    NSLog(@"temp value: %@" ,temp?@"YES":@"NO");
    return temp;
}



#pragma mark <CLSHOnSaleSegmentDelegate>
-(void)clickSegment:(BOOL)isOnsale{
    _isOnSale=isOnsale;
    
     _editOnSaleToolBar.isSaleOut=!isOnsale;
    
    _isEdit=NO;
    _editOnSaleToolBar.hidden=YES;
    _onSaleToolBar.hidden=NO;
//    for (CLSHHomeShopListItemModel *model in _dataSource) {
//        model.isArrow=NO;
//    }
    _editOnSaleToolBar.isSelectAll=NO;
    
//    [self.tableView reloadData];
    
    if (isOnsale) {
        params[@"isMarkable"]=@"true";
    }else{
        params[@"isMarkable"]=@"false";
    }
    [self.tableView.mj_header beginRefreshing];
    
    NSLog(@"_isOnSale value: %@" ,_isOnSale?@"YES":@"NO");
}

#pragma mark <CLSHEditOnSaleToolBarDelegate>
-(void)doneEditing{
    _isEdit=NO;
    _editOnSaleToolBar.hidden=YES;
    _onSaleToolBar.hidden=NO;
    for (CLSHHomeShopListItemModel *model in _dataSource) {
        model.isArrow=NO;
    }
    _editOnSaleToolBar.isSelectAll=NO;
    [self.tableView reloadData];
}


-(void)selectAllShops:(BOOL)isSelectAll{
    
    if (isSelectAll) {
        
        for (CLSHHomeShopListItemModel *model in _dataSource) {
            model.isArrow=YES;
        }

    }else{
        for (CLSHHomeShopListItemModel *model in _dataSource) {
            model.isArrow=NO;
        }
    }
     [self.tableView reloadData];
}

-(void)delectShops{
    
    if ([self caculatorGoodsId].count==0) {
        
        [MBProgressHUD showError:@"请选择你要删除的产品"];
       
    }else{
        
         [self deleteShopRequest:[self caculatorGoodsId] indexPath:nil isSelectAll:YES];
    }
}


-(void)onSaleShops{
    
    if ([self caculatorGoodsId].count==0) {
        
        [MBProgressHUD showError:@"请选择你要上架的产品"];
    }else{
        
         [self onSaleShopRequest:[self caculatorGoodsId] indexPath:nil isSelectAll:YES];
    }
    
}

-(void)saleOutShops{
    
    if ([self caculatorGoodsId].count==0) {
        
        [MBProgressHUD showError:@"请选择你要下架的产品"];
    }else{
        
        [self saleOutShopRequest:[self caculatorGoodsId] indexPath:nil isSelectAll:YES];
    }
}


-(NSArray *)caculatorGoodsId{
    
    NSMutableArray *tempArr=[NSMutableArray array];
    
    for (CLSHHomeShopListItemModel *model in _dataSource) {
        if (model.isArrow) {
            [tempArr addObject:model.goodsId];
        }
    }
    return [tempArr copy];
}

#pragma mark <CLSHOnSaleToolbarDelegate>
-(void)addShops{
    
    CLSHUpLoadGoodsVC *cLSHUpLoadGoodsVC=[CLSHUpLoadGoodsVC new];
    [self.navigationController pushViewController:cLSHUpLoadGoodsVC animated:YES];
}

-(void)managerShops{
    
    _isEdit=YES;
    _editOnSaleToolBar.hidden=NO;
    _onSaleToolBar.hidden=YES;
    [self.tableView reloadData];
}
#pragma mark <otherResponse>
-(void)reset{
    for (CLSHHomeShopListItemModel *model in _dataSource) {
        model.isExpand=NO;
    }
}

-(void)onSaleShopRequest:(NSArray *)goodsIds indexPath:(NSIndexPath *)indexPath isSelectAll:(BOOL)isSelectAll{
    
    NSMutableDictionary *tempParams=[NSMutableDictionary dictionary];
    tempParams[@"goodsIds"]=goodsIds;
    
    [homeOnSaleShopModel fetchOnSaleShopData:tempParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        
        if (isSuccess) {
            
            if (isSelectAll) {
                 [[MBProgressHUD showMessage:@"商品批量上架成功"]hide:YES afterDelay:0.8];
            }else{
                 [[MBProgressHUD showMessage:@"商品上架成功"]hide:YES afterDelay:0.8];
                homeShopTypeNumbersModel.currentOnSaleCount+=1;
                homeShopTypeNumbersModel.currentSaleOutCount-=1;
            }
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.8*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
               
                if (isSelectAll) {
                     _editOnSaleToolBar.isSelectAll=NO;
                    [self.tableView.mj_header beginRefreshing];
                    
                }else{
                    [_dataSource removeObjectAtIndex:[indexPath row]];
                    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                    [_tableView reloadData];
                }
            });
            
        }else{
            
            if (isSelectAll) {
                [[MBProgressHUD showMessage:@"商品批量上架失败"]hide:YES afterDelay:0.8];
            }else{
                [[MBProgressHUD showMessage:@"商品上架失败"]hide:YES afterDelay:0.8];
            }
            
        }
    }];
}

-(void)saleOutShopRequest:(NSArray *)goodsIds indexPath:(NSIndexPath *)indexPath isSelectAll:(BOOL)isSelectAll{
    NSMutableDictionary *tempParams=[NSMutableDictionary dictionary];
    tempParams[@"goodsIds"]=goodsIds;
    
    [homeSaleOutShopModel fetchSaleOutShopData:tempParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
            
            if (isSelectAll) {
                [[MBProgressHUD showMessage:@"商品批量下架成功"]hide:YES afterDelay:0.8];
                
            }else{
                [[MBProgressHUD showMessage:@"商品下架成功"]hide:YES afterDelay:0.8];
                
                homeShopTypeNumbersModel.currentOnSaleCount-=1;
                homeShopTypeNumbersModel.currentSaleOutCount+=1;
                NSLog(@"---------------------------------");
                NSLog(@"%ld",(long)homeShopTypeNumbersModel.currentOnSaleCount);
                NSLog(@"%ld",homeShopTypeNumbersModel.currentSaleOutCount);
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.8*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                if (isSelectAll) {
                     _editOnSaleToolBar.isSelectAll=NO;
                    [self.tableView.mj_header beginRefreshing];
                    
                }else{
                    [_dataSource removeObjectAtIndex:[indexPath row]];
                    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                    [_tableView reloadData];
                }
            });
        }else{
            
            if (isSelectAll) {
                [[MBProgressHUD showMessage:@"商品批量下架失败"]hide:YES afterDelay:0.8];
            }else{
               [[MBProgressHUD showMessage:@"商品下架失败"]hide:YES afterDelay:0.8];
            }
           
        }
    }];
}

-(void)deleteShopRequest:(NSArray *)goodsIds indexPath:(NSIndexPath *)indexPath isSelectAll:(BOOL)isSelectAll{
    NSMutableDictionary *tempParams=[NSMutableDictionary dictionary];
    tempParams[@"goodsIds"]=goodsIds;
    
    [homeDeleteShopModel fetchDeleteShopData:tempParams callBack:^(BOOL isSuccess, id  _Nonnull result) {
        if (isSuccess) {
        
            if (isSelectAll) {
                [[MBProgressHUD showMessage:@"商品批量删除成功"]hide:YES afterDelay:0.8];
            }else{
                [[MBProgressHUD showMessage:@"商品删除成功"]hide:YES afterDelay:0.8];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.8*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                if (isSelectAll) {
                     _editOnSaleToolBar.isSelectAll=NO;
                    [self.tableView.mj_header beginRefreshing];
                    
                }else{
                    [_dataSource removeObjectAtIndex:[indexPath row]];
                    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                    [_tableView reloadData];
                }
            });
        }else{
            
            if (isSelectAll) {
                 [[MBProgressHUD showMessage:@"商品批量删除失败"]hide:YES afterDelay:0.8];
            }else{
                 [[MBProgressHUD showMessage:@"商品删除失败"]hide:YES afterDelay:0.8];
            }
        }
    }];
}


@end
