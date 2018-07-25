//
//  EWKJShare.h
//  EarLinesTech
//
//  Created by apple   on 2018/4/25.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSHAREService.h"

@interface EWKJShare : NSObject
@property (nonatomic ,strong) void(^completeBlock)(JSHAREState state, NSError *error);

+(instancetype)share;

-(void)shareWithJSHAREPlatform:(JSHAREPlatform)platform JSHAREMediaType:(JSHAREMediaType)type complete:(void(^)(JSHAREState state, NSError *error))complete;
//分享图片
-(void)shareWithJSHAREPlatform:(JSHAREPlatform)platform imgData:(NSData *)data complete:(void(^)(JSHAREState state, NSError *error))complete;


-(void)shareLinkWithJSHAREPlatform:(JSHAREPlatform)platform JSHAREMessage:(JSHAREMessage*)message complete:(void(^)(JSHAREState state, NSError *error))complete;

@end
