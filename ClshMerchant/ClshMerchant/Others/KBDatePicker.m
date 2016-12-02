//
//  KBPickerTime.m
//  ClshMerchant
//
//  Created by kobe on 16/8/4.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBDatePicker.h"
#import "KBDateFormatter.h"
@interface KBDatePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *coverBtn;
@property (nonatomic, strong) UILabel *showDateTimeLab;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, assign) NSInteger startYear;
@property (nonatomic, assign) NSInteger maxYear;
@property (nonatomic, assign) NSInteger maxDay;

@property (nonatomic, assign) NSInteger selectYear;
@property (nonatomic, assign) NSInteger selectMonth;
@property (nonatomic, assign) NSInteger selectDay;
@property (nonatomic, assign) NSInteger selectHour;

@property (nonatomic, strong) NSCalendar *calendar;

@end

@implementation KBDatePicker

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView=[UIPickerView new];
        _pickerView.delegate=self;
        _pickerView.dataSource=self;
        _pickerView.backgroundColor=backGroundColor;
    }
    return _pickerView;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn=[UIButton new];
        [_cancelBtn setTitle:@"取消" forState:0];
        _cancelBtn.backgroundColor=systemColor;
        _cancelBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn=[UIButton new];
        [_confirmBtn setTitle:@"确定" forState:0];
        _confirmBtn.backgroundColor=systemColor;
        _confirmBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_confirmBtn addTarget:self action:@selector(clickConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

-(UILabel *)showDateTimeLab{
    if (!_showDateTimeLab) {
        _showDateTimeLab=[UILabel new];
        _showDateTimeLab.font=[UIFont systemFontOfSize:14];
        _showDateTimeLab.textAlignment=NSTextAlignmentCenter;
        _showDateTimeLab.backgroundColor=backGroundColor;
    }
    return _showDateTimeLab;
}

-(UIView *)topView{
    if (!_topView) {
        _topView=[UIView new];
    }
    return _topView;
}

-(UIButton *)coverBtn{
    if (!_coverBtn) {
        _coverBtn=[UIButton new];
        _coverBtn.backgroundColor=[UIColor grayColor];
        _coverBtn.alpha=0.6;
        [_coverBtn addTarget:self action:@selector(clickCoverBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _coverBtn.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _cancelBtn.frame=CGRectMake(0,0, 60, 30);
    _confirmBtn.frame=CGRectMake(SCREENWIDTH-60, 0, 60, 30);
    _showDateTimeLab.frame=CGRectMake(60, 0, SCREENWIDTH-120, 30);
    _pickerView.frame=CGRectMake(0,30, SCREENWIDTH, self.frame.size.height/2.5-30);
}

-(void)initUI{
    
    [self addSubview:self.coverBtn];
    [self addSubview:self.topView];
    
    [_topView addSubview:self.cancelBtn];
    [_topView addSubview:self.confirmBtn];
    [_topView addSubview:self.showDateTimeLab];
    [_topView addSubview:self.pickerView];
    [self initDate];
}

#pragma mark <UIPickerViewDataSource>
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //year month day hour
    return 4;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    switch (component) {
            //year
        case 0:
            return _maxYear;
            break;
            //month
        case 1:
            return 12;
            break;
            //day
        case 2:
            return _maxDay;
            break;
            //hour
        case 3:
            return 24;
            break;
        default:
            return 0;
            break;
    }
}

//custom view
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH*component/4, 0, SCREENWIDTH/4, 30)];
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentCenter;
    
    switch (component) {
        case 0:
            label.text=[NSString stringWithFormat:@"%ld年",(long)(_startYear+row)];
            break;
        case 1:
            label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
            break;
        case 2:
            label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
            break;
        case 3:
            label.text=[NSString stringWithFormat:@"%ld时",(long)row];
            break;
        default:
            break;
    }
     return label;
}


#pragma mark <UIPickerViewDelegate>
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
        {
            _selectYear=_startYear+row;
            _maxDay=[self caculatorDay:_selectYear month:_selectMonth];
            [_pickerView reloadComponent:2];
        }
            break;
        case 1:
        {
            _selectMonth=row+1;
            _maxDay=[self caculatorDay:_selectYear month:_selectMonth];
            [_pickerView reloadComponent:2];
            
        }
            break;
            case 2:
        {
            _selectDay=row+1;
        }
            break;
        case 3:
        {
            _selectHour=row;
        }
            break;
        default:
            break;
    }
    
    _showDateTimeLab.text=[NSString stringWithFormat:@"%ld年%ld月%ld日%ld时",(long)_selectYear,(long)_selectMonth,(long)_selectDay,(long)_selectHour];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(showDataPicker:timeString:)]) {
        [self.delegate showDataPicker:[NSString stringWithFormat:@"%ld年%ld月%ld日%ld时",(long)_selectYear,(long)_selectMonth,(long)_selectDay,(long)_selectHour] timeString:[self caculatorTime]];
    }
}

#pragma mark <otherResponse>
-(NSInteger)caculatorDay:(NSInteger)year month:(NSInteger)month{
    int day=0;
    switch (month) {
            // case (1,3,5,7,8,10,12):
        case 1:case 3: case 5:case 7:case 8:case 10:case 12:
            day=31;
            break;
            //4,6,9,11
        case 4:case 6:case 9:case 11:
            day=30;
            break;
        case 2:
        {
            if (((year%4==0) && (year%100!=0)) || (year%400==0)) {
                day=29;
            }else{
                day=28;
            }
        }
            break;
        default:
            break;
    }
    return day;
}

-(void)initDate{
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components=[[NSDateComponents alloc]init];
    NSInteger unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour;
    components=[calendar components:unitFlags fromDate:[NSDate date]];
    
    self.startYear=[components year];
    self.selectYear=[components year];
    self.selectMonth=[components month];
    self.selectDay=[components day];
    //修改处
    self.selectHour=[components hour]+1;
    
    self.maxYear=30;
    self.maxDay=[self caculatorDay:[components year] month:[components month]];
    
    [_pickerView selectRow:[components year]-_startYear inComponent:0 animated:YES];
    [_pickerView selectRow:[components month]-1 inComponent:1 animated:YES];
    [_pickerView selectRow:[components day]-1 inComponent:2 animated:YES];
    [_pickerView selectRow:[components hour]+1 inComponent:3 animated:YES];
    
     _showDateTimeLab.text=[NSString stringWithFormat:@"%ld年%ld月%ld日%ld时",(long)_selectYear,(long)_selectMonth,(long)_selectDay,(long)_selectHour];
    [_pickerView reloadAllComponents];
}

#pragma mark <otherResponse>
-(void)clickCoverBtn:(UIButton *)btn{
    [self hideAnimation:0.5];
}

-(void)clickCancelBtn:(UIButton *)btn{
    [self hideAnimation:0.5];
}

-(void)clickConfirmBtn:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showDataPicker:timeString:)]) {
        [self.delegate showDataPicker:[NSString stringWithFormat:@"%ld年%ld月%ld日%ld时",(long)_selectYear,(long)_selectMonth,(long)_selectDay,(long)_selectHour] timeString:[self caculatorTime]];
    }
    [self hideAnimation:0.5];
}

-(void)hideAnimation:(CGFloat)duration{
    
    [UIView animateWithDuration:duration animations:^{
        
        _topView.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height/2.5);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

-(void)showAnimation:(CGFloat)duration{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _topView.frame=CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height/2.5);
    
    [UIView animateWithDuration:duration delay:0.01 usingSpringWithDamping:0.7 initialSpringVelocity:10.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _topView.frame=CGRectMake(0, self.frame.size.height-self.frame.size.height/2.5, self.frame.size.width, self.frame.size.height/2.5);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showDatePicker{
    
    [self showAnimation:0.5];
}


#pragma mark <getter setter>
-(void)setCurrentDate:(NSDate *)currentDate{
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components=[NSDateComponents new];
    NSInteger unitFlags=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour;
    components=[calendar components:unitFlags fromDate:[NSDate date]];
    
    self.selectYear=[components year];
    self.selectMonth=[components month];
    self.selectDay=[components day];
    //修改处
    self.selectHour=[components hour]+1;
    
    
    self.maxYear=30;
    self.maxDay=[self caculatorDay:[components year] month:[components month]];
    
    [_pickerView selectRow:[components year]-_startYear inComponent:0 animated:YES];
    [_pickerView selectRow:[components month]-1 inComponent:1 animated:YES];
    [_pickerView selectRow:[components day]-1 inComponent:2 animated:YES];
    [_pickerView selectRow:[components hour]+1 inComponent:3 animated:YES];

    [_pickerView reloadAllComponents];
     _showDateTimeLab.text=[NSString stringWithFormat:@"%ld年%ld月%ld日%ld时",(long)_selectYear,(long)_selectMonth,(long)_selectDay,(long)_selectHour];
}


-(NSString *)caculatorTime{
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components=[NSDateComponents new];
    [components setValue:_selectYear forComponent:NSCalendarUnitYear];
    [components setValue:_selectMonth forComponent:NSCalendarUnitMonth];
    [components setValue:_selectDay forComponent:NSCalendarUnitDay];
    [components setValue:_selectHour forComponent:NSCalendarUnitHour];
    NSDate *date=[calendar dateFromComponents:components];
    NSString *dateString=[[KBDateFormatter shareInstance]stringFromDate:date];
    return dateString;
}

-(void)setIsDimBackground:(BOOL)isDimBackground{
    _isDimBackground=isDimBackground;
    if (isDimBackground) {
        
    }else{
        _coverBtn.backgroundColor=[UIColor clearColor];
    }
}

-(void)setDimBackgroundAlpha:(CGFloat)dimBackgroundAlpha{
    _coverBtn.alpha=dimBackgroundAlpha;
}

-(void)setDimBackgroundColor:(UIColor *)dimBackgroundColor{
    _coverBtn.backgroundColor=dimBackgroundColor;
}

@end
