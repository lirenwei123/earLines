//
//  MallHome.m
//
//  Created by  RWLi  on 2018/5/16
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "MallHome.h"
#import "Banners.h"
#import "Products.h"
#import "Agencies.h"



NSString *const kMallHomeBanners = @"Banners";
NSString *const kMallHomeProducts = @"Products";
NSString *const kMallHomeAgencies = @"Agencies";


@interface MallHome ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MallHome

@synthesize banners = _banners;
@synthesize products = _products;
@synthesize agencies = _agencies;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedBanners = [dict objectForKey:kMallHomeBanners];
    NSMutableArray *parsedBanners = [NSMutableArray array];
    
    if ([receivedBanners isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedBanners) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedBanners addObject:[Banners modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedBanners isKindOfClass:[NSDictionary class]]) {
       [parsedBanners addObject:[Banners modelObjectWithDictionary:(NSDictionary *)receivedBanners]];
    }
    self.banners = [NSArray arrayWithArray:parsedBanners];
        
    NSObject *receivedProducts = [dict objectForKey:kMallHomeProducts];
    NSMutableArray *parsedProducts = [NSMutableArray array];
    
    if ([receivedProducts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedProducts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedProducts addObject:[Products modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedProducts isKindOfClass:[NSDictionary class]]) {
       [parsedProducts addObject:[Products modelObjectWithDictionary:(NSDictionary *)receivedProducts]];
    }

        self.products = [NSArray arrayWithArray:parsedProducts];
        NSObject *receivedAgencies = [dict objectForKey:kMallHomeAgencies];
    NSMutableArray *parsedAgencies = [NSMutableArray array];
    
    if ([receivedAgencies isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAgencies) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAgencies addObject:[Agencies modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAgencies isKindOfClass:[NSDictionary class]]) {
       [parsedAgencies addObject:[Agencies modelObjectWithDictionary:(NSDictionary *)receivedAgencies]];
    }

    self.agencies = [NSArray arrayWithArray:parsedAgencies];


    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForBanners = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.banners) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBanners addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBanners addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBanners] forKey:kMallHomeBanners];
    NSMutableArray *tempArrayForProducts = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.products) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProducts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProducts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProducts] forKey:kMallHomeProducts];
    NSMutableArray *tempArrayForAgencies = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.agencies) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAgencies addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAgencies addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAgencies] forKey:kMallHomeAgencies];

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

    self.banners = [aDecoder decodeObjectForKey:kMallHomeBanners];
    self.products = [aDecoder decodeObjectForKey:kMallHomeProducts];
    self.agencies = [aDecoder decodeObjectForKey:kMallHomeAgencies];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_banners forKey:kMallHomeBanners];
    [aCoder encodeObject:_products forKey:kMallHomeProducts];
    [aCoder encodeObject:_agencies forKey:kMallHomeAgencies];
}

- (id)copyWithZone:(NSZone *)zone {
    MallHome *copy = [[MallHome alloc] init];
    
    
    
    if (copy) {

        copy.banners = [self.banners copyWithZone:zone];
        copy.products = [self.products copyWithZone:zone];
        copy.agencies = [self.agencies copyWithZone:zone];
    }
    
    return copy;
}


@end
