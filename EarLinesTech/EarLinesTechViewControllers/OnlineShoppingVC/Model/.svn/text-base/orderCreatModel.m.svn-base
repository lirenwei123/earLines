//
//  orderCreatModel.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "orderCreatModel.h"
#import "WechatPaymentData.h"
#import "AlipayPaymentData.h"


NSString *const korderCreatModelWechatPaymentData = @"WechatPaymentData";
NSString *const korderCreatModelCompletedPaymentInd = @"CompletedPaymentInd";
NSString *const korderCreatModelPingXxChargeData = @"PingXxChargeData";
NSString *const korderCreatModelOrderNumber = @"OrderNumber";
NSString *const korderCreatModelAlipayPaymentData = @"AlipayPaymentData";
NSString *const korderCreatModelOrderId = @"OrderId";


@interface orderCreatModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation orderCreatModel

@synthesize wechatPaymentData = _wechatPaymentData;
@synthesize completedPaymentInd = _completedPaymentInd;
@synthesize pingXxChargeData = _pingXxChargeData;
@synthesize orderNumber = _orderNumber;
@synthesize alipayPaymentData = _alipayPaymentData;
@synthesize orderId = _orderId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.wechatPaymentData = [WechatPaymentData modelObjectWithDictionary:[dict objectForKey:korderCreatModelWechatPaymentData]];
            self.completedPaymentInd = [[self objectOrNilForKey:korderCreatModelCompletedPaymentInd fromDictionary:dict] boolValue];
            self.pingXxChargeData = [self objectOrNilForKey:korderCreatModelPingXxChargeData fromDictionary:dict];
            self.orderNumber = [self objectOrNilForKey:korderCreatModelOrderNumber fromDictionary:dict];
            self.alipayPaymentData = [AlipayPaymentData modelObjectWithDictionary:[dict objectForKey:korderCreatModelAlipayPaymentData]];
            self.orderId = [[self objectOrNilForKey:korderCreatModelOrderId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.wechatPaymentData dictionaryRepresentation] forKey:korderCreatModelWechatPaymentData];
    [mutableDict setValue:[NSNumber numberWithBool:self.completedPaymentInd] forKey:korderCreatModelCompletedPaymentInd];
    [mutableDict setValue:self.pingXxChargeData forKey:korderCreatModelPingXxChargeData];
    [mutableDict setValue:self.orderNumber forKey:korderCreatModelOrderNumber];
    [mutableDict setValue:[self.alipayPaymentData dictionaryRepresentation] forKey:korderCreatModelAlipayPaymentData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderId] forKey:korderCreatModelOrderId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.wechatPaymentData = [aDecoder decodeObjectForKey:korderCreatModelWechatPaymentData];
    self.completedPaymentInd = [aDecoder decodeBoolForKey:korderCreatModelCompletedPaymentInd];
    self.pingXxChargeData = [aDecoder decodeObjectForKey:korderCreatModelPingXxChargeData];
    self.orderNumber = [aDecoder decodeObjectForKey:korderCreatModelOrderNumber];
    self.alipayPaymentData = [aDecoder decodeObjectForKey:korderCreatModelAlipayPaymentData];
    self.orderId = [aDecoder decodeDoubleForKey:korderCreatModelOrderId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_wechatPaymentData forKey:korderCreatModelWechatPaymentData];
    [aCoder encodeBool:_completedPaymentInd forKey:korderCreatModelCompletedPaymentInd];
    [aCoder encodeObject:_pingXxChargeData forKey:korderCreatModelPingXxChargeData];
    [aCoder encodeObject:_orderNumber forKey:korderCreatModelOrderNumber];
    [aCoder encodeObject:_alipayPaymentData forKey:korderCreatModelAlipayPaymentData];
    [aCoder encodeDouble:_orderId forKey:korderCreatModelOrderId];
}

- (id)copyWithZone:(NSZone *)zone {
    orderCreatModel *copy = [[orderCreatModel alloc] init];
    
    
    
    if (copy) {

        copy.wechatPaymentData = [self.wechatPaymentData copyWithZone:zone];
        copy.completedPaymentInd = self.completedPaymentInd;
        copy.pingXxChargeData = [self.pingXxChargeData copyWithZone:zone];
        copy.orderNumber = [self.orderNumber copyWithZone:zone];
        copy.alipayPaymentData = [self.alipayPaymentData copyWithZone:zone];
        copy.orderId = self.orderId;
    }
    
    return copy;
}


@end
