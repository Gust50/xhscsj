//
//  KBImageToolViewController.m
//  KBCustomPhoto
//
//  Created by kobe on 16/4/22.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBImageToolViewController.h"
/** 屏幕尺寸 */
#define  SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define  SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)


@interface KBImageToolViewController ()

/** 原始图片的大小 */
@property(nonatomic,strong)UIImage *originImage;
@property(nonatomic,strong)UIImage *editedImage;
/** 显示图片 */
@property(nonatomic,strong)UIImageView *showImageView;
@property(nonatomic,strong)UIView *overlayView;
@property(nonatomic,strong)UIView *ratioView;

@property(nonatomic,assign)CGRect oldFrame;
@property(nonatomic,assign)CGRect largeFrame;
/** 图片的缩放比 */
@property(nonatomic,assign)CGFloat scaleRatio;
@property(nonatomic,assign)CGRect latestFrame;
@end

@implementation KBImageToolViewController


//初始化需要裁剪的图片
-(id)initWithImage:(UIImage *)originImage cropFrame:(CGRect)cropFrame scaleRatio:(NSInteger)scaleRatio{
    self=[super init];
    if (self) {
        //裁剪的Frame
        self.cropFrame=cropFrame;
        //裁剪的比例
        self.scaleRatio=scaleRatio;
        //需要裁剪的图
        self.originImage=originImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initButton];
    // Do any additional setup after loading the view.
}

-(void)initView{
    //设置图片
    self.showImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //设置多指触摸
    [self.showImageView setMultipleTouchEnabled:YES];
    //设置可交互
    [self.showImageView setUserInteractionEnabled:YES];
    [self.showImageView setImage:self.originImage];
    
    
    //图片自适应屏幕
    CGFloat showImageViewW=self.cropFrame.size.width;
    CGFloat showImageViewH=self.originImage.size.height*(showImageViewW/self.originImage.size.width);
    CGFloat showImageX=self.cropFrame.origin.x+(self.cropFrame.size.width-showImageViewW)/2;
    CGFloat showImageY=self.cropFrame.origin.y+(self.cropFrame.size.height-showImageViewH)/2;
    //计算图片的尺寸
    self.oldFrame=CGRectMake(showImageX, showImageY, showImageViewW, showImageViewH);
    //保存图片的尺寸
    self.latestFrame=self.oldFrame;
    //设置显示图片的尺寸
    self.showImageView.frame=self.oldFrame;
    //最大的尺寸
    self.largeFrame=CGRectMake(0, 0, self.scaleRatio*self.oldFrame.size.width, self.scaleRatio*self.oldFrame.size.height);
    [self.view addSubview:self.showImageView];
    
    //背景图层
    self.overlayView=[[UIView alloc]initWithFrame:self.view.bounds];
    self.overlayView.alpha=0.5f;
    self.overlayView.backgroundColor=[UIColor blackColor];
    self.overlayView.userInteractionEnabled=NO;
    self.overlayView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.overlayView];
    
    //画出裁剪的边框
    self.ratioView=[[UIView alloc]initWithFrame:self.cropFrame];
    self.ratioView.layer.borderColor=[UIColor yellowColor].CGColor;
    self.ratioView.layer.borderWidth=1;
    self.ratioView.autoresizingMask=UIViewAutoresizingNone;
    [self.view addSubview:self.ratioView];
    
    //添加手势
    UIPinchGestureRecognizer *pin=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGesture:)];
    [self.view addGestureRecognizer:pin];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
    [self overlayClipping];
}

-(void)initButton{
    //取消
    UIButton *cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50.0f, 100, 50)];
    cancelButton.backgroundColor=[UIColor blackColor];
    cancelButton.titleLabel.textColor=[UIColor whiteColor];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    //确定
    UIButton *confirmButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100.0f, self.view.frame.size.height-50.0f, 100, 50)];
    confirmButton.backgroundColor=[UIColor blackColor];
    confirmButton.titleLabel.textColor=[UIColor whiteColor];
    [confirmButton setTitle:@"OK" forState:UIControlStateNormal];
    [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    
}
-(void)cancel:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageCropperCancel:)]) {
        [self.delegate imageCropperCancel:self];
    }
}

-(void)confirm:(UIButton *)button{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(KBImageToolViewControllerDelegate)]) {
        [self.delegate imageCropper:self didFinished:[self getImage]];
    }
}

-(void)overlayClipping{
    CAShapeLayer *maskLayer=[[CAShapeLayer alloc]init];
    //创建图像了路径句柄
    CGMutablePathRef path=CGPathCreateMutable();
    //left
    CGPathAddRect(path, nil, CGRectMake(0, 0, self.ratioView.frame.origin.x, self.overlayView.frame.size.height));
    //right
    CGPathAddRect(path, nil, CGRectMake(self.ratioView.frame.size.width+self.ratioView.frame.origin.x, 0, self.overlayView.frame.size.width-self.ratioView.frame.size.width-self.ratioView.frame.origin.x, self.overlayView.frame.size.height));
    //top
    CGPathAddRect(path, nil, CGRectMake(0, 0, self.overlayView.frame.size.width, self.ratioView.frame.origin.y));
    //bottom
    CGPathAddRect(path, nil, CGRectMake(0, self.ratioView.frame.origin.y+self.ratioView.frame.size.height, self.overlayView.frame.size.width, self.overlayView.frame.size.height-self.ratioView.frame.origin.y+self.ratioView.frame.size.height));
    maskLayer.path=path;
    self.overlayView.layer.mask=maskLayer;
    CGPathRelease(path);
}

//放大或者缩小
-(void)pinchGesture:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    UIView *pinch=self.showImageView;
    if (pinchGestureRecognizer.state==UIGestureRecognizerStateBegan||pinchGestureRecognizer.state==UIGestureRecognizerStateChanged) {
        pinch.transform=CGAffineTransformScale(pinch.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale=1;
    }else if (pinchGestureRecognizer.state==UIGestureRecognizerStateEnded){
        CGRect newFrame=self.showImageView.frame;
        newFrame=[self handleScaleOverflow:newFrame];
        newFrame=[self handleBorderOverflow:newFrame];
        [UIView animateWithDuration:0.3 animations:^{
            self.showImageView.frame=newFrame;
            self.latestFrame=newFrame;
        }];
        
    }
    
}

//拖动手势
-(void)panGesture:(UIPanGestureRecognizer *)panGestureRecognizer{
    UIView *pan=self.showImageView;
    if (panGestureRecognizer.state==UIGestureRecognizerStateBegan||panGestureRecognizer.state==UIGestureRecognizerStateChanged) {
        CGFloat absCenterX=self.cropFrame.origin.x+self.cropFrame.size.width/2;
        CGFloat absCenterY=self.cropFrame.origin.y+self.cropFrame.size.height/2;
        CGFloat scaleRatio=self.showImageView.frame.size.width/self.cropFrame.size.width;
        CGFloat acceleratorX=1-ABS(absCenterX-pan.center.x)/(scaleRatio*absCenterX);
        CGFloat acceleratorY=1-ABS(absCenterY-pan.center.y)/(scaleRatio*absCenterY);
        CGPoint translation=[panGestureRecognizer translationInView:pan.superview];
        [pan setCenter:(CGPoint){pan.center.x+translation.x*acceleratorX,pan.center.y+translation.y*acceleratorY}];
        [panGestureRecognizer setTranslation:CGPointZero inView:pan.superview];
    }else if (panGestureRecognizer.state==UIGestureRecognizerStateEnded){
        CGRect newFrame=self.showImageView.frame;
        newFrame=[self handleBorderOverflow:newFrame];
        [UIView animateWithDuration:0.3 animations:^{
            self.showImageView.frame=newFrame;
            self.latestFrame=newFrame;
        }];
    }
}

//判断是否超过指定的Frame
-(CGRect)handleScaleOverflow:(CGRect)newFrame{
    CGPoint oriCenter=CGPointMake(newFrame.origin.x+newFrame.size.width/2, newFrame.origin.y+newFrame.size.height/2);
    if (newFrame.size.width<self.oldFrame.size.width) {
        newFrame=self.oldFrame;
    }
    if (newFrame.size.width>self.largeFrame.size.width) {
        newFrame=self.largeFrame;
    }
    newFrame.origin.x=oriCenter.x-newFrame.size.width/2;
    newFrame.origin.y=oriCenter.y-newFrame.size.height/2;
    return newFrame;
}

//矩形边处理
-(CGRect)handleBorderOverflow:(CGRect)newFrame{
    //水平方向
    if (newFrame.origin.x>self.cropFrame.origin.x) {
        newFrame.origin.x=self.cropFrame.origin.x;
    }
    if (CGRectGetMaxX(newFrame)<self.cropFrame.size.width) {
        //        newFrame.origin.x=self.cropFrame.origin.x+self.cropFrame.size.width-newFrame.size.width;
        newFrame.origin.x=self.cropFrame.size.width-newFrame.size.width;
        
    }
    //垂直方向
    if (newFrame.origin.y>self.cropFrame.origin.y) {
        newFrame.origin.y=self.cropFrame.origin.y;
    }
    if (CGRectGetMaxY(newFrame)<self.cropFrame.origin.y+self.cropFrame.size.height) {
        newFrame.origin.y=self.cropFrame.origin.y+self.cropFrame.size.height-newFrame.size.height;
    }
    
    if (self.showImageView.frame.size.width>self.showImageView.frame.size.height && newFrame.size.height<=self.cropFrame.size.height) {
        newFrame.origin.y=self.cropFrame.origin.y+(self.cropFrame.size.height-newFrame.size.height)/2;
    }
    return newFrame;
}

//获取图片
-(UIImage *)getImage{
    //获取需要裁剪的大小
    CGRect squareFrame=self.cropFrame;
    //获取缩放后的比率
    CGFloat scale_Ratio=self.latestFrame.size.width/self.originImage.size.width;
    
    //计算需要裁剪的图片位置
    CGFloat x=(squareFrame.origin.x-self.latestFrame.origin.x)/scale_Ratio;
    CGFloat y=(squareFrame.origin.y-self.latestFrame.origin.y)/scale_Ratio;
    CGFloat w=squareFrame.size.width/scale_Ratio;
    CGFloat h=squareFrame.size.width/scale_Ratio;
    if (self.latestFrame.size.width<self.cropFrame.size.width) {
        CGFloat newW=self.originImage.size.width;
        CGFloat newH=newW*(self.cropFrame.size.height/self.cropFrame.size.width);
        x=0;
        y=y+(y-newH)/2;
        w=newH;
        h=newH;
    }
    if (self.latestFrame.size.height<self.cropFrame.size.height) {
        CGFloat newH=self.originImage.size.height;
        CGFloat newW=newH*(self.cropFrame.size.width/self.cropFrame.size.height);
        x=x+(w-newW)/2;
        y=0;
        w=newH;
        h=newH;
    }
    
    CGRect myImage=CGRectMake(x, y, w, h);
    CGImageRef imageRef=self.originImage.CGImage;
    CGImageRef subImageRef=CGImageCreateWithImageInRect(imageRef, myImage);
    CGSize size;
    size.width=myImage.size.width;
    size.height=myImage.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImage, subImageRef);
    UIImage *smallImage=[UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    //保存相册到手机中
    UIImageWriteToSavedPhotosAlbum(smallImage, self, nil, nil);
    return smallImage;
}


@end
