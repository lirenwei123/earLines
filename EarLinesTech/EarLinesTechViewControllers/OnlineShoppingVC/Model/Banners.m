//
//  Banners.m
//
//  Created by  RWLi  on 2018/5/16
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Banners.h"


NSString *const kBannersImageUrl = @"ImageUrl";
NSString *const kBannersProductId = @"ProductId";


@interface Banners ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Banners

@synthesize imageUrl = _imageUrl;
@synthesize productId = _productId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.imageUrl = [self objectOrNilForKey:kBannersImageUrl fromDictionary:dict];
            self.productId = [[self objectOrNilForKey:kBannersProductId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kBannersImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productId] forKey:kBannersProductId];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kBannersImageUrl];
    self.productId = [aDecoder decodeDoubleForKey:kBannersProductId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kBannersImageUrl];
    [aCoder encodeDouble:_productId forKey:kBannersProductId];
}

- (id)copyWithZone:(NSZone *)zone {
    Banners *copy = [[Banners alloc] init];
    
    
    
    if (copy) {

        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.productId = self.productId;
    }
    
    return copy;
}


@end
