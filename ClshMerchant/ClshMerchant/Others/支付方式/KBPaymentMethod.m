//
//  KBPaymentMethod.m
//  ClshUser
//
//  Created by kobe on 16/6/28.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#import "KBPaymentMethod.h"
#import "AlixPayOrder.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import <WXApi.h>

@interface KBPaymentMethod ()


@end

@implementation KBPaymentMethod

+(void)AlipayMethod:(NSDictionary *)params{
    
    KBAlipayModel *alipayModel=[[KBAlipayModel alloc]init];
    [alipayModel fetchAlipayData:params callBack:^(BOOL isSuccess, id result) {
        
        if (isSuccess)
        {
            NSDictionary *dic = [NSObject returnJson:result][@"parameterMap"];
            AlixPayOrder *aliOrder = [[AlixPayOrder alloc] init];
            //商户ID
            aliOrder.partner = dic[@"partner"];
            //账号ID
            aliOrder.seller = dic[@"seller_id"];
            //设置订单号
            aliOrder.tradeNO = dic[@"out_trade_no"];
            //商品名称
            aliOrder.productName = dic[@"subject"];
            //商品描述
            aliOrder.productDescription = dic[@"body"];
            //商品数量
            aliOrder.amount = dic[@"total_fee"];
            aliOrder.serviceName =dic[@"service"];
            //支付类型
            aliOrder.paymentType = dic[@"payment_type"];
            //utf-8
            aliOrder.inputCharset =dic[@"_input_charset"];
            //回调URL
            aliOrder.notifyURL = dic[@"notify_url"];
            //将订单信息拼接成字符串
            NSString *orderSpec = [aliOrder description];
            //加密
//            NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALlmDs1QoQlY18xLTp51/sw72twckGDcT5KUX4ynKM69SmAUoa5YkhXDXJzeZV9AQjLVRRdsWzLbwnBSDaXE1Llp8GTQDlxbQ9oziFUiDdUCIUc3LgnDV4T8nj/BLTUSXuTrAj8UFcP8oRHxHjWdJGEna4+1kgWozUOFDn1hvEFLAgMBAAECgYAPDMHW2Ny5rYSXCOXw5xMv8QvrIkZ2Fmw/MdwvxsIBRkxrUEFvrbDuI1W5RjRkbwrwpW9eX2Vn038NLxv8gOXjo98E2YJrQLyALHbYtHJ9HE+jeeo3nMzNZu+weKvyHONqhmlss7O78yX6q2vy9QA4PvEjcd05heDCZaEnLQVtwQJBANswphoCMxa32hS86DH0JvHxqHn1BWc63fa7xuXklS9p6DY7ePTub/JFcQTqoOk4YIo6eX+trxuBMosceB/ms68CQQDYiKkgt6ARvmMCWsSNAuRmkvNbKxW6/DWqBMMjDyGUKJmuz9z5BXflTwej5SBmAbFaJESlf7Mtt3Uk4+4/TYclAkAjRXbVJJl4BGnRgHyU3UcPE+YaifUuoWhqddkR0XC4SoCViYhzUZMuF0KSmfb+0JWoaLR4eUh+UpIBlLk32PX9AkEAy9fbX/F9vzZ7/rt0TUtruSSd9DWbP2wvGN9i1J5p/hA6nVcRr1x2gmjjyGbrGRx+2V1LQoH1LBSJMzFgGDfkAQJBAK6Cz0dVGmd3q2ENhS/od4nLaV2SVlwsJHbSfzO+gyDMYmEtRpSlmxIvqe7WMheBAcZRJTekOeQH6NE3/lGtvJ0=";
            NSString *privateKey=[NSObject returnJson:result][@"privateKey"];
            
            id<DataSigner> signer = CreateRSADataSigner(privateKey);
            NSString *signedString = [signer signString:orderSpec];
            NSString*    orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                                        orderSpec, signedString, @"RSA"];
            //支付宝支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"culiangApp" callback:^(NSDictionary *resultDic) {
                if ([resultDic[@"resultStatus"] intValue]==9000){
                    //跳转我的订单
//                    [weakSelf alipaySuc];
                    
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"AlipaySuccess" object:nil userInfo:nil];
                    
                }else{
                    [MBProgressHUD showError:@"支付失败"];
                }
            }];

        }else
        {
            
        }
    }];
}

+(void)WechatMethod:(NSDictionary *)params{
    
    KBWechatPayModel *wechatModel=[[KBWechatPayModel alloc]init];
    [wechatModel fetchWechatPayData:params callBack:^(BOOL isSuccess, id result) {
       
        if (isSuccess)
        {

            //wx9a3035af80ac5230
            NSDictionary *wechat = [NSObject returnJson:result][@"parameterMap"];
            PayReq *request = [[PayReq alloc] init];
            //商家向财付通申请的商家id
            request.partnerId = wechat[@"partnerid"];
            //预支付订单
            request.prepayId= wechat[@"prepayid"];
            //商家根据财付通文档填写的数据和签名
            request.package = wechat[@"package"];
            //随机串，防重发
            request.nonceStr= wechat[@"noncestr"];
            //时间戳，防重发
            request.timeStamp =[wechat[@"timestamp"]intValue];
            //商家根据微信开放平台文档对数据做的签名
            request.sign= wechat[@"sign"];
            
            
            NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",request.openID,request.partnerId,request.prepayId,request.nonceStr,(long)request.timeStamp,request.package,request.sign );
            
            if ([WXApi sendReq:request]) {
                
                 NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",request.openID,request.partnerId,request.prepayId,request.nonceStr,(long)request.timeStamp,request.package,request.sign );
                
            }else{
                [MBProgressHUD showError:@"您没有安装微信支付"];
            }
            
        }else
        {
            
            
        }
    }];
    
}

+(void)BalanceMethod:(NSDictionary *)params{
 
    KBBalancePayModel *balancePayModel=[[KBBalancePayModel alloc]init];
    [balancePayModel fetchBalancePayData:params callBack:^(BOOL isSuccess, id result) {
        
    }];
    
}
@end






@implementation KBAlipayModel
-(void)fetchAlipayData:(NSDictionary *)params
              callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_AlipayPayment];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,baseModel.content);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];

}
@end



@implementation KBWechatPayModel

-(void)fetchWechatPayData:(NSDictionary *)params
                 callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_WechatPayment];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        
        
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            completion(YES,baseModel.content);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        
        completion(NO,ServerError);
    }];
}
@end




@implementation KBBalancePayModel
-(void)fetchBalancePayData:(NSDictionary *)params
                  callBack:(void (^)(BOOL, id))completion
{
    NSString *Url=[NSString stringWithFormat:@"%@%@",URL_Header,Home_BalancePayment];
    
    NSMutableDictionary *needParams=[NSMutableDictionary dictionaryWithDictionary:[[FetchAppPublicKeyModel shareAppPublicKeyManager] fetchEncryptParams]];
    [needParams addEntriesFromDictionary:params];
    
    [[KBHttpTool shareKBHttpToolManager]post:Url params:needParams success:^(id response) {
        BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:response];
        if (baseModel.code==ResponseSuccess) {
            NSMutableDictionary *balanceInfo=[NSMutableDictionary dictionary];
            balanceInfo[@"Success"]=@(YES);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"BalancePay" object:nil userInfo:balanceInfo];
            completion(YES,baseModel.content);
        }else{
            //错误信息
            completion(NO,baseModel.message);
        }
    } failure:^(NSError *error) {
        completion(NO,ServerError);
    }];
}

@end

