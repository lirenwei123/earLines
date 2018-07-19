//
//  Products.m
//
//  Created by  RWLi  on 2018/5/16
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Products.h"


NSString *const kProductsProductId = @"ProductId";
NSString *const kProductsImageUrl = @"ImageUrl";
NSString *const kProductsProductName = @"ProductName";
NSString *const kProductsProductPrice = @"ProductPrice";


@interface Products ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Products

@synthesize productId = _productId;
@synthesize imageUrl = _imageUrl;
@synthesize productName = _productName;
@synthesize productPrice = _productPrice;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.productId = [[self objectOrNilForKey:kProductsProductId fromDictionary:dict] doubleValue];
            self.imageUrl = [self objectOrNilForKey:kProductsImageUrl fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kProductsProductName fromDictionary:dict];
            self.productPrice = [[self objectOrNilForKey:kProductsProductPrice fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productId] forKey:kProductsProductId];
    [mutableDict setValue:self.imageUrl forKey:kProductsImageUrl];
    [mutableDict setValue:self.productName forKey:kProductsProductName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productPrice] forKey:kProductsProductPrice];

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

    self.productId = [aDecoder decodeDoubleForKey:kProductsProductId];
    self.imageUrl = [aDecoder decodeObjectForKey:kProductsImageUrl];
    self.productName = [aDecoder decodeObjectForKey:kProductsProductName];
    self.productPrice = [aDecoder decodeDoubleForKey:kProductsProductPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_productId forKey:kProductsProductId];
    [aCoder encodeObject:_imageUrl forKey:kProductsImageUrl];
    [aCoder encodeObject:_productName forKey:kProductsProductName];
    [aCoder encodeDouble:_productPrice forKey:kProductsProductPrice];
}

- (id)copyWithZone:(NSZone *)zone {
    Products *copy = [[Products alloc] init];
    
    
    
    if (copy) {

        copy.productId = self.productId;
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.productPrice = self.productPrice;
    }
    
    return copy;
}


@end
