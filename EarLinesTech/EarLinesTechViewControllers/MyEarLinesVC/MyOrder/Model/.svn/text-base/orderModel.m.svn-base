//
//  orderModel.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "orderModel.h"
#import "CartItem.h"


NSString *const korderModelMerchantImageUrl = @"MerchantImageUrl";
NSString *const korderModelOrderAmount = @"OrderAmount";
NSString *const korderModelCreateDt = @"CreateDt";
NSString *const korderModelItems = @"Items";
NSString *const korderModelOrderStatusName = @"OrderStatusName";
NSString *const korderModelMerchantOrderId = @"MerchantOrderId";
NSString *const korderModelOrderId = @"OrderId";
NSString *const korderModelMerchantName = @"MerchantName";
NSString *const korderModelOrderStatus = @"OrderStatus";


@interface orderModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation orderModel

@synthesize merchantImageUrl = _merchantImageUrl;
@synthesize orderAmount = _orderAmount;
@synthesize createDt = _createDt;
@synthesize items = _items;
@synthesize orderStatusName = _orderStatusName;
@synthesize merchantOrderId = _merchantOrderId;
@synthesize orderId = _orderId;
@synthesize merchantName = _merchantName;
@synthesize orderStatus = _orderStatus;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.merchantImageUrl = [self objectOrNilForKey:korderModelMerchantImageUrl fromDictionary:dict];
            self.orderAmount = [[self objectOrNilForKey:korderModelOrderAmount fromDictionary:dict] doubleValue];
            self.createDt = [self objectOrNilForKey:korderModelCreateDt fromDictionary:dict];
    NSObject *receivedItems = [dict objectForKey:korderModelItems];
    NSMutableArray *parsedItems = [NSMutableArray array];
    
    if ([receivedItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedItems) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedItems addObject:[CartItem modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedItems isKindOfClass:[NSDictionary class]]) {
       [parsedItems addObject:[CartItem modelObjectWithDictionary:(NSDictionary *)receivedItems]];
    }

    self.items = [NSArray arrayWithArray:parsedItems];
            self.orderStatusName = [self objectOrNilForKey:korderModelOrderStatusName fromDictionary:dict];
            self.merchantOrderId = [[self objectOrNilForKey:korderModelMerchantOrderId fromDictionary:dict] doubleValue];
            self.orderId = [[self objectOrNilForKey:korderModelOrderId fromDictionary:dict] doubleValue];
            self.merchantName = [self objectOrNilForKey:korderModelMerchantName fromDictionary:dict];
            self.orderStatus = [[self objectOrNilForKey:korderModelOrderStatus fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.merchantImageUrl forKey:korderModelMerchantImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderAmount] forKey:korderModelOrderAmount];
    [mutableDict setValue:self.createDt forKey:korderModelCreateDt];
    NSMutableArray *tempArrayForItems = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.items) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:korderModelItems];
    [mutableDict setValue:self.orderStatusName forKey:korderModelOrderStatusName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.merchantOrderId] forKey:korderModelMerchantOrderId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderId] forKey:korderModelOrderId];
    [mutableDict setValue:self.merchantName forKey:korderModelMerchantName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderStatus] forKey:korderModelOrderStatus];

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

    self.merchantImageUrl = [aDecoder decodeObjectForKey:korderModelMerchantImageUrl];
    self.orderAmount = [aDecoder decodeDoubleForKey:korderModelOrderAmount];
    self.createDt = [aDecoder decodeObjectForKey:korderModelCreateDt];
    self.items = [aDecoder decodeObjectForKey:korderModelItems];
    self.orderStatusName = [aDecoder decodeObjectForKey:korderModelOrderStatusName];
    self.merchantOrderId = [aDecoder decodeDoubleForKey:korderModelMerchantOrderId];
    self.orderId = [aDecoder decodeDoubleForKey:korderModelOrderId];
    self.merchantName = [aDecoder decodeObjectForKey:korderModelMerchantName];
    self.orderStatus = [aDecoder decodeDoubleForKey:korderModelOrderStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_merchantImageUrl forKey:korderModelMerchantImageUrl];
    [aCoder encodeDouble:_orderAmount forKey:korderModelOrderAmount];
    [aCoder encodeObject:_createDt forKey:korderModelCreateDt];
    [aCoder encodeObject:_items forKey:korderModelItems];
    [aCoder encodeObject:_orderStatusName forKey:korderModelOrderStatusName];
    [aCoder encodeDouble:_merchantOrderId forKey:korderModelMerchantOrderId];
    [aCoder encodeDouble:_orderId forKey:korderModelOrderId];
    [aCoder encodeObject:_merchantName forKey:korderModelMerchantName];
    [aCoder encodeDouble:_orderStatus forKey:korderModelOrderStatus];
}

- (id)copyWithZone:(NSZone *)zone {
    orderModel *copy = [[orderModel alloc] init];
    
    
    
    if (copy) {

        copy.merchantImageUrl = [self.merchantImageUrl copyWithZone:zone];
        copy.orderAmount = self.orderAmount;
        copy.createDt = [self.createDt copyWithZone:zone];
        copy.items = [self.items copyWithZone:zone];
        copy.orderStatusName = [self.orderStatusName copyWithZone:zone];
        copy.merchantOrderId = self.merchantOrderId;
        copy.orderId = self.orderId;
        copy.merchantName = [self.merchantName copyWithZone:zone];
        copy.orderStatus = self.orderStatus;
    }
    
    return copy;
}


@end
