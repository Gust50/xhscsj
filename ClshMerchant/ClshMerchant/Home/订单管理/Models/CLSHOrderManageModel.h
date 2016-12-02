//
//  CLSHOrderManageModel.h
//  ClshMerchant
//
//  Created by arom on 16/8/4.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import <Foundation/Foundation.h>

@interface CLSHOrderManageModel : NSObject

@property (nonatomic,assign)NSInteger pageNumber;       ///<页数
@property (nonatomic,assign)NSInteger pageSize;         ///<一页几条数据
@property (nonatomic,assign)NSInteger totalPages;       ///<总的页数
@property (nonatomic,strong)NSArray * orders;           ///<订单列表

/**
 *  获取订单列表
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchOrderData:(id)params
              callBack:(void(^)(BOOL isSuccess,id result))completion;

@end


@interface CLSHOderListModel : NSObject

@property (nonatomic,copy)NSString * orderId;           ///<订单id
@property (nonatomic,copy)NSString * sn;                ///<订单号
@property (nonatomic,assign)CGFloat orderAmount;        ///<订单总额
@property (nonatomic,copy)NSString * createTime;        ///<订单创建时间
@property (nonatomic,copy)NSString * status;            ///<订单状态
@property (nonatomic,strong)NSArray * orderItems;       ///<订单商品数组

@end


@interface CLSHOrderModel : NSObject

@property (nonatomic,copy)NSString * image;             ///<缩略图
@property (nonatomic,assign)NSInteger quantity;         ///<数量
@property (nonatomic,assign)CGFloat price;              ///<价格
@property (nonatomic,copy)NSString * goodsName;         ///<商品名称
@property (nonatomic,copy)NSString * specifications;     ///<规格

@end


@class CLSHOrderDetailInfoModel;
@interface CLSHOrderDetailModel : NSObject
/**
 *  订单详情
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchOrderDetailData:(id)params
                    callBack:(void (^) (BOOL isSuccess, id result))completion;

@property (nonatomic,strong)CLSHOrderDetailInfoModel * order;


@end


@interface CLSHOrderDetailInfoModel : NSObject
//收货地址
@property (nonatomic,copy)NSString * address;            ///<收货地址
@property (nonatomic,copy)NSString * consignee;          ///<名字
@property (nonatomic,copy)NSString * phone;              ///<电话

//订单信息
@property (nonatomic,copy)NSString * orderId;            ///<订单id
@property (nonatomic,copy)NSString * createTime;         ///<下单时间
@property (nonatomic,copy)NSString * sn;                 ///<订单号
@property (nonatomic,assign)BOOL isDelivery;             ///<是否配送
@property (nonatomic,copy)NSString * status;             ///<订单状态

//支付明细
@property (nonatomic,copy)NSString * paymentMethodName;  ///<支付方式
@property (nonatomic,assign)CGFloat paymentAmount;       ///<支付总额
@property (nonatomic,assign)CGFloat freight;             ///<运费

//商品清单
@property (nonatomic,strong)NSArray * orderItems;        ///<商品清单

@end



@interface CLSHOrderDetailGoodsListModel : NSObject

@property (nonatomic,copy)NSString * goodsId;            ///<商品id
@property (nonatomic,copy)NSString * goodsName;          ///<商品名称
@property (nonatomic,assign)CGFloat price;               ///<商品价格
@property (nonatomic,assign)NSInteger quantity;          ///<商品数量
@property (nonatomic,copy)NSString * image;              ///<商品图片
@property (nonatomic,strong)NSArray * specifications;    ///<规格数组

@end


@interface CLSHDeliveryOrderModel : NSObject

/**
 *  配送
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchDeliveryOrderData:(id)params
                    callBack:(void (^) (BOOL isSuccess, id result))completion;

@end



@interface CLSHCancelOrderModel : NSObject

/**
 *  取消订单
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchCancelOrderData:(id)params
                    callBack:(void (^)(BOOL isSuccess, id result))completion;

@end


@interface CLSHCommentDataModel : NSObject

@property (nonatomic,copy)NSString * orderCreateDate;              ///<创建时间
@property (nonatomic,copy)NSString * orderSn;                      ///<订单编号
@property (nonatomic,copy)NSString * shippingMethodName;           ///<配送方式
@property (nonatomic,copy)NSString * reviewContent;                ///<评论内容
@property (nonatomic,copy)NSString * memberName;                   ///<评论者名称
@property (nonatomic,copy)NSString * reviewCreateDate;             ///<评论时间
@property (nonatomic,copy)NSString * memberAvatar;                 ///<评论头像
@property (nonatomic,strong)NSArray * reviewImages;                ///<评论图片
@property (nonatomic,assign)CGFloat score;                         ///<评分
@property (nonatomic,copy)NSString * reviewId;                     ///<评论id

@property (nonatomic,strong)NSArray * parentReview;               ///<评论回复

/**
 *  评论详情
 *
 *  @param params     参数
 *  @param completion 返回数据
 */
- (void)fetchCommentData:(id)params
                   callBack:(void (^)(BOOL isSuccess, id result))completion;

@end



@interface CLSHAnswerCommentDataModel : NSObject

@property (nonatomic,copy)NSString * Content;                      ///<回复内容
@property (nonatomic,copy)NSString * name;                         ///<回复者名称
@property (nonatomic,copy)NSString * createDat;                    ///<回复时间
@property (nonatomic,copy)NSString * avatar;                       ///<头像

@end


@interface CLSHAnswerCommentBehaviorModel : NSObject

- (void)fetchAnswerCommentBehaviorData:(id)params
                 callBack:(void (^)(BOOL isSuccess,id result))completion;

@end






