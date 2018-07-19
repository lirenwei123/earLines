//
//  Cities.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Cities.h"


NSString *const kCitiesCityName = @"CityName";
NSString *const kCitiesCityId = @"CityId";


@interface Cities ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Cities

@synthesize cityName = _cityName;
@synthesize cityId = _cityId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.cityName = [self objectOrNilForKey:kCitiesCityName fromDictionary:dict];
            self.cityId = [[self objectOrNilForKey:kCitiesCityId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cityName forKey:kCitiesCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kCitiesCityId];

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

    self.cityName = [aDecoder decodeObjectForKey:kCitiesCityName];
    self.cityId = [aDecoder decodeDoubleForKey:kCitiesCityId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cityName forKey:kCitiesCityName];
    [aCoder encodeDouble:_cityId forKey:kCitiesCityId];
}

- (id)copyWithZone:(NSZone *)zone {
    Cities *copy = [[Cities alloc] init];
    
    
    
    if (copy) {

        copy.cityName = [self.cityName copyWithZone:zone];
        copy.cityId = self.cityId;
    }
    
    return copy;
}


@end
