//
//  WechatPaymentData.h
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WechatPaymentData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *partnerid;
@property (nonatomic, strong) NSString *wechatPayPackage;
@property (nonatomic, strong) NSString *noncestr;
@property (nonatomic, assign) double timestamp;
@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *prepayid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
