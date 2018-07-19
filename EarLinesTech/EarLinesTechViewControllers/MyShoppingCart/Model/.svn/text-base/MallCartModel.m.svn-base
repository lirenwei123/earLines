//
//  MallCartModel.m
//
//  Created by  RWLi  on 2018/5/23
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "MallCartModel.h"
#import "CartItem.h"


NSString *const kMallCartModelImageUrl = @"ImageUrl";
NSString *const kMallCartModelMerchantId = @"MerchantId";
NSString *const kMallCartModelItems = @"Items";
NSString *const kMallCartModelMerchantName = @"MerchantName";


@interface MallCartModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MallCartModel

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
            self.imageUrl = [self objectOrNilForKey:kMallCartModelImageUrl fromDictionary:dict];
            self.merchantId = [[self objectOrNilForKey:kMallCartModelMerchantId fromDictionary:dict] doubleValue];
    NSObject *receivedItems = [dict objectForKey:kMallCartModelItems];
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
            self.merchantName = [self objectOrNilForKey:kMallCartModelMerchantName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kMallCartModelImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.merchantId] forKey:kMallCartModelMerchantId];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:kMallCartModelItems];
    [mutableDict setValue:self.merchantName forKey:kMallCartModelMerchantName];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kMallCartModelImageUrl];
    self.merchantId = [aDecoder decodeDoubleForKey:kMallCartModelMerchantId];
    self.items = [aDecoder decodeObjectForKey:kMallCartModelItems];
    self.merchantName = [aDecoder decodeObjectForKey:kMallCartModelMerchantName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kMallCartModelImageUrl];
    [aCoder encodeDouble:_merchantId forKey:kMallCartModelMerchantId];
    [aCoder encodeObject:_items forKey:kMallCartModelItems];
    [aCoder encodeObject:_merchantName forKey:kMallCartModelMerchantName];
}

- (id)copyWithZone:(NSZone *)zone {
    MallCartModel *copy = [[MallCartModel alloc] init];
    
    
    
    if (copy) {

        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.merchantId = self.merchantId;
        copy.items = [self.items copyWithZone:zone];
        copy.merchantName = [self.merchantName copyWithZone:zone];
    }
    
    return copy;
}


@end
