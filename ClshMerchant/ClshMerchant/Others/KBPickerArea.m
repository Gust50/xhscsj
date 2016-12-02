//
//  KBPickerArea.m
//  KBPickerArea
//
//  Created by kobe on 16/4/19.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBPickerArea.h"

/** 屏幕尺寸 */
#define ScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DefalutHeight 200

@interface KBPickerArea()<UIPickerViewDataSource,UIPickerViewDelegate>

/** 数据源(dataSource) */
@property(nonatomic,strong,nullable)NSArray *dataSoure;
/** 省数组(Province Array) */
@property(nonatomic,strong,nullable)NSMutableArray *provinceArr;
/** 城市数组(City Array) */
@property(nonatomic,strong,nullable)NSMutableArray *cityArr;
/** 区域数组(Area Array) */
@property(nonatomic,strong,nullable)NSMutableArray *areaArr;
/** 选中数组(Selected Array) */
@property(nonatomic,strong,nullable)NSMutableArray *selecteArr;
/** 省id数组(Province Array) */
@property(nonatomic,strong,nullable)NSMutableArray * provinceIdArr;
/** 城市id数组(City Array) */
@property(nonatomic,strong,nullable)NSMutableArray * cityIdArr;
/** 区域id数组(Area Array) */
@property(nonatomic,strong,nullable)NSMutableArray * areaIdArr;

/** 省(Province) */
@property(nonatomic,copy,nullable)NSString *province;
/** 城市(City) */
@property(nonatomic,copy,nullable)NSString *city;
/** 区域(Area) */
@property(nonatomic,copy,nullable)NSString *area;
/**地址id(areaId)*/
@property(nonatomic,copy,nullable)NSString * areaId;

/** 选择器(picker) */
@property(nonatomic,strong)UIPickerView *pickerView;
/** 工具栏(toolBar) */
@property(nonatomic,strong)UIView *toolBarView;
/** 显示地址(show Address) */
@property(nonatomic,strong)UILabel *showAddress;

@end

@implementation KBPickerArea


#pragma mark-lazyLoad
-(NSArray *)dataSoure{
    if (!_dataSoure) {
         NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath = [docPath stringByAppendingPathComponent:@"area.plist"];
        _dataSoure=[[NSArray array]initWithContentsOfFile:filePath];
    }
    return _dataSoure;
}

-(NSMutableArray *)provinceArr{
    if (!_provinceArr) {
        _provinceArr=[NSMutableArray array];
    }
    return _provinceArr;
}

-(NSMutableArray *)cityArr{
    if (!_cityArr) {
        _cityArr=[NSMutableArray array];
    }
    return _cityArr;
}

-(NSMutableArray *)areaArr{
    if (!_areaArr) {
        _areaArr=[NSMutableArray array];
    }
    return _areaArr;
}

- (NSMutableArray *)provinceIdArr{

    if (!_provinceIdArr) {
        _provinceIdArr = [NSMutableArray array];
    }
    return _provinceIdArr;
}
- (NSMutableArray *)cityIdArr{

    if (!_cityIdArr) {
        _cityIdArr = [NSMutableArray array];
    }
    return _cityIdArr;
}
- (NSMutableArray *)areaIdArr{

    if (!_areaIdArr) {
        _areaIdArr = [NSMutableArray array];
    }
    return _areaIdArr;
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0,ScreenHeight+DefalutHeight,ScreenWidth,DefalutHeight)];
        _pickerView.delegate=self;
        _pickerView.dataSource=self;
        _pickerView.backgroundColor=[UIColor whiteColor];
    }
    return _pickerView;
}

-(UIView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight+DefalutHeight+40, ScreenWidth, 40)];
        _toolBarView.backgroundColor=RGBA(230.0, 230.0, 230.0, 1);
    }
    return _toolBarView;
}

-(UILabel *)showAddress{
    if (!_showAddress) {
        _showAddress=[[UILabel alloc]initWithFrame:CGRectMake(70, 5, ScreenWidth-140, 30)];
        _showAddress.textAlignment=NSTextAlignmentCenter;
        _showAddress.textColor=RGBA(51.0, 51.0, 51.0, 1);
        _showAddress.font=[UIFont systemFontOfSize:16];
    }
    return _showAddress;
}


#pragma mark-init
-(instancetype)initWithDelegate:(id)delegate{
    self=[self init];
    self.delegate=delegate;
    return self;
}


-(instancetype)init{
    self=[super init];
    if (self) {
        [self setupToolBarUI];
        [self loadData];
    }
    return self;
}

#pragma mark-UI
-(void)setupToolBarUI{
    
    self.bounds=[[UIScreen mainScreen]bounds];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeSelectAreaView)];
    [self addGestureRecognizer:tap];
    self.backgroundColor=RGBA(0, 0, 0, 0.4);
    //透明度
    self.layer.opaque=0.0;
    
    UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
    [leftButton addTarget:self action:@selector(removeSelectAreaView) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [leftButton setTitleColor:RGBA(102.0, 102.0, 102.0, 1) forState:UIControlStateNormal];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-70, 5, 60,30)];
    [rightButton addTarget:self action:@selector(confirmButton:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [rightButton setTitleColor:RGBA(0, 149.0, 68.0, 1) forState:UIControlStateNormal];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    
    //添加子视图
    [self.toolBarView addSubview:leftButton];
    [self.toolBarView addSubview:rightButton];
    [self.toolBarView addSubview:self.showAddress];
    
    [self addSubview:self.toolBarView];
    [self addSubview:self.pickerView];
}

#pragma mark-UIPickerViewDataSource

//一共有多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

//每列返回多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        return self.provinceArr.count;
    }else if(component == 1){
        if (self.cityArr.count) {
            return self.cityArr.count;
        }
        else{
            return 0;
        }
        
    }else{
        if (self.areaArr.count) {
            return self.areaArr.count;
        }else{
        
            return 0;
        }

    }
    
}

//显示
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//    NSString *string;
//    if (component==0) {
//        string=self.provinceArr[row];
//    }else if (component==1){
//        string=self.cityArr[row];
//    }
////    else{
////        if (self.areaArr.count>0) {
////            string=self.areaArr[row];
////        }else{
////            string=@"";
////        }
////    }
//    return string;
//}

//自定View
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    NSString *string;
    if (component==0) {
        if ([self.provinceArr count]!=0) {
             string=self.provinceArr[row];
        }else{
            string=@"";
        }
       
    }else if (component==1){
        if ([self.cityArr count]!=0) {
            string=self.cityArr[row];
        }else{
            string=@"";
        }
        
    }else{
    
        if ([self.areaArr count]!=0) {
            string = self.areaArr[row];
        }else{
        
            string = @"";
        }
    }
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:string];
    return label;
}


#pragma mark-UIPickerViewDelegate

//显示每行每列的数据
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //选中第一列
    if (component==0) {
        
        //清空城市的数组
        
        if (self.dataSoure[row][@"children"]) {
            
            
        //获取当前省份的所有的城市
        self.selecteArr=self.dataSoure[row][@"children"];
        [self.cityArr removeAllObjects];
        [self.cityIdArr removeAllObjects];
        
        [self.selecteArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //添加这个省份的所有的城市到这个数组
            if (obj[@"name"] && obj[@"value"]) {
                [self.cityArr addObject:obj[@"name"]];
                [self.cityIdArr addObject:obj[@"value"]];
            }
          
            
            
        }];
        
       // NSLog(@"%@",self.cityIdArr);
        
        [self.areaArr removeAllObjects];
        [self.areaIdArr removeAllObjects];
        if ([self.selecteArr firstObject][@"children"]) {
            NSMutableArray * marray = [NSMutableArray arrayWithArray:[self.selecteArr firstObject][@"children"]];
            [marray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.areaArr addObject:obj[@"name"]];
                [self.areaIdArr addObject:obj[@"value"]];
            }];
        }else{
        
            self.areaArr = nil;
            self.areaIdArr = nil;
        }
        }
       // NSLog(@"%@",self.areaIdArr);
        
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
            
        
    }else if(component == 1){
    
        [self.areaArr removeAllObjects];
        [self.areaIdArr removeAllObjects];
        if ( self.selecteArr == 0 && [self.dataSoure firstObject][@"children"]) {
            self.selecteArr = [self.dataSoure firstObject][@"children"];
        }
        if ([self.selecteArr objectAtIndex:row][@"children"]) {
            NSMutableArray * marray = [NSMutableArray arrayWithArray:[self.selecteArr objectAtIndex:row][@"children"]];
            [marray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.areaArr addObject:obj[@"name"]];
                [self.areaIdArr addObject:obj[@"value"]];
            }];
        }
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
     [self reloadData];
}

//设置高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30;
}

//设置字体的颜色
//-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    
//    NSDictionary *attrDic=@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
//    NSMutableAttributedString *attrSring;
//    
//    if (component==0) {
//        attrSring=[[NSMutableAttributedString alloc]initWithString:self.provinceArr[row] attributes:attrDic];
//        
//    }else{
//        attrSring=[[NSMutableAttributedString alloc]initWithString:self.cityArr[row] attributes:attrDic];
//    }
//    return attrSring;
//}

#pragma mark-otherResponse

//刷新数据
-(void)reloadData{
    NSInteger index_Province=[self.pickerView selectedRowInComponent:0];
    NSInteger index_City=[self.pickerView selectedRowInComponent:1];
    NSInteger index_Area = [self.pickerView selectedRowInComponent:2];
    self.province=self.provinceArr[index_Province];
    
    self.city=self.cityArr[index_City];
    if (self.areaArr.count != 0 && self.areaArr != nil) {
        self.area = self.areaArr[index_Area];
        self.areaId = self.areaIdArr[index_Area];
        
    }else{
        self.area = @"";
        self.areaId = self.cityIdArr[index_City];
        
    }
    
    NSString *address=[NSString stringWithFormat:@"%@%@%@",self.province,self.city,self.area];
    self.showAddress.text=address;
}


-(void)defalutAddress{
    self.province=self.provinceArr[0];
    self.city=self.cityArr[0];
    if (self.areaArr.count != 0 && self.areaArr != nil) {
        self.area = self.areaArr[0];
        self.areaId = self.areaIdArr[0];
        
    }else{
        self.area = @"";
        self.areaId = self.cityIdArr[0];
        
    }
    
    NSString *address=[NSString stringWithFormat:@"%@%@%@",self.province,self.city,self.area];
    self.showAddress.text=address;
}

//加载数据
-(void)loadData{
    
    //省份
    [self.dataSoure enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.provinceArr addObject:obj[@"name"]];
    }];
    
    //省对应的城市
    NSMutableArray *cities=[NSMutableArray arrayWithArray:[self.dataSoure firstObject][@"children"]];
    [cities enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.cityArr addObject:obj[@"name"]];
        [self.cityIdArr addObject:obj[@"value"]];
    }];
    // NSLog(@"%@",[self.cityArr mj_JSONData]);
    
    //城市对应的区县
    if (([cities firstObject][@"children"])) {
        NSMutableArray * areas = [NSMutableArray arrayWithArray:[cities firstObject][@"children"]];
        [areas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.areaArr addObject:obj[@"name"]];
            [self.areaIdArr addObject:obj[@"value"]];
        }];
    }else{
        
        self.areaArr = nil;
        self.areaIdArr = nil;
    }
    
    self.province = self.provinceArr[0];
    self.city = self.cityArr[0];
    if (self.areaArr.count != 0 ) {
        self.area = self.areaArr[0];
    }else{
    
        self.area = @"";
    }
     [self defalutAddress];
}

//显示视图
-(void)showSelectAreaView{
    
    //获取window
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect toolBarViewFrame=self.toolBarView.frame;
    toolBarViewFrame.origin.y-=2*(DefalutHeight+40);
    
    CGRect pickerViewFrame=self.pickerView.frame;
    pickerViewFrame.origin.y-=2*DefalutHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.layer setOpacity:1];
        self.toolBarView.frame=toolBarViewFrame;
        self.pickerView.frame=pickerViewFrame;
    }completion:^(BOOL finished) {
        
    }];
}

//移除视图
-(void)removeSelectAreaView{
    
    CGRect toolBarViewFrame=self.toolBarView.frame;
    toolBarViewFrame.origin.y+=2*(DefalutHeight+40);
    
    CGRect pickerViewFrame=self.pickerView.frame;
    pickerViewFrame.origin.y+=2*DefalutHeight;
    
    [UIView animateWithDuration:0.2 animations:^{
        //透明度 ，类似于UIView的alpha
        [self.layer setOpacity:1];
        self.toolBarView.frame=toolBarViewFrame;
        self.pickerView.frame=pickerViewFrame;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//确认按钮
-(void)confirmButton:(UIButton *)button{
    
    if (self.province.length!=0 || self.city.length!=0 || self.area.length != 0) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(pickerArea:province:city:area:areaId:)]) {
            [self.delegate pickerArea:self province:self.province city:self.city area:self.area areaId:self.areaId];
            [self removeFromSuperview];
        }
        
        
//        if (self.delegate && [self.delegate respondsToSelector:@selector(pickerArea:province:city:area:)]) {
//            [self.delegate pickerArea:self province:self.province city:self.city area:self.area];
//            [self removeSelectAreaView];
//        }
    }else{
        
        UIAlertView *showMessage=[[UIAlertView alloc]initWithTitle:@"信息提示" message:@"请选择地址" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [showMessage show];
    }
}

#pragma mark-setter getter
-(void)setDictAddress:(NSDictionary *)dictAddress{
    
    _dictAddress=dictAddress;
}


@end
