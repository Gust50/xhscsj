//
//  KBDropDownMenu.m
//  KBDropDownMenu
//
//  Created by Jose on 16/5/29.
//  Copyright © 2016年 Jose. All rights reserved.
//

#import "KBDropDownMenu.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



@implementation KBIndexPath

-(instancetype)initWihtColumnInstance:(NSInteger)column row:(NSInteger)row{
    if (self==[super init]) {
        _column=column;
        _row=row;
    }
    return self;
}

+(instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row{
    
    return [[super alloc]initWihtColumnInstance:column row:row];
}
@end



@interface KBDropDownMenu()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSInteger currentSelectMenuIndex;
@property(nonatomic,assign)BOOL show;
@property(nonatomic,assign)NSInteger numOfMenu;
@property(nonatomic,assign)CGPoint origin;
@property(nonatomic,strong)UIView *backGroundView;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy)NSArray *arrry;
@property(nonatomic,copy)NSArray *titles;
@property(nonatomic,copy)NSArray *indicators;
@property(nonatomic,copy)NSArray *bgLayers;


@end

@implementation KBDropDownMenu

#pragma mark <lazyLoad>
-(UIColor *)indicatorColor{
    
    if (!_indicatorColor) {
        _indicatorColor=[UIColor orangeColor];
    }
    return _indicatorColor;
}

-(UIColor *)textColor{
    if (!_textColor) {
        _textColor=[UIColor blackColor];
    }
    return _textColor;
}

-(UIColor *)separatorColor{
    if (!_separatorColor) {
        _separatorColor=[UIColor lightGrayColor];
    }
    return _separatorColor;
}


#pragma mark <initWithOrigin>
-(instancetype)initWithOrigin:(CGPoint)origin height:(CGFloat)heigt{
    
    self=[self initWithFrame:CGRectMake(origin.x, origin.y, ScreenWidth, heigt)];
    if(self){
        
        _origin=origin;
        _currentSelectMenuIndex=-1;
        _show=NO;
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(origin.x, origin.y+self.frame.size.height, self.frame.size.width, 0) style:UITableViewStylePlain];
        _tableView.rowHeight=44*AppScale;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
        self.backgroundColor=[UIColor lightGrayColor];
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(menuTap:)];
        [self addGestureRecognizer:tapGesture];
        
        _backGroundView=[[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, ScreenWidth, ScreenHeight)];
        _backGroundView.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque=NO;
        
        UITapGestureRecognizer *backGroundTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backGroundTap:)];
        [_backGroundView addGestureRecognizer:backGroundTap];
        
        UIView *bottomShadow=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, ScreenWidth, 0.5)];
        bottomShadow.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:bottomShadow];
        
        //去除间隙
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    return self;

}

/**
 *  设置背景颜色Layer
 *
 *  @param color    背景颜色
 *  @param position 位置(锚点)
 *
 *  @return         返回图层Layer
 */
-(CALayer *)createBackgroundLayerWithColor:(UIColor *)color
                                  position:(CGPoint)position
{
    CALayer *layer=[CALayer new];
    layer.position=position;
    layer.bounds=CGRectMake(0, 0, self.frame.size.width/self.numOfMenu, self.frame.size.height-1);
    layer.backgroundColor=color.CGColor;
    
    return layer;
}

/**
 *  计算文字的大小
 *
 *  @param string 文本
 *
 *  @return       返回文本的大小
 */
-(CGSize)calculateTitleSizeWithString:(NSString *)string
{

    NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:13*AppScale]};
    CGSize size=[string boundingRectWithSize:CGSizeMake(280, 0)
                                     options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:dict
                                     context:nil].size;
    return size;
}

/**
 *  绘制文本Layer
 *
 *  @param string   文本
 *  @param color    文本颜色
 *  @param position 位置(锚点)
 *
 *  @return         文本Layer
 */
-(CATextLayer *)createTextLayerWithNsstring:(NSString *)string
                                      color:(UIColor *)color
                                    postion:(CGPoint)position
{
    CGSize size=[self calculateTitleSizeWithString:string];
    
    CATextLayer *layer=[CATextLayer new];
    CGFloat sizeWidth=(size.width<(self.frame.size.width/_numOfMenu)-25) ? size.width :self.frame.size.width/_numOfMenu-25;
    
    layer.bounds=CGRectMake(0, 0, sizeWidth, size.height);
    layer.string=string;
    layer.fontSize=13*AppScale;
    layer.alignmentMode=kCAAlignmentCenter;
    layer.foregroundColor=color.CGColor;
    layer.contentsScale=[[UIScreen mainScreen] scale];
    layer.position=position;
    
    return layer;
}

/**
 *  绘制提示图标Layer
 *
 *  @param color     颜色
 *  @param position  位置(锚点)
 *
 *  @return          返回图标Layer
 */
-(CAShapeLayer *)createIndicatorWithColor:(UIColor *)color
                                 position:(CGPoint)position
{
    CAShapeLayer *layer=[CAShapeLayer new];
    UIBezierPath *path=[UIBezierPath new];
    
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path=path.CGPath;
    layer.lineWidth=1.0;
    layer.fillColor=color.CGColor;
    
    CGPathRef bound=CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds=CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position=position;
    
    return layer;
}

/**
 *  绘制竖线
 *
 *  @param color    线条颜色
 *  @param position 位置
 *
 *  @return         返回线条Layer
 */
-(CAShapeLayer *)createVerticalBarWithColor:(UIColor *)color
                                   position:(CGPoint)position
{
    
    CAShapeLayer *layer=[CAShapeLayer new];
    UIBezierPath *path=[UIBezierPath new];
    
    
   
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 20)];
    [path closePath];
    
    layer.path=path.CGPath;
    layer.lineWidth=1.0;
    layer.strokeColor=color.CGColor;
    
    CGPathRef bound=CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds=CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position=position;
    
    return layer;

}


#pragma mark <other Response>
-(void)menuTap:(UITapGestureRecognizer *)getsture{
    CGPoint touchPoint=[getsture locationInView:self];
    NSInteger tapIndex=touchPoint.x/(self.frame.size.width/_numOfMenu);
    
    //不是当前选中状态
    for (int i=0; i<_numOfMenu; i++) {
        if (i != tapIndex) {
            [self animatedIndicator:_indicators[i] forward:NO completion:^{
                [self animateTitle:_titles[i] show:NO completion:^{
                    
                }];
            }];
            [(CALayer *)self.bgLayers[i] setBackgroundColor:[UIColor whiteColor].CGColor];
        }
    }
    
    //选中当前并且显示
    if (tapIndex==_currentSelectMenuIndex && _show) {
        [self animateIndicator:_indicators[_currentSelectMenuIndex] backGround:_backGroundView tableView:_tableView title:_titles[_currentSelectMenuIndex] forward:NO completion:^{
            
            _currentSelectMenuIndex=tapIndex;
            _show=NO;
        }];
    }else{
        _currentSelectMenuIndex=tapIndex;
        [_tableView reloadData];
        [self animateIndicator:_indicators[tapIndex] backGround:_backGroundView tableView:_tableView title:_titles[tapIndex] forward:YES completion:^{
            _show=YES;
        }];
        [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0].CGColor];
    }
    
}


-(void)backGroundTap:(UITapGestureRecognizer *)gesture{
    [self animateIndicator:_indicators[_currentSelectMenuIndex] backGround:_backGroundView tableView:_tableView title:_titles[_currentSelectMenuIndex] forward:NO completion:^{
        _show=NO;
    }];
    [(CALayer *)self.bgLayers[_currentSelectMenuIndex]setBackgroundColor:[UIColor whiteColor].CGColor];
}

/**
 *  创建指示器的动画
 *
 *  @param indicator  指示器图层
 *  @param forward    方向(down or up)
 *  @param completion 回调
 */
-(void)animatedIndicator:(CAShapeLayer *)indicator
                 forward:(BOOL)forward
              completion:(void(^)())completion
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim=[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values=forward ? @[@0,@(M_PI)] : @[@(M_PI),@0];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    }else{
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    completion();
}


/**
 *  菜单标题动画
 *
 *  @param title      菜单文本
 *  @param show       是否显示
 *  @param completion 回调
 */
-(void)animateTitle:(CATextLayer *)title
               show:(BOOL)show
         completion:(void(^)())completion
{
    CGSize size=[self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth=(size.width<(self.frame.size.width/_numOfMenu)-25) ? size.width :self.frame.size.width/_numOfMenu-25;
    title.bounds=CGRectMake(0, 0, sizeWidth, size.height);
    completion();
}


/**
 *  创建背景动画
 *
 *  @param view       背景图
 *  @param show       是否显示
 *  @param completion 回调
 */
-(void)animateBackGroundView:(UIView *)view
                        show:(BOOL)show
                   competion:(void(^)())completion
{
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor=[UIColor colorWithWhite:0.0 alpha:0.0];
        }completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    completion();
}

/**
 *  创建TableView的动画
 *
 *  @param tableView  tableView
 *  @param show       是否显示
 *  @param completion 回调
 */
-(void)animateTableView:(UITableView *)tableView
                   show:(BOOL)show
             completion:(void(^)())completion
{
    if (show) {
        tableView.frame=CGRectMake(self.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 0);
        [self.superview addSubview:tableView];
        
        //计算高度
        CGFloat tableViewHeight=([tableView numberOfRowsInSection:0]>5) ? (5*tableView.rowHeight) : ([tableView numberOfRowsInSection:0]*tableView.rowHeight);
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame=CGRectMake(self.origin.x, self.origin.y+self.frame.size.height, self.frame.size.width, tableViewHeight);
        }];
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame=CGRectMake(self.origin.x, self.frame.origin.y+self.frame.size.height, self.frame.size.width, 0);
        }completion:^(BOOL finished) {
            [tableView removeFromSuperview];
        }];
    }
    completion();
}

/**
 *  menu菜单的动画
 *
 *  @param indicator  指示器
 *  @param backGround 背景
 *  @param tableView  tableView
 *  @param title      菜单标题
 *  @param forward    是否显示
 *  @param completion 回调
 */
-(void)animateIndicator:(CAShapeLayer *)indicator
             backGround:(UIView *)backGround
              tableView:(UITableView *)tableView
                  title:(CATextLayer *)title
                forward:(BOOL)forward
             completion:(void(^)())completion
{
 
    [self animatedIndicator:indicator forward:forward completion:^{
        [self animateTitle:title show:forward completion:^{
            [self animateBackGroundView:backGround show:forward competion:^{
                [self animateTableView:tableView show:forward completion:^{
                    
                }];
            }];
        }];
    }];
    completion();
}



#pragma mark <setter getter>
-(void)setDataSource:(id<KBDropDownMenuDataSource>)dataSource{
    _dataSource=dataSource;
    
    //返回有多少个菜单选项
    if ([_dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        _numOfMenu=[_dataSource numberOfColumnsInMenu:self];
    }else{
        _numOfMenu=1;
    }
    
    CGFloat textLayerMargin=self.frame.size.width/(_numOfMenu *2);
    CGFloat bgLayerMargin=self.frame.size.width/_numOfMenu;
    
    NSMutableArray *tempTitles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempIndicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempBgLayers = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    
    for (int i=0; i<_numOfMenu; i++) {
        
        //对应每一列背景
        CGPoint bgLayerPosition=CGPointMake((i+0.5)*bgLayerMargin, self.frame.size.height/2);
        CALayer *bgLayer=[self createBackgroundLayerWithColor:[UIColor whiteColor] position:bgLayerPosition];
        [self.layer addSublayer:bgLayer];
        [tempBgLayers addObject:bgLayer];
        
        CGPoint titlePosition=CGPointMake((i*2+1)*textLayerMargin, self.frame.size.height/2);
        NSString *titleString=[_dataSource menu:self titleForRowAtIndexPath:[KBIndexPath initWithColumn:i row:0]];
        CATextLayer *title=[self createTextLayerWithNsstring:titleString color:self.textColor postion:titlePosition];
        [self.layer addSublayer:title];
        [tempTitles addObject:title];
        
        CAShapeLayer *indicator=[self createIndicatorWithColor:self.indicatorColor position:CGPointMake(titlePosition.x+title.bounds.size.width/2+8, self.frame.size.height/2)];
        [self.layer addSublayer:indicator];
        [tempIndicators addObject:indicator];
        
        CAShapeLayer *verticalBar=[self createVerticalBarWithColor:[UIColor grayColor] position:CGPointMake(i*bgLayerMargin-1, self.frame.size.height/2)];
        [self.layer addSublayer:verticalBar];
        
    }
    
    _titles=[tempTitles copy];
    _indicators=[tempIndicators copy];
    _bgLayers=[tempBgLayers copy];
}


#pragma mark <dataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInColumn:)]) {
        return [self.dataSource menu:self numberOfRowsInColumn:self.currentSelectMenuIndex];
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if ([self.dataSource respondsToSelector:@selector(menu:titleForRowAtIndexPath:)]) {
        cell.textLabel.text=[self.dataSource menu:self titleForRowAtIndexPath:[KBIndexPath initWithColumn:self.currentSelectMenuIndex row:indexPath.row]];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.font=[UIFont systemFontOfSize:13*AppScale];
    cell.separatorInset=UIEdgeInsetsZero;
    
    if ([cell.textLabel.text isEqualToString:[(CATextLayer *)[_titles objectAtIndex:_currentSelectMenuIndex]string]]) {
        cell.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1.0];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44*AppScale;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self configMenuWithSelectRow:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
        
        [self.delegate menu:self didSelectRowAtIndexPath:[KBIndexPath initWithColumn:self.currentSelectMenuIndex row:indexPath.row]];
    }
}

-(void)configMenuWithSelectRow:(NSInteger)row{
    CATextLayer *title=(CATextLayer *)_titles[_currentSelectMenuIndex];
    title.string=[self.dataSource menu:self titleForRowAtIndexPath:[KBIndexPath initWithColumn:self.currentSelectMenuIndex row:row]];
    
    [self animateIndicator:_indicators[_currentSelectMenuIndex] backGround:_backGroundView tableView:_tableView title:_titles[_currentSelectMenuIndex] forward:NO completion:^{
        _show=NO;
    }];
    [(CATextLayer *)self.bgLayers[_currentSelectMenuIndex]setBackgroundColor:[UIColor whiteColor].CGColor];
    CAShapeLayer *indicator=(CAShapeLayer *)_indicators[_currentSelectMenuIndex];
    indicator.position=CGPointMake(title.position.x+title.frame.size.width/2+8, title.position.y);
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }

}
@end
