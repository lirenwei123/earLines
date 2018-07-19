//
//  MerchantModel.m
//
//  Created by  RWLi  on 2018/5/23
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "MerchantModel.h"
#import "Products.h"


NSString *const kMerchantModelImageUrl = @"ImageUrl";
NSString *const kMerchantModelAddress = @"Address";
NSString *const kMerchantModelMerchantId = @"MerchantId";
NSString *const kMerchantModelProducts = @"Products";
NSString *const kMerchantModelContactPhoneNumber = @"ContactPhoneNumber";
NSString *const kMerchantModelDescription = @"Description";
NSString *const kMerchantModelMerchantName = @"MerchantName";


@interface MerchantModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MerchantModel

@synthesize imageUrl = _imageUrl;
@synthesize address = _address;
@synthesize merchantId = _merchantId;
@synthesize products = _products;
@synthesize contactPhoneNumber = _contactPhoneNumber;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize merchantName = _merchantName;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.imageUrl = [self objectOrNilForKey:kMerchantModelImageUrl fromDictionary:dict];
            self.address = [self objectOrNilForKey:kMerchantModelAddress fromDictionary:dict];
            self.merchantId = [[self objectOrNilForKey:kMerchantModelMerchantId fromDictionary:dict] doubleValue];
    NSObject *receivedProducts = [dict objectForKey:kMerchantModelProducts];
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
            self.contactPhoneNumber = [self objectOrNilForKey:kMerchantModelContactPhoneNumber fromDictionary:dict];
            self.internalBaseClassDescription = [self objectOrNilForKey:kMerchantModelDescription fromDictionary:dict];
            self.merchantName = [self objectOrNilForKey:kMerchantModelMerchantName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imageUrl forKey:kMerchantModelImageUrl];
    [mutableDict setValue:self.address forKey:kMerchantModelAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.merchantId] forKey:kMerchantModelMerchantId];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProducts] forKey:kMerchantModelProducts];
    [mutableDict setValue:self.contactPhoneNumber forKey:kMerchantModelContactPhoneNumber];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kMerchantModelDescription];
    [mutableDict setValue:self.merchantName forKey:kMerchantModelMerchantName];

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

    self.imageUrl = [aDecoder decodeObjectForKey:kMerchantModelImageUrl];
    self.address = [aDecoder decodeObjectForKey:kMerchantModelAddress];
    self.merchantId = [aDecoder decodeDoubleForKey:kMerchantModelMerchantId];
    self.products = [aDecoder decodeObjectForKey:kMerchantModelProducts];
    self.contactPhoneNumber = [aDecoder decodeObjectForKey:kMerchantModelContactPhoneNumber];
    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kMerchantModelDescription];
    self.merchantName = [aDecoder decodeObjectForKey:kMerchantModelMerchantName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrl forKey:kMerchantModelImageUrl];
    [aCoder encodeObject:_address forKey:kMerchantModelAddress];
    [aCoder encodeDouble:_merchantId forKey:kMerchantModelMerchantId];
    [aCoder encodeObject:_products forKey:kMerchantModelProducts];
    [aCoder encodeObject:_contactPhoneNumber forKey:kMerchantModelContactPhoneNumber];
    [aCoder encodeObject:_internalBaseClassDescription forKey:kMerchantModelDescription];
    [aCoder encodeObject:_merchantName forKey:kMerchantModelMerchantName];
}

- (id)copyWithZone:(NSZone *)zone {
    MerchantModel *copy = [[MerchantModel alloc] init];
    
    
    
    if (copy) {

        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.merchantId = self.merchantId;
        copy.products = [self.products copyWithZone:zone];
        copy.contactPhoneNumber = [self.contactPhoneNumber copyWithZone:zone];
        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.merchantName = [self.merchantName copyWithZone:zone];
    }
    
    return copy;
}


@end
