//
//  UrlHeader.h
//  ClshMerchant
//
//  Created by kobe on 16/7/25.
//  Copyright © 2016年 kobe. All rights reserved.
//
/*
 * Copyright 2016-2026 xtiger.cn. All rights reserved.
 * Support: http://www.xtiger.cn
 * License: http://www.xtiger.cn/license
 */


#ifndef UrlHeader_h
#define UrlHeader_h

#define Release
#ifdef  Release
#define URL_Header  @"http://api.culsh.cn/"
#else
#define URL_Header  @"http://120.25.231.144:8080/"
#endif

#define LoginRelease
//#ifdef LoginRelease
//#define URL_Login @"http://api.culsh.cn/culsh/"
//#else
//#define URL_Login @"http://120.25.231.144:8080/"
//#endif
//===========================================URL=============================================

#define App_PublicKey              @"api/getPublicKey.htm"                     ///<获取公钥
#define Home_Data                  @"api/shopAdmin/shop/index.htm"             ///<首页
#define Home_UploadGoods           @"api/shopAdmin/goods/add.htm"              ///<上传我的商品
#define App_UpLoadImages           @"api/upload/fileUpload.htm"                ///<上传图片
#define App_Logout                 @"api/member/logout.htm"                    ///<用户注销
#define Home_shopList              @"api/shopAdmin/goods/shopGoodsList.htm"    ///<商品列表
#define Home_editShop              @"api/shopAdmin/goods/editGoods.htm"        ///<编辑商品
#define Home_editShopDetail        @"api/shopAdmin/goods/goodsDetails.htm"     ///<商品详情
#define Home_OnSaleShop            @"api/shopAdmin/goods/upTheShelf.htm"       ///<商品上架
#define Home_SaleOutShop           @"api/shopAdmin/goods/offTheShelf.htm"        ///<商品下架
#define Home_DeleteShop            @"api/shopAdmin/goods/delete.htm"            ///<删除商品
#define Home_discount              @"api/discountRate/selected.htm"             ///<折扣
#define Home_updateDiscount        @"api/shopAdmin/shop/updateDiscountRate.htm" ///<更新折扣

#define Category_List              @"api/shopAdmin/shopCategory/list.htm"      ///<类别管理首页
#define Category_Add               @"api/shopAdmin/shopCategory/add.htm"       ///<添加分类
#define Category_EditKeep          @"api/shopAdmin/shopCategory/edit.htm"      ///<分类编辑保存
#define Category_EditDelete        @"api/shopAdmin/shopCategory/delete.htm"    ///<分类编辑删除
#define Category_Motify            @"api/shopAdmin/goods/updateCategory.htm"   ///<分类修改

#define Adv_Add                    @"api/shopAdmin/ad/add.htm"                 ///<添加广告
#define Adv_List                   @"api/shopAdmin/ad/adList.htm"              ///<广告列表
#define Adv_Detail                 @"api/shopAdmin/ad/luckyDrawAdDetail.htm"   ///<广告详情
#define Adv_MerchantGetAdWallet    @"api/luckyDraw/allocateRedPacket.htm"     ///<领取商家广告红包

#define Order_list                 @"api/shopAdmin/order/shopOrderList.htm"    ///<订单列表
#define Order_detail               @"api/shopAdmin/order/view.htm"             ///<订单详情
#define Order_delivery             @"api/shopAdmin/order/shipping.htm"         ///<订单配送
#define Order_cancel               @"api/shopAdmin/order/cancel.htm"           ///<取消订单
#define Order_commentDetail        @"api/shopAdmin/review/detail.htm"          ///<订单评论详情
#define Order_commentReview        @"api/shopAdmin/review/answer.htm"          ///<订单评论回复
#define Order_OrderRefund          @"api/order/orderRefund.htm"                ///<订单退款审核

#define Store_FileUpload           @"api/upload/fileUpload.htm"               ///<文件上传
#define Store_base                 @"api/shopAdmin/shopManagen.htm"            ///<店铺中心首页
#define Store_motifyAvatar         @"api/shopAdmin/shop/updateAvatar.htm"      ///<修改店铺头像
#define Store_motifyStorName       @"api/shopAdmin/shop/updateName.htm"        ///<修改店铺名称
#define Store_motifyAddress        @"api/shopAdmin/shop/updateAddress.htm"     ///<修改店铺地址
#define Store_motifyPhoneNum       @"api/shopAdmin/shop/updatePhone.htm"       ///<修改联系电话
#define Store_motifyCloseStatus    @"api/shopAdmin/shop/updateCloseStatus.htm" ///<修改歇业状态
#define Store_motifyIntroduce      @"api/shopAdmin/shop/updateIntroduction.htm"///<修改店铺简介
#define Store_addAdv               @"api/shopAdmin/shop/updateAdLanguage.htm"  ///<添加广告语
#define Store_addBankCard          @"api/bank/addBankAccount.htm"              ///<添加银行卡
#define Store_bankCategoryList     @"api/bank/bankCategoryList.htm"            ///<获取银行卡类型
#define Store_userName             @"api/member/centerSummary.htm"             ///<获取实名姓名
#define Store_bankCardList         @"api/bank/bankAccountList.htm"             ///<银行卡列表
#define Store_deleteBankCard       @"api/bank/deleteBankAccount.htm"           ///<删除银行卡
#define Store_adList               @"api/shopAdmin/ad/adList.htm"              ///<商家广告列表
#define Store_adDetail             @"api/shopAdmin/ad/luckyDrawAdDetail.htm"   ///<广告明细
#define Store_addAd                @"api/shopAdmin/ad/add.htm"                 ///<添加广告
#define Store_addAdNextStep        @"api/shopAdmin/ad/luckyDrawAdAddNextStep.htm"///<添加广告下一步
#define Store_setupInfo            @"api/shopAdmin/ad/luckyDrawAdAdd.htm"      ///<设置群发信息
#define Store_adPreview            @"api/shopAdmin/ad/luckyDrawAdDetail.htm"   ///<广告预览
#define Store_motifyNickName       @"api/member/updateNickname.htm"            ///<修改昵称
#define Store_motifyDelivery       @"api/shopAdmin/shop/updateSupportDelivery.htm"///<修改配送方式
#define Store_isJoinPromotion      @"api/shopAdmin/shop/UpdateIsJoinPromotion.htm"///<商家是否参加折扣活动
#define Store_SetUpCenter          @"api/member/profile.htm"                   ///<个人中心
#define Account_PhoneNum           @"api/member/getBindedMobile.htm"           ///<用户手机号码
#define Account_PhoneCode          @"api/member/sendSmsTokenByUserProfile.htm" ///<获取手机验证码
#define Account_ModifyPhone        @"api/member/changeMobile.htm"              ///<修改手机号码
#define Account_EnsureToken        @"api/member/checkSmsToken.htm"             ///<验证验证码
#define Account_ModifyPassword     @"api/member/changePassword.htm"            ///<修改密码
#define Account_PictureCode        @"common/captcha.htm?captchaId="            ///<获取图片验证码
#define Account_VerifyPictureCode  @"api/member/CaptchaValid.htm"              ///<验证图片验证码

#define Account_Regist             @"api/member/register.htm"                  ///<注册
#define Account_Login              @"api/shopAdmin/logon.htm"                     ///<登录
#define Account_ResetPassword      @"api/member/changePasswordByPhone.htm"     ///<重置密码
#define Get_VerficationCode        @"api/member/sendSmsToken.htm"              ///<获取语音验证码
#define Get_voiceCode              @"api/voiceCode/sendVoiceCode.htm"          ///<语音验证码

//#define Balance_home               @"api/member/property.htm"                ///<资金管理首页
#define Balance_home               @"api/shopAdmin/AccountBalanceCenter.htm"   ///<资金管理首页
#define Balance_settleImmediately  @"api/shopAdmin/settleList.htm"             ///<立即结算
#define Balance_submitSettle       @"api/shopAdmin/submitSettle.htm"           ///<确认结算
#define Balance_applicationWithdrw @"api/withdraw/applyWithDraw.htm"           ///<收支列表
#define Balance_income             @"api/member/blanceDetails.htm"             ///<资金列表
#define Balance_incomeDetail       @"api/member/blanceDetail.htm"              ///<收支详情
#define Balance_withdraw           @"api/withdraw/withDrawList.htm"            ///<提现记录
#define Balance_withdrawDetail     @"api/withdraw/withDrawDetail.htm"          ///<提现记录详情

#define Merchant_industryList      @"api/shopAdmin/industry/list.htm"          ///<获取行业列表
#define Merchant_WriteInfo         @"api/shopAdmin/authentication.htm"         ///<实名认证
#define Merchant_AddressList       @"api/area.htm"                             ///<地址
#define Merchant_JoinInfo          @"api/shopAdmin/shop/apply.htm"             ///<填写商家入驻资料

#define Static_home                @"api/shopAdmin/static/index.htm"           ///<数据统计首页
#define Static_visitor             @"api/shopAdmin/static/visitor.htm"          ///<访客统计
#define Static_income              @"api/shopAdmin/static/income.htm"          ///<收入统计
#define Static_luckyDraw           @"api/shopAdmin/static/luckyDraw.htm"       ///<红包统计
#define Static_sales               @"api/shopAdmin/static/sales.htm"           ///<销量统计
#define Static_coupon              @"api/shopAdmin/static/coupon.htm"          ///<优惠券统计


#define Home_WechatPayment             @"api/wechatPay/submit.htm"            ///<微信支付
#define Home_AlipayPayment             @"api/alipay/submit.htm"               ///<阿里支付
#define Home_BalancePayment            @"api/payment/balancePay.htm"          ///<余额支付


//@1
#define Account_InviteRecord          @"api/member/invitingRecords.htm"        ///<邀请记录
#define Account_ShareMoney            @"api/member/inviteCode.htm"             ///<分享赚钱



//@2
#define Single_income             @"api/shopAdmin/incomeDetails.htm"             ///<商家收入记录

#endif /* UrlHeader_h */
