//
//  QLHttpRequest.h
//  QCProject
//
//  Created by chao on 2017/5/14.
//  Copyright © 2017年 C. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UploadParam : NSObject
/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;
@end


@class UploadParam;

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost,
    /**
     *  delete请求
     */
    HttpRequestTypeDelete
};


@class AFHTTPSessionManager;
@interface HttpRequest : NSObject

+(AFHTTPSessionManager *)shareManager;

//(3)typedef void(^SuccessBlock)(id object , NSURLResponse *response):成功后回调的block :参数: 1. id: object(如果是 JSON ,那么直接解析 　　成OC中的数组或者字典.如果不是JSON ,直接返回 NSData) 2. NSURLResponse: 响应头信息，主要是对服务器端的描述
//
//　　　　 (4)typedef void(^failBlock)(NSError *error):失败后回调的block:参数: 1.error：错误信息，如果请求失败，则error有值
/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)URLString
              parameters:(NSMutableDictionary *)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;

//直接解析返回字典/数组
+ (void)lrw_getWithURLString:(NSString *)URLString
              parameters:(NSMutableDictionary *)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error,NSInteger errorCode))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(NSMutableDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

//直接解析返回字典/数组
+ (void)lirw_postWithURLString:(NSString *)URLString
               parameters:(NSMutableDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error,NSInteger errorCode))failure;
/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success 请求的结果
 */
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(NSMutableDictionary *)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;


//直接解析返回字典/数组
+ (void)lrw_requestWithURLString:(NSString *)URLString
                  parameters:(NSMutableDictionary *)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error,NSInteger errorCode))failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(NSMutableDictionary *)parameters
                uploadParam:(UploadParam *)uploadParam
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;
    
    //上传多张图片
    + (void)lirw_uploadWithURLString:(NSString *)URLString
                     parameters:(NSMutableDictionary *)parameters
                    uploadParams:(NSArray<UploadParam *>*)uploadParams
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error,NSInteger errorCode))failure;

@end
