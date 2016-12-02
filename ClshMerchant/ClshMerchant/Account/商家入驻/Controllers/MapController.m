//
//  MapController.m
//  ClshMerchant
//
//  Created by kobe on 16/9/14.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "MapController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "MBProgressHUD+KBExtension.h"
#import "KBAddressTipsView.h"
static NSString *cellID = @"cellID";
#define NavigationBarHeight  self.navigationController.navigationBar.height

@interface MapController ()<UITableViewDataSource,UITableViewDelegate,AMapSearchDelegate,MAMapViewDelegate,UIGestureRecognizerDelegate,AMapLocationManagerDelegate>
@property(nonatomic,strong)MAMapView *map;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)AMapSearchAPI *search;//地理编码搜索
@property(nonatomic,strong)AMapSearchAPI *searchRe;//反地理编码搜索
@property(nonatomic,strong)AMapSearchAPI *searchPOI;//附近点搜索
@property(nonatomic,strong)CLLocation *location;//点击获取的位置
@property(nonatomic,assign)double latitude;//点击获取的位置纬度
@property(nonatomic,assign)double longitude;//点击获取的位置经度
//@property(nonatomic,assign)CLLocationCoordinate2D touchMapCoordinate;//点击获取的位置
@property(nonatomic,assign)CGFloat zoomLevel;//缩放级别
@property(nonatomic,strong)NSMutableArray *NeibourhoodAddressArray;//附近搜索的数组
@property(nonatomic,strong)UIButton *btnZoom;//定位按钮
@property(nonatomic,strong)MAPointAnnotation *pointAnnotation;
@property(nonatomic,strong)UIImageView *imageView;///定位图
@property(nonatomic,strong)KBAddressTipsView *addressTipsView;//全局view
@property(nonatomic,assign)CLLocationCoordinate2D lastCoordinate2D;//上一次的位置
@property(nonatomic,strong)AMapLocationManager *aMapLocationManager;

@end

@implementation MapController

- (KBAddressTipsView *)addressTipsView{
    if (!_addressTipsView) {
        
        _addressTipsView = [[KBAddressTipsView alloc] initWithFrame:CGRectMake(self.map.center.x , self.map.center.y - NavigationBarHeight, 120*AppScale, 40*AppScale)];
        
        _addressTipsView.hidden = NO;
        _addressTipsView.center = CGPointMake(self.map.center.x, self.map.center.y - NavigationBarHeight - 30*AppScale);
    }
    return _addressTipsView;
}

#pragma mark --- 初始化定位按钮 ---

- (UIButton *)btnZoom{
    if (!_btnZoom) {
        _btnZoom = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnZoom.frame = CGRectMake(_map.width - 48*AppScale,30*AppScale,45*AppScale, 20*AppScale);
        [_btnZoom addTarget:self action:@selector(zoomAC) forControlEvents:UIControlEventTouchUpInside];
        _btnZoom.backgroundColor = [UIColor whiteColor];
        _btnZoom.backgroundColor = [UIColor clearColor];
        [_btnZoom setImage:[UIImage imageNamed:@"icon_locationDE"] forState:UIControlStateNormal];
      
    }
    return _btnZoom;
}
#pragma mark --- 表格初始化 ---
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.map.frame.origin.y +self.map.height, SCREENWIDTH, SCREENHEIGHT - (self.map.frame.origin.y +self.map.height)) style:UITableViewStylePlain];
    }
    return _tableView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.map.center.x , self.map.center.y , 15*AppScale, 15*AppScale)];
        _imageView.image = [UIImage imageNamed:@"icon_location"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAC)];
        [_imageView addGestureRecognizer:gesture];
        _imageView.center = CGPointMake(self.map.center.x, self.map.center.y);
    }
    return _imageView;
}
- (void)imageAC{
}

#pragma mark --- NeibourhoodAddressArray ---
-(NSMutableArray *)NeibourhoodAddressArray{
    
    if (!_NeibourhoodAddressArray) {
        _NeibourhoodAddressArray = [NSMutableArray array];
    }
    return _NeibourhoodAddressArray;
}

#pragma mark --- initUI ---
- (void)initUI{
    [self.view addSubview:self.map];
    [self.view addSubview:self.tableView];
    [self.map addSubview:self.btnZoom];
    [self.map addSubview:self.addressTipsView];
    [self.view addSubview:self.imageView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMap];
    [self initSearch];
    [self initUI];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.dataSource= self;
    self.tableView.delegate = self;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.userInteractionEnabled = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationItem.title = @"地图";
    self.navigationController.navigationBarHidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.address);
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(publishAC)];
    [rightBarButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
- (void)publishAC{
    
    if(self.addressTipsView.name != nil){
        NSString *latitude = [NSString stringWithFormat:@"%f",_latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",_longitude];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationInformation" object:nil userInfo:@{@"address":self.addressTipsView.name,@"latitude":latitude,@"longitude":longitude}];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [MBProgressHUD showError:@"地图请求中，请稍等"];
        
    }
}

#pragma mark --- 地图初始化 ---
- (void)initMap{

    self.map = [[MAMapView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, SCREENWIDTH,270*AppScale- NavigationBarHeight)];
    
    self.map.mapType = MAMapTypeStandard;//标准地图样式
    self.map.logoCenter = CGPointMake(SCREENWIDTH - 30*AppScale, 20*AppScale);//显示高德地图字的位置
    self.map.showsScale = YES;//显示比例
    self.map.showsCompass = NO;//不显示指南针
    ;
    _zoomLevel = 13.5;
    [self.map setZoomLevel:_zoomLevel animated:YES];
    
    //    [self.map setCenterCoordinate:center animated:YES];//地图平移时，缩放级别不变，可通过改变地图的中心点来移动地图
    self.map.delegate = self;
    self.map.zoomEnabled = YES;
}

#pragma mark --- AMapSearchAPI ---
- (void)initSearch{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = [NSString stringWithFormat:@"%@%@",_address,@"政府"];
    //    geo.address = _address;
    [self.search AMapGeocodeSearch:geo];
    
    
}
#pragma mark --- 地理编码回调 ---
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if (response.geocodes.count == 0) {
        return;
    }
    _latitude =   response.geocodes.lastObject.location.latitude;
    _longitude = response.geocodes.lastObject.location.longitude;
    
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    _pointAnnotation.coordinate = CLLocationCoordinate2DMake(_latitude,_longitude);
    [self.map setCenterCoordinate:_pointAnnotation.coordinate animated:YES];
    NSString *address =[NSString stringWithFormat:@"%@%@",response.geocodes.lastObject.district,response.geocodes.lastObject.township] ;
    
    self.addressTipsView.hidden = NO;
    self.addressTipsView.name = address;
    
    [self initSearchNear];
}

- (void)initSearchRe{
    self.searchRe = [[AMapSearchAPI alloc] init];
    
    self.searchRe.delegate = self;
    CGPoint center = CGPointMake(self.map.center.x, self.map.center.y - NavigationBarHeight);
    CLLocationCoordinate2D coor2d = [self.map convertPoint:center toCoordinateFromView:self.map];
    self.lastCoordinate2D = coor2d;
    NSLog(@"有没有反应：%f %f",coor2d.latitude,coor2d.longitude);
    AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:coor2d.latitude longitude:coor2d.longitude];
    _latitude = coor2d.latitude;
    _longitude = coor2d.longitude;
    //这里反地理编码
    [self.searchRe AMapReGoecodeSearch:request];
    [self initSearchNear];
    
}

#pragma mark --- 搜索的附近的列表展示 ---
- (void)initSearchNear{
    self.searchPOI = [[AMapSearchAPI alloc] init];
    self.searchPOI.delegate = self;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:_latitude longitude:_longitude ];
    request.keywords = @"建筑";
    request.types = @"餐饮服务|生活服务|商务住宅|汽车服务|风景名胜|政府机构及社会团体|科教文化服务|道路附属设施|地名地址信息|公共设施";
    request.sortrule = 0;
    request.requireExtension = YES;
    [_searchPOI AMapPOIAroundSearch:request];
    
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois == 0) {
        return;
    }
    [_NeibourhoodAddressArray removeAllObjects];
    for (AMapPOI *poi in response.pois) {
        [self.NeibourhoodAddressArray addObject:poi];
    }
    [_tableView reloadData];
    
}


#pragma mark --- 拖动事件获取地图中心点 ---
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    if (!wasUserAction)
        return;
    [self  initSearchRe];
}

//这里反地理编码
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSLog(@"泥地里");
    //    NSString *address = response.regeocode.formattedAddress;
    NSString *address =[NSString stringWithFormat:@"%@%@",response.regeocode.addressComponent.district,response.regeocode.addressComponent.township] ;
    
    
    self.addressTipsView.hidden = NO;
    self.addressTipsView.name = address;
}

#pragma mark --- 地图点击定位 ---
- (void)zoomAC{
    
    NSLog(@"定位到当前位置");
    [self configLocationManager];
}

#pragma mark <location>
-(void)configLocationManager{
    NSLog(@"1");
    _aMapLocationManager=[AMapLocationManager new];
    _aMapLocationManager.delegate=self;
    _aMapLocationManager.pausesLocationUpdatesAutomatically=NO;
    _aMapLocationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
    //iOS9.0后
    //    aMapLocationManager.allowsBackgroundLocationUpdates=YES;
    [self getLocation];
}

-(void)getLocation{
    NSLog(@"6");
    [_aMapLocationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            
        }
        _latitude=location.coordinate.latitude;
        _longitude=location.coordinate.longitude;
        if (regeocode) {
            //            NSString *address=[NSString stringWithFormat:@"%@%@",regeocode.street,regeocode.building];
            _pointAnnotation = [[MAPointAnnotation alloc] init];
            _pointAnnotation.coordinate = CLLocationCoordinate2DMake(_latitude,_longitude);
            [self.map setCenterCoordinate:_pointAnnotation.coordinate animated:YES];
            NSString *address =[NSString stringWithFormat:@"%@%@%@%@",regeocode.city,regeocode.district,regeocode.township,regeocode.street] ;
            
            self.addressTipsView.hidden = NO;
            self.addressTipsView.name = address;
            
            [self initSearchNear];
        }
    }];
}


#pragma mark --- UITableViewDataSource ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _NeibourhoodAddressArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    }
    AMapPOI *poi = _NeibourhoodAddressArray[indexPath.row];
    
    cell.textLabel.text = poi.name;
    cell.textLabel.font =[UIFont systemFontOfSize:14*AppScale];
    
    cell.detailTextLabel.text = poi.address;
    
    cell.detailTextLabel.textColor = RGBColor(102, 102, 102);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11*AppScale];
    NSLog(@"%@ %@",poi.name,poi.address);
    return cell;
}


#pragma mark --- UITableViewDelegate ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*AppScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI *poi = _NeibourhoodAddressArray[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *latitude = [NSString stringWithFormat:@"%f",[poi.location latitude]];
    NSString *longitude = [NSString stringWithFormat:@"%f",[poi.location longitude]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LocationInformation" object:nil userInfo:@{@"address":cell.detailTextLabel.text,@"latitude":latitude,@"longitude":longitude}];
    NSLog(@"poi.location%@",poi.location);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
