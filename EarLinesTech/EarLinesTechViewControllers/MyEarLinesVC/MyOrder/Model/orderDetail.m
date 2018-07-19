//
//  orderDetail.m
//
//  Created by  RWLi  on 2018/6/1
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "orderDetail.h"
#import "CartItem.h"


NSString *const korderDetailItems = @"Items";
NSString *const korderDetailPaymentDt = @"PaymentDt";
NSString *const korderDetailOrderAmount = @"OrderAmount";
NSString *const korderDetailExpressFee = @"ExpressFee";
NSString *const korderDetailCreateDt = @"CreateDt";
NSString *const korderDetailMerchantImageUrl = @"MerchantImageUrl";
NSString *const korderDetailOrderStatusName = @"OrderStatusName";
NSString *const korderDetailContacterName = @"ContacterName";
NSString *const korderDetailOrderId = @"OrderId";
NSString *const korderDetailDeliveryAddress = @"DeliveryAddress";
NSString *const korderDetailMerchantName = @"MerchantName";
NSString *const korderDetailMerchantOrderId = @"MerchantOrderId";
NSString *const korderDetailOrderStatus = @"OrderStatus";
NSString *const korderDetailOrderNumber = @"OrderNumber";
NSString *const korderDetailPhoneNumber = @"PhoneNumber";


@interface orderDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation orderDetail

@synthesize items = _items;
@synthesize paymentDt = _paymentDt;
@synthesize orderAmount = _orderAmount;
@synthesize expressFee = _expressFee;
@synthesize createDt = _createDt;
@synthesize merchantImageUrl = _merchantImageUrl;
@synthesize orderStatusName = _orderStatusName;
@synthesize contacterName = _contacterName;
@synthesize orderId = _orderId;
@synthesize deliveryAddress = _deliveryAddress;
@synthesize merchantName = _merchantName;
@synthesize merchantOrderId = _merchantOrderId;
@synthesize orderStatus = _orderStatus;
@synthesize orderNumber = _orderNumber;
@synthesize phoneNumber = _phoneNumber;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedItems = [dict objectForKey:korderDetailItems];
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
            self.paymentDt = [self objectOrNilForKey:korderDetailPaymentDt fromDictionary:dict];
            self.orderAmount = [[self objectOrNilForKey:korderDetailOrderAmount fromDictionary:dict] doubleValue];
            self.expressFee = [[self objectOrNilForKey:korderDetailExpressFee fromDictionary:dict] doubleValue];
            self.createDt = [self objectOrNilForKey:korderDetailCreateDt fromDictionary:dict];
            self.merchantImageUrl = [self objectOrNilForKey:korderDetailMerchantImageUrl fromDictionary:dict];
            self.orderStatusName = [self objectOrNilForKey:korderDetailOrderStatusName fromDictionary:dict];
            self.contacterName = [self objectOrNilForKey:korderDetailContacterName fromDictionary:dict];
            self.orderId = [[self objectOrNilForKey:korderDetailOrderId fromDictionary:dict] doubleValue];
            self.deliveryAddress = [self objectOrNilForKey:korderDetailDeliveryAddress fromDictionary:dict];
            self.merchantName = [self objectOrNilForKey:korderDetailMerchantName fromDictionary:dict];
            self.merchantOrderId = [[self objectOrNilForKey:korderDetailMerchantOrderId fromDictionary:dict] doubleValue];
            self.orderStatus = [[self objectOrNilForKey:korderDetailOrderStatus fromDictionary:dict] doubleValue];
            self.orderNumber = [self objectOrNilForKey:korderDetailOrderNumber fromDictionary:dict];
            self.phoneNumber = [self objectOrNilForKey:korderDetailPhoneNumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:korderDetailItems];
    [mutableDict setValue:self.paymentDt forKey:korderDetailPaymentDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderAmount] forKey:korderDetailOrderAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.expressFee] forKey:korderDetailExpressFee];
    [mutableDict setValue:self.createDt forKey:korderDetailCreateDt];
    [mutableDict setValue:self.merchantImageUrl forKey:korderDetailMerchantImageUrl];
    [mutableDict setValue:self.orderStatusName forKey:korderDetailOrderStatusName];
    [mutableDict setValue:self.contacterName forKey:korderDetailContacterName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderId] forKey:korderDetailOrderId];
    [mutableDict setValue:self.deliveryAddress forKey:korderDetailDeliveryAddress];
    [mutableDict setValue:self.merchantName forKey:korderDetailMerchantName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.merchantOrderId] forKey:korderDetailMerchantOrderId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.orderStatus] forKey:korderDetailOrderStatus];
    [mutableDict setValue:self.orderNumber forKey:korderDetailOrderNumber];
    [mutableDict setValue:self.phoneNumber forKey:korderDetailPhoneNumber];

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

    self.items = [aDecoder decodeObjectForKey:korderDetailItems];
    self.paymentDt = [aDecoder decodeObjectForKey:korderDetailPaymentDt];
    self.orderAmount = [aDecoder decodeDoubleForKey:korderDetailOrderAmount];
    self.expressFee = [aDecoder decodeDoubleForKey:korderDetailExpressFee];
    self.createDt = [aDecoder decodeObjectForKey:korderDetailCreateDt];
    self.merchantImageUrl = [aDecoder decodeObjectForKey:korderDetailMerchantImageUrl];
    self.orderStatusName = [aDecoder decodeObjectForKey:korderDetailOrderStatusName];
    self.contacterName = [aDecoder decodeObjectForKey:korderDetailContacterName];
    self.orderId = [aDecoder decodeDoubleForKey:korderDetailOrderId];
    self.deliveryAddress = [aDecoder decodeObjectForKey:korderDetailDeliveryAddress];
    self.merchantName = [aDecoder decodeObjectForKey:korderDetailMerchantName];
    self.merchantOrderId = [aDecoder decodeDoubleForKey:korderDetailMerchantOrderId];
    self.orderStatus = [aDecoder decodeDoubleForKey:korderDetailOrderStatus];
    self.orderNumber = [aDecoder decodeObjectForKey:korderDetailOrderNumber];
    self.phoneNumber = [aDecoder decodeObjectForKey:korderDetailPhoneNumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_items forKey:korderDetailItems];
    [aCoder encodeObject:_paymentDt forKey:korderDetailPaymentDt];
    [aCoder encodeDouble:_orderAmount forKey:korderDetailOrderAmount];
    [aCoder encodeDouble:_expressFee forKey:korderDetailExpressFee];
    [aCoder encodeObject:_createDt forKey:korderDetailCreateDt];
    [aCoder encodeObject:_merchantImageUrl forKey:korderDetailMerchantImageUrl];
    [aCoder encodeObject:_orderStatusName forKey:korderDetailOrderStatusName];
    [aCoder encodeObject:_contacterName forKey:korderDetailContacterName];
    [aCoder encodeDouble:_orderId forKey:korderDetailOrderId];
    [aCoder encodeObject:_deliveryAddress forKey:korderDetailDeliveryAddress];
    [aCoder encodeObject:_merchantName forKey:korderDetailMerchantName];
    [aCoder encodeDouble:_merchantOrderId forKey:korderDetailMerchantOrderId];
    [aCoder encodeDouble:_orderStatus forKey:korderDetailOrderStatus];
    [aCoder encodeObject:_orderNumber forKey:korderDetailOrderNumber];
    [aCoder encodeObject:_phoneNumber forKey:korderDetailPhoneNumber];
}

- (id)copyWithZone:(NSZone *)zone {
    orderDetail *copy = [[orderDetail alloc] init];
    
    
    
    if (copy) {

        copy.items = [self.items copyWithZone:zone];
        copy.paymentDt = [self.paymentDt copyWithZone:zone];
        copy.orderAmount = self.orderAmount;
        copy.expressFee = self.expressFee;
        copy.createDt = [self.createDt copyWithZone:zone];
        copy.merchantImageUrl = [self.merchantImageUrl copyWithZone:zone];
        copy.orderStatusName = [self.orderStatusName copyWithZone:zone];
        copy.contacterName = [self.contacterName copyWithZone:zone];
        copy.orderId = self.orderId;
        copy.deliveryAddress = [self.deliveryAddress copyWithZone:zone];
        copy.merchantName = [self.merchantName copyWithZone:zone];
        copy.merchantOrderId = self.merchantOrderId;
        copy.orderStatus = self.orderStatus;
        copy.orderNumber = [self.orderNumber copyWithZone:zone];
        copy.phoneNumber = [self.phoneNumber copyWithZone:zone];
    }
    
    return copy;
}


@end
