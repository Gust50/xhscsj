//
//  KBDropDownMenu.h
//  KBDropDownMenu
//
//  Created by Jose on 16/5/29.
//  Copyright © 2016年 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KBIndexPath : NSObject
/** 列 */
@property(nonatomic,assign)NSInteger column;
/** 行 */
@property(nonatomic,assign)NSInteger row;


/** 初始化每行每列(实例方法) */
-(instancetype)initWihtColumnInstance:(NSInteger)column row:(NSInteger)row;
/** 初始化没行没列(类方法) */
+(instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;
@end



@class KBDropDownMenu;
/** 数据源 */
@protocol KBDropDownMenuDataSource <NSObject>

@required
-(NSInteger)menu:(KBDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;
-(NSString *)menu:(KBDropDownMenu *)menu titleForRowAtIndexPath:(KBIndexPath *)indexPath;
@optional
/** 默认只有一列 */
-(NSInteger)numberOfColumnsInMenu:(KBDropDownMenu *)menu;

@end

/** 代理方法 */
@protocol KBDropDownMenuDelegate <NSObject>

@optional
-(void)menu:(KBDropDownMenu *)menu didSelectRowAtIndexPath:(KBIndexPath *)indexPath;
@end

@interface KBDropDownMenu : UIView

/** 指示图标的颜色 */
@property(nonatomic,strong)UIColor *indicatorColor;
/** 文本的颜色 */
@property(nonatomic,strong)UIColor *textColor;
/** 分割线的颜色 */
@property(nonatomic,strong)UIColor *separatorColor;

@property(nonatomic,weak)id<KBDropDownMenuDataSource>dataSource;
@property(nonatomic,weak)id<KBDropDownMenuDelegate>delegate;

/** 初始化菜单的大小 */
-(instancetype)initWithOrigin:(CGPoint)origin height:(CGFloat)heigt;
-(NSString *)titleForRowAtIndexPath:(KBIndexPath *)indexPath;

@end
