//
//  Agencies.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Agencies.h"


NSString *const kAgenciesImageUrl = @"ImageUrl";
NSString *const kAgenciesMerchantId = @"MerchantId";
NSString *const kAgenciesDistance = @"Distance";
NSString *const kAgenciesStreetName = @"StreetName";
NSString *const kAgenciesMerchantName = @"MerchantName";


@interface Agencies ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Agencies

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
            self.imageUrl = [self objectOrNilForKey:kAgenciesImageUrl fromDictionary:dict];
            self.merchantId = [[self objectOrNilForKey:kAgenciesMerchantId fromDictionary:dict] doubleValue];
            self.distance = [self objectOrNilForKey:kAgenciesDistance fromDictionary:dict];
            self.streetName = [self objectOrNilForKey:kAgenciesStreetName fromDictionary:dict];
            self.merchantName = [self objectOrNilForKey:kAgenciesMerchantName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kAgenciesImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.merchantId] forKey:kAgenciesMerchantId];
    [mutableDict setValue:self.distance forKey:kAgenciesDistance];
    [mutableDict setValue:self.streetName forKey:kAgenciesStreetName];
    [mutableDict setValue:self.merchantName forKey:kAgenciesMerchantName];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kAgenciesImageUrl];
    self.merchantId = [aDecoder decodeDoubleForKey:kAgenciesMerchantId];
    self.distance = [aDecoder decodeObjectForKey:kAgenciesDistance];
    self.streetName = [aDecoder decodeObjectForKey:kAgenciesStreetName];
    self.merchantName = [aDecoder decodeObjectForKey:kAgenciesMerchantName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kAgenciesImageUrl];
    [aCoder encodeDouble:_merchantId forKey:kAgenciesMerchantId];
    [aCoder encodeObject:_distance forKey:kAgenciesDistance];
    [aCoder encodeObject:_streetName forKey:kAgenciesStreetName];
    [aCoder encodeObject:_merchantName forKey:kAgenciesMerchantName];
}

- (id)copyWithZone:(NSZone *)zone {
    Agencies *copy = [[Agencies alloc] init];
    
    
    
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
