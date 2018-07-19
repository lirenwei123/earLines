//
//  EWKJRequest.h
//  myew
//
//  Created by apple   on 2018/4/16.
//  Copyright © 2018年 apple  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"

typedef void(^successBlock)(id datas);
typedef void(^failureBlock)(NSError *error);


typedef NS_ENUM(NSUInteger, API_ID) {
    
    addressApi1,//  获取省列表
    
    addressApi2,// 获取State列表
    
    addressApi3,// 获取城市列表
    
    addressApi4,// 获取用户地址列表
    
    addressApi5, //保存用户地址信息
    
    addressApi6,// 删除用户地址信息
    
    addressApi7, // 根据地址ID获取地址信息
    
    addressApi8,// 设置地址为默认地址
    
    addressApi9,// 获取地址库(一次返回省市区)
    
    
    user1,//用户登录
    
    user2,//获取用户信息
    
    user3,//发送创建账号验证码
    
    user4,//创建账号
    
    user5,//Token过期后通过这个接口刷新Token
    
    user6,//设置支付密码-发送验证码
    
    user7,//设置支付密码
    
    user8,//重置登录密码
    
    user9,//发送重置登录密码验证码
    
    user10,//修改登录密码
    
    user11,//上传图片 FileType 0:实名认证 1:用户头像
    
    user12,//创建账号（用于管理平台）
    
    user13,//重置登录密码（用于管理平台）
    
    user14,//获取角色列表(用于管理平台)
    
    user15,//添加编辑角色(用于管理平台)
    
    user16,//删除角色(用于管理平台)
    
    user17,//获取用户的角色列表(用于管理平台)
    
    user18,//保存用户角色(用于管理平台)
    
    user19,//获取角色对应的权限列表(用于管理平台)
    
    user20,//保存角色对应的权限(用于管理平台)
    
    user21,//更新用户昵称
    
    user22,//更新用户性别(男, 女)
    
    user23,//更新用户头像
    
    //Earprints
    ear1 , //耳纹分析
    
    //Mall商城
//    mall1,
//    mall2,
//    mall3,
//    mall4,
//    mall5,
//    mall6,
//    mall7,
//    mall8,
//    mall9,
//    mall10,
    
    //cart购物车
    cart1,
    cart2,
    cart3,
    cart4,
    cart5,
    cart6,
    
    //profuct产品分类
    product1,
    product2,
    product3,
    
    
};





@interface EWKJRequest : NSObject



+(instancetype)request;

    //上传照片
-(void)uploadWithAPIId:(API_ID)api Icons:(NSArray <UploadParam*>*)uploadIcons completed:(successBlock)success error:(failureBlock)failure;

//通用请求方法
-(void)requestWithAPIId:(API_ID)api  httphead:(NSString*)head  bodyParaDic:(NSDictionary*)paraDic completed:(successBlock)success error:(failureBlock)failure;

@end
