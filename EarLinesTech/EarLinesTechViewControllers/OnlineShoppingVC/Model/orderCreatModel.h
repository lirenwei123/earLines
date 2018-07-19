//
//  orderCreatModel.h
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WechatPaymentData, AlipayPaymentData;

@interface orderCreatModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) WechatPaymentData *wechatPaymentData;
@property (nonatomic, assign) BOOL completedPaymentInd;
@property (nonatomic, strong) NSString *pingXxChargeData;
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) AlipayPaymentData *alipayPaymentData;
@property (nonatomic, assign) double orderId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
