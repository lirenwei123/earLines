//
//  AlipayPaymentData.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "AlipayPaymentData.h"


NSString *const kAlipayPaymentDataOrderInfo = @"OrderInfo";


@interface AlipayPaymentData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AlipayPaymentData

@synthesize orderInfo = _orderInfo;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.orderInfo = [self objectOrNilForKey:kAlipayPaymentDataOrderInfo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderInfo forKey:kAlipayPaymentDataOrderInfo];

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

    self.orderInfo = [aDecoder decodeObjectForKey:kAlipayPaymentDataOrderInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderInfo forKey:kAlipayPaymentDataOrderInfo];
}

- (id)copyWithZone:(NSZone *)zone {
    AlipayPaymentData *copy = [[AlipayPaymentData alloc] init];
    
    
    
    if (copy) {

        copy.orderInfo = [self.orderInfo copyWithZone:zone];
    }
    
    return copy;
}


@end
