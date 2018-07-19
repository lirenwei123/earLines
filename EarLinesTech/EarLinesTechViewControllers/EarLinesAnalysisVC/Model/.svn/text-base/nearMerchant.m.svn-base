//
//  nearMerchant.m
//
//  Created by  RWLi  on 2018/5/26
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "nearMerchant.h"


NSString *const knearMerchantImageUrl = @"ImageUrl";
NSString *const knearMerchantMerchantId = @"MerchantId";
NSString *const knearMerchantDistance = @"Distance";
NSString *const knearMerchantStreetName = @"StreetName";
NSString *const knearMerchantMerchantName = @"MerchantName";


@interface nearMerchant ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation nearMerchant

@synthesize imageUrl = _imageUrl;
@synthesize merchantId = _merchantId;
@synthesize distance = _distance;
@synthesize streetName = _streetName;
@synthesize merchantName = _merchantName;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.imageUrl = [self objectOrNilForKey:knearMerchantImageUrl fromDictionary:dict];
            self.merchantId = [[self objectOrNilForKey:knearMerchantMerchantId fromDictionary:dict] doubleValue];
            self.distance = [self objectOrNilForKey:knearMerchantDistance fromDictionary:dict];
            self.streetName = [self objectOrNilForKey:knearMerchantStreetName fromDictionary:dict];
            self.merchantName = [self objectOrNilForKey:knearMerchantMerchantName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:knearMerchantImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.merchantId] forKey:knearMerchantMerchantId];
    [mutableDict setValue:self.distance forKey:knearMerchantDistance];
    [mutableDict setValue:self.streetName forKey:knearMerchantStreetName];
    [mutableDict setValue:self.merchantName forKey:knearMerchantMerchantName];

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

    self.imageUrl = [aDecoder decodeObjectForKey:knearMerchantImageUrl];
    self.merchantId = [aDecoder decodeDoubleForKey:knearMerchantMerchantId];
    self.distance = [aDecoder decodeObjectForKey:knearMerchantDistance];
    self.streetName = [aDecoder decodeObjectForKey:knearMerchantStreetName];
    self.merchantName = [aDecoder decodeObjectForKey:knearMerchantMerchantName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:knearMerchantImageUrl];
    [aCoder encodeDouble:_merchantId forKey:knearMerchantMerchantId];
    [aCoder encodeObject:_distance forKey:knearMerchantDistance];
    [aCoder encodeObject:_streetName forKey:knearMerchantStreetName];
    [aCoder encodeObject:_merchantName forKey:knearMerchantMerchantName];
}

- (id)copyWithZone:(NSZone *)zone {
    nearMerchant *copy = [[nearMerchant alloc] init];
    
    
    
    if (copy) {

        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.merchantId = self.merchantId;
        copy.distance = [self.distance copyWithZone:zone];
        copy.streetName = [self.streetName copyWithZone:zone];
        copy.merchantName = [self.merchantName copyWithZone:zone];
    }
    
    return copy;
}


@end
