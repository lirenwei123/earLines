//
//  Merchants.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Merchants.h"
#import "CartItem.h"


NSString *const kMerchantsImageUrl = @"ImageUrl";
NSString *const kMerchantsMerchantId = @"MerchantId";
NSString *const kMerchantsItems = @"Items";
NSString *const kMerchantsMerchantName = @"MerchantName";


@interface Merchants ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Merchants

@synthesize imageUrl = _imageUrl;
@synthesize merchantId = _merchantId;
@synthesize items = _items;
@synthesize merchantName = _merchantName;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.imageUrl = [self objectOrNilForKey:kMerchantsImageUrl fromDictionary:dict];
            self.merchantId = [[self objectOrNilForKey:kMerchantsMerchantId fromDictionary:dict] doubleValue];
    NSObject *receivedItems = [dict objectForKey:kMerchantsItems];
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
            self.merchantName = [self objectOrNilForKey:kMerchantsMerchantName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kMerchantsImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.merchantId] forKey:kMerchantsMerchantId];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:kMerchantsItems];
    [mutableDict setValue:self.merchantName forKey:kMerchantsMerchantName];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kMerchantsImageUrl];
    self.merchantId = [aDecoder decodeDoubleForKey:kMerchantsMerchantId];
    self.items = [aDecoder decodeObjectForKey:kMerchantsItems];
    self.merchantName = [aDecoder decodeObjectForKey:kMerchantsMerchantName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kMerchantsImageUrl];
    [aCoder encodeDouble:_merchantId forKey:kMerchantsMerchantId];
    [aCoder encodeObject:_items forKey:kMerchantsItems];
    [aCoder encodeObject:_merchantName forKey:kMerchantsMerchantName];
}

- (id)copyWithZone:(NSZone *)zone {
    Merchants *copy = [[Merchants alloc] init];
    
    
    
    if (copy) {

        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.merchantId = self.merchantId;
        copy.items = [self.items copyWithZone:zone];
        copy.merchantName = [self.merchantName copyWithZone:zone];
    }
    
    return copy;
}


@end
