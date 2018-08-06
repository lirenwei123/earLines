//
//  QLHttpRequest.m
//  QCProject
//
//  Created by chao on 2017/5/14.
//  Copyright © 2017年 C. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import "USERBaseClass.h"



@implementation UploadParam



@end


@implementation HttpRequest


+(AFHTTPSessionManager *)shareManager{
    
    static AFHTTPSessionManager *manager ;
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
           manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
            [manager.requestSerializer setValue:@"earLinesTech" forHTTPHeaderField:@"ClientId"];
            [manager.requestSerializer setValue:@"0963046d-ea54-433a-b966-8844e0117647" forHTTPHeaderField:@"Uuid"];
           
          
            
           manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
            /**
             *  请求队列的最大并发数
             */
                //    manager.operationQueue.maxConcurrentOperationCount = 5;
            /**
             *  请求超时的时间
             */
//                    manager.requestSerializer.timeoutInterval = 30;
        });
        
    }
    NSString * token = [USERBaseClass user].token;
    if (token.length) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
    }
    return manager;
}


#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(NSMutableDictionary *)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure
{

    [[HttpRequest shareManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(NSMutableDictionary *)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure
{
    
    [[HttpRequest shareManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST/GET网络请求 --
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(NSMutableDictionary *)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure
{
    switch (type) {
        case HttpRequestTypeGet:
        {
            [[HttpRequest shareManager] GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break ;
        case HttpRequestTypePost:
        {
            [[HttpRequest shareManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
//                    DebugLog(@"responseObject = %@, task = %@",responseObject,task);
//                    id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                    DebugLog(@"obj = %@",obj);
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break ;
            
        case HttpRequestTypeDelete:
        {
            [[HttpRequest shareManager] DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                     success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break ;
    }
    
}
    
#pragma mark -- 上传图片 --
+ (void)uploadWithURLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters
uploadParam:(UploadParam *)uploadParam success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure
{
    
    [HttpRequest shareManager].requestSerializer.timeoutInterval = 10.f;
    [[HttpRequest shareManager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
//            DebugLog(@"responseObject = %@, task = %@",responseObject,task);
//            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//            DebugLog(@"obj = %@",obj);
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

    
    +(void)lirw_uploadWithURLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters uploadParams:(NSArray<UploadParam *> *)uploadParams success:(void (^)(id))success failure:(void (^)(NSError *,NSInteger errorCode))failure{
        
//        [HttpRequest shareManager].requestSerializer.timeoutInterval = 10.f;
        [[HttpRequest shareManager] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
         {
         
         for (UploadParam * uploadParam in uploadParams) {
              [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
         }
        
         } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
#ifdef DEBUG_MODE
             NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
             DebugLog(@"[responseObject]------>%@",str);
#endif
             if (success) {
                
                                 id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                               
                 success(obj);
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (failure) {
                 NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                 failure(error,response.statusCode);
             }
         }];
    }
    
    
+ (void)lirw_postWithURLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *,NSInteger errorCode))failure{
    [[HttpRequest shareManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
#ifdef DEBUG_MODE
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            DebugLog(@"[responseObject]------>%@",str);
#endif
             id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(obj);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        if (failure) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
            failure(error,response.statusCode);
        }
    }];
}
+(void)lrw_getWithURLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *,NSInteger errorCode))failure{
    [[HttpRequest shareManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
#ifdef DEBUG_MODE
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            DebugLog(@"[responseObject]------>%@",str);
#endif
            id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(obj);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
        failure(error,response.statusCode);
    }];
}
+(void)lrw_requestWithURLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters type:(HttpRequestType)type success:(void (^)(id))success failure:(void (^)(NSError *,NSInteger errorCode))failure{
    switch (type) {
        case HttpRequestTypeGet:
        {
            [[HttpRequest shareManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
#ifdef DEBUG_MODE
                    NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    DebugLog(@"[responseObject]------>%@",str);
#endif
                    id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    success(obj);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                failure(error,response.statusCode);
            }];
        }
            break;
            
        case HttpRequestTypePost:
        {
            [[HttpRequest shareManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
#ifdef DEBUG_MODE
                    NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    DebugLog(@"[responseObject]------>%@",str);
#endif
                    id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    success(obj);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                failure(error,response.statusCode);
            }];
        }
            break;
            
            case HttpRequestTypeDelete:
        {
            [[HttpRequest shareManager]DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
#ifdef DEBUG_MODE
                    NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                    DebugLog(@"[responseObject]------>%@",str);
#endif
                    id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    success(obj);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                failure(error,response.statusCode);
            }];
        }
            break;
            
        default:
            break;
    }
}



@end
