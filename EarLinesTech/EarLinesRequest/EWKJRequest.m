//
//  EWKJRequest.m
//  myew
//
//  Created by apple   on 2018/4/16.
//  Copyright © 2018年 apple  . All rights reserved.
//

#import "EWKJRequest.h"
#import "USERBaseClass.h"










@interface EWKJRequest()

 @property (nonatomic,strong)NSArray *Apis;


@end



@implementation EWKJRequest

+(instancetype)request{
    static EWKJRequest *request ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[EWKJRequest alloc]init];
        request.Apis = [NSArray arrayWithObjects:
#pragma mark - 地址api
                        @"GET:address/country/list",//获取省列表
                        
                        @"GET:address/state/list?provinceId={provinceId}",  //获取State列表
                        
                        @"GET:address/city/list?stateId={stateId}",   //获取城市列表
                        
                        @"GET:address/address/list",  //获取用户地址列表
                        
                        @"POST:address/address/save",//p,  //保存用户地址信息
                        
                        @"DELETE:address/address/delete?addressId={addressId}",//pg,    //删除用户地址信息
                        
                        @"GET:address/address?addressId={addressId}",   //根据地址ID获取地址信息
                        
                        @"POST:address/address/default?addressId={addressId}",//p,     //设置地址为默认地址
                        
                        @"GET:DeliveryAddress",   //获取地址库(一次返回省市区)
                        
#pragma mark - 用户模块api
                        @"POST:user/login",//p     //用户登录
                        
                        @"GET:user/userinfo",   //获取用户信息
                        
                        @"POST:user/validationcode/createaccount",//p    //发送创建账号验证码
                        
                        @"POST:user/account/create",//p   //创建账号
                        
                        @"GET:user/token/refresh",   //Token过期后通过这个接口刷新Token
                        
                        @"POST:user/validationcode/Resetpaymentpassword",//p    //设置支付密码-发送验证码
                        
                        @"POST:user/password/setpayment",//p   //设置支付密码
                        
                        @"POST:user/password/resetlogin",//p  //重置登录密码
                        
                        @"POST:user/validationcode/forgetpassword",//p   //发送重置登录密码验证码
                        
                        @"POST:user/password/changelogin",//p  //修改登录密码
                        
                        @"POST:user/file/upload",//p  //上传图片 FileType 0:实名认证 1:用户头像
                        
                        @"POST:user/account/admin/create",//p  //创建账号（用于管理平台）
                        
                        @"POST:user/password/admin/resetlogin",//p  //重置登录密码（用于管理平台）
                        
                        @"GET:user/job/list", //获取角色列表(用于管理平台)
                        
                        @"POST:user/job/save",//p    //添加编辑角色(用于管理平台)
                        
                        @"DELETE/:user/job/delete?jobId={jobId}",//pg  //删除角色(用于管理平台)
                        
                        @"GET:user/userjobs?userId={userId}",  //获取用户的角色列表(用于管理平台)
                        
                        @"POST:user/userjobs/save",//p //保存用户角色(用于管理平台)
                        
                        @"POST:user/jobrights/list?jobId={jobId}",  //获取角色对应的权限列表(用于管理平台)
                        
                        @"POST:user/jobrights/save",//p //保存角色对应的权限(用于管理平台)
                        
                        @"POST:POST:user/profile/update/nickname",//p  //更新用户昵称
                        
                        @"POST:user/profile/update/gender",//p  //更新用户性别(男, 女)
                        
                        @"POST:user/profile/update/avatar",//p  //更新用户头像
                        
#pragma mark - 耳纹分析
                        @"POST:earprints/analyze",//p  耳纹分析
                        @"POST:earprints/myearprints",// 我的耳纹
                        
#pragma mark - 商城
                        
                        @"GET:cart/cartitem/quantity",//获取购物车中的商品数量
                        @"POST:cart/cartitem/add",//  添加商品到购物车
                        @"POST:cart/cartitem/quantity",//调整购物车中商品的数量
                        @"POST:cart/cartitem/selected",//选中或取消选中购物车中的商品
                        @"POST:cart/cartitem",//删除购物车中的商品
                        @"GET:Cart",//获取购物车中的商品
                        
                        
#pragma MARK - 产品分类管理
                        @"POST:productcategory/save",//添加修改商品分类(用于管理平台)
                        @"DELETE:productcategory/delete?id={id}",//删除商品分类(用于管理平台)
                        @"GET:ProductCategory",//获取商品分类(用于管理平台)
                        
#pragma mark - 订单管理
                        @"GET:order/checkout",
                        @"POST:order/create",
                        @"POST:order/submit",
                        @"GET:order/myorders?status={status}&pageSize={pageSize}&pageIndex={pageIndex}",
                        @"GET:order/detail?orderId={orderId}&merchantOrderId={merchantOrderId}",
                        @"GET:order/express/trackinginfo?merchantOrderId={merchantOrderId}",
                        @"DELETE:order/delete?orderId={orderId}",
                        @"POST:order/refund",
                        @"GET:order/express/trackinginfo?merchantOrderId={merchantOrderId}",
                        @"POST:order/refund/cancel",
                        nil];
        
    });
    return request;
}






#pragma mark - 通用请求mothod
-(void)requestWithAPIId:(API_ID)api  httphead:(NSString*)head  bodyParaDic:(NSDictionary*)paraDic completed:(successBlock)success error:(failureBlockCode)failure{
    
    if (api >= _Apis.count ) {
        return;
    }
    NSString *apiString = self.Apis[api];
    NSArray *apiDetails = [apiString componentsSeparatedByString:@":"];
    
    NSString *useApi = apiDetails.lastObject;
    //判断是否要在头部传传参数
    //    user/job/delete?jobId={jobId}
    if ([useApi containsString:@"{"] && [useApi containsString:@"}"] && head) {
        NSRange range = [useApi rangeOfString:@"{"];
        useApi = [useApi substringToIndex:range.location];
        useApi = [useApi stringByAppendingString:[NSString stringWithFormat:@"%@",head]];
    }
    NSString *url = [httpHead stringByAppendingString:useApi];
   
    
    //判断post/get
    HttpRequestType  RequestType = HttpRequestTypeGet;
    if ([apiDetails.firstObject isEqualToString:@"GET"]) {
        RequestType = HttpRequestTypePost;
    }else if ([apiDetails.firstObject isEqualToString:@"POST"]){
         RequestType = HttpRequestTypePost;
    }else if ([apiDetails.firstObject isEqualToString:@"DELETE"]){
        RequestType = HttpRequestTypeDelete;
    }
    
    NSMutableDictionary *mudic = nil;
    if (paraDic!=nil) {
        mudic = [NSMutableDictionary dictionaryWithObject:paraDic forKey:Data];
    }
    [HttpRequest lrw_requestWithURLString:url parameters:mudic type:RequestType success:^(id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSError *error, NSInteger errorCode) {
        if (failure) {
            failure(error,errorCode);
        }
    }];
    
}


   
    
    
-(void)uploadWithAPIId:(API_ID)api Icons:(NSArray <UploadParam*>*)uploadIcons completed:(successBlock)success error:(failureBlockCode)failure;{
    
    if (api >= _Apis.count ) {
        return;
    }
    NSString *apiString = self.Apis[api];
    NSArray *apiDetails = [apiString componentsSeparatedByString:@":"];
    NSString *useApi = apiDetails.lastObject;
   
    NSString *url = [httpHead stringByAppendingString:useApi];
   
        [HttpRequest lirw_uploadWithURLString:url parameters:nil uploadParams:uploadIcons success:^(id responseObject) {
            if(success){
                success(responseObject);
            }
        } failure:^(NSError *error, NSInteger errorCode) {
            if (failure) {
                failure(error,errorCode);
            }
        }];
    }











@end
