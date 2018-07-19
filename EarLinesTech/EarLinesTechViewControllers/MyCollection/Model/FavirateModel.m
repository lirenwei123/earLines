//
//  FavirateModel.m
//
//  Created by  RWLi  on 2018/5/24
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "FavirateModel.h"


NSString *const kFavirateModelProductId = @"ProductId";
NSString *const kFavirateModelImageUrl = @"ImageUrl";
NSString *const kFavirateModelProductName = @"ProductName";
NSString *const kFavirateModelProductPrice = @"ProductPrice";


@interface FavirateModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FavirateModel

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
            self.productId = [[self objectOrNilForKey:kFavirateModelProductId fromDictionary:dict] doubleValue];
            self.imageUrl = [self objectOrNilForKey:kFavirateModelImageUrl fromDictionary:dict];
            self.productName = [self objectOrNilForKey:kFavirateModelProductName fromDictionary:dict];
            self.productPrice = [[self objectOrNilForKey:kFavirateModelProductPrice fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productId] forKey:kFavirateModelProductId];
    [mutableDict setValue:self.imageUrl forKey:kFavirateModelImageUrl];
    [mutableDict setValue:self.productName forKey:kFavirateModelProductName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productPrice] forKey:kFavirateModelProductPrice];

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

    self.productId = [aDecoder decodeDoubleForKey:kFavirateModelProductId];
    self.imageUrl = [aDecoder decodeObjectForKey:kFavirateModelImageUrl];
    self.productName = [aDecoder decodeObjectForKey:kFavirateModelProductName];
    self.productPrice = [aDecoder decodeDoubleForKey:kFavirateModelProductPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_productId forKey:kFavirateModelProductId];
    [aCoder encodeObject:_imageUrl forKey:kFavirateModelImageUrl];
    [aCoder encodeObject:_productName forKey:kFavirateModelProductName];
    [aCoder encodeDouble:_productPrice forKey:kFavirateModelProductPrice];
}

- (id)copyWithZone:(NSZone *)zone {
    FavirateModel *copy = [[FavirateModel alloc] init];
    
    
    
    if (copy) {

        copy.productId = self.productId;
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.productName = [self.productName copyWithZone:zone];
        copy.productPrice = self.productPrice;
    }
    
    return copy;
}


@end
