//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 15/7/14.
//
//

#import "WXApi.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WechatPaymentData.h"



@implementation WXApiRequestHandler

#pragma mark - Public Methods

+(BOOL)jumpToBizPayWith:(orderCreatModel*)order {
    WechatPaymentData *wx =  order.wechatPaymentData;
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = wx.partnerid;
    
    req.nonceStr   = wx.noncestr;
    req.timeStamp  = (int)wx.timestamp;
    req.sign  = wx.sign;
    req.package  = wx.wechatPayPackage;
    req.prepayId = wx.prepayid;
   BOOL result =  [WXApi sendReq:req];
    return result;
}


@end
