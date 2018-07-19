//
//  MallDetailModel.m
//
//  Created by  RWLi  on 2018/5/21
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "MallDetailModel.h"


NSString *const kMallDetailModelImageUrls = @"ImageUrls";
NSString *const kMallDetailModelProductDescription = @"ProductDescription";
NSString *const kMallDetailModelQty = @"Qty";
NSString *const kMallDetailModelContactPhoneNumber = @"ContactPhoneNumber";
NSString *const kMallDetailModelProductId = @"ProductId";
NSString *const kMallDetailModelCapacity = @"Capacity";
NSString *const kMallDetailModelProductName = @"ProductName";
NSString *const kMallDetailModelProductDetailImages = @"ProductDetailImages";
NSString *const kMallDetailModelMerchantImageUrl = @"MerchantImageUrl";
NSString *const kMallDetailModelMerchantId = @"MerchantId";
NSString *const kMallDetailModelFavoriteInd = @"FavoriteInd";
NSString *const kMallDetailModelPrice = @"Price";
NSString *const kMallDetailModelMerchantName = @"MerchantName";
NSString *const kMallDetailModelSaleCount = @"SaleCount";



@interface MallDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MallDetailModel

@synthesize imageUrls = _imageUrls;
@synthesize productDescription = _productDescription;
@synthesize qty = _qty;
@synthesize contactPhoneNumber = _contactPhoneNumber;
@synthesize productId = _productId;
@synthesize capacity = _capacity;
@synthesize productName = _productName;
@synthesize productDetailImages = _productDetailImages;
@synthesize merchantImageUrl = _merchantImageUrl;
@synthesize merchantId = _merchantId;
@synthesize favoriteInd = _favoriteInd;
@synthesize price = _price;
@synthesize merchantName = _merchantName;
@synthesize saleCount = _saleCount;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.imageUrls = [self objectOrNilForKey:kMallDetailModelImageUrls fromDictionary:dict];
            self.productDescription = [self objectOrNilForKey:kMallDetailModelProductDescription fromDictionary:dict];
            self.qty = [[self objectOrNilForKey:kMallDetailModelQty fromDictionary:dict] doubleValue];
            self.contactPhoneNumber = [self objectOrNilForKey:kMallDetailModelContactPhoneNumber fromDictionary:dict];
            self.productId = [[self objectOrNilForKey:kMallDetailModelProductId fromDictionary:dict] doubleValue];
            self.capacity = [[self objectOrNilForKey:kMallDetailModelCapacity fromDictionary:dict] doubleValue];
            self.productName = [self objectOrNilForKey:kMallDetailModelProductName fromDictionary:dict];
            self.productDetailImages = [self objectOrNilForKey:kMallDetailModelProductDetailImages fromDictionary:dict];
            self.merchantImageUrl = [self objectOrNilForKey:kMallDetailModelMerchantImageUrl fromDictionary:dict];
            self.merchantId = [[self objectOrNilForKey:kMallDetailModelMerchantId fromDictionary:dict] doubleValue];
            self.favoriteInd = [[self objectOrNilForKey:kMallDetailModelFavoriteInd fromDictionary:dict] boolValue];
            self.price = [[self objectOrNilForKey:kMallDetailModelPrice fromDictionary:dict] doubleValue];
            self.merchantName = [self objectOrNilForKey:kMallDetailModelMerchantName fromDictionary:dict];
            self.saleCount = [[self objectOrNilForKey:kMallDetailModelSaleCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForImageUrls = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.imageUrls) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImageUrls addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImageUrls addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImageUrls] forKey:kMallDetailModelImageUrls];
    [mutableDict setValue:self.productDescription forKey:kMallDetailModelProductDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qty] forKey:kMallDetailModelQty];
    [mutableDict setValue:self.contactPhoneNumber forKey:kMallDetailModelContactPhoneNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productId] forKey:kMallDetailModelProductId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.capacity] forKey:kMallDetailModelCapacity];
    [mutableDict setValue:self.productName forKey:kMallDetailModelProductName];
    NSMutableArray *tempArrayForProductDetailImages = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.productDetailImages) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProductDetailImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProductDetailImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductDetailImages] forKey:kMallDetailModelProductDetailImages];
    [mutableDict setValue:self.merchantImageUrl forKey:kMallDetailModelMerchantImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.merchantId] forKey:kMallDetailModelMerchantId];
    [mutableDict setValue:[NSNumber numberWithBool:self.favoriteInd] forKey:kMallDetailModelFavoriteInd];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kMallDetailModelPrice];
    [mutableDict setValue:self.merchantName forKey:kMallDetailModelMerchantName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.saleCount] forKey:kMallDetailModelSaleCount];

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

    self.imageUrls = [aDecoder decodeObjectForKey:kMallDetailModelImageUrls];
    self.productDescription = [aDecoder decodeObjectForKey:kMallDetailModelProductDescription];
    self.qty = [aDecoder decodeDoubleForKey:kMallDetailModelQty];
    self.contactPhoneNumber = [aDecoder decodeObjectForKey:kMallDetailModelContactPhoneNumber];
    self.productId = [aDecoder decodeDoubleForKey:kMallDetailModelProductId];
    self.capacity = [aDecoder decodeDoubleForKey:kMallDetailModelCapacity];
    self.productName = [aDecoder decodeObjectForKey:kMallDetailModelProductName];
    self.productDetailImages = [aDecoder decodeObjectForKey:kMallDetailModelProductDetailImages];
    self.merchantImageUrl = [aDecoder decodeObjectForKey:kMallDetailModelMerchantImageUrl];
    self.merchantId = [aDecoder decodeDoubleForKey:kMallDetailModelMerchantId];
    self.favoriteInd = [aDecoder decodeBoolForKey:kMallDetailModelFavoriteInd];
    self.price = [aDecoder decodeDoubleForKey:kMallDetailModelPrice];
    self.merchantName = [aDecoder decodeObjectForKey:kMallDetailModelMerchantName];
    self.saleCount = [aDecoder decodeDoubleForKey:kMallDetailModelSaleCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imageUrls forKey:kMallDetailModelImageUrls];
    [aCoder encodeObject:_productDescription forKey:kMallDetailModelProductDescription];
    [aCoder encodeDouble:_qty forKey:kMallDetailModelQty];
    [aCoder encodeObject:_contactPhoneNumber forKey:kMallDetailModelContactPhoneNumber];
    [aCoder encodeDouble:_productId forKey:kMallDetailModelProductId];
    [aCoder encodeDouble:_capacity forKey:kMallDetailModelCapacity];
    [aCoder encodeObject:_productName forKey:kMallDetailModelProductName];
    [aCoder encodeObject:_productDetailImages forKey:kMallDetailModelProductDetailImages];
    [aCoder encodeObject:_merchantImageUrl forKey:kMallDetailModelMerchantImageUrl];
    [aCoder encodeDouble:_merchantId forKey:kMallDetailModelMerchantId];
    [aCoder encodeBool:_favoriteInd forKey:kMallDetailModelFavoriteInd];
    [aCoder encodeDouble:_price forKey:kMallDetailModelPrice];
    [aCoder encodeObject:_merchantName forKey:kMallDetailModelMerchantName];
    [aCoder encodeDouble:_saleCount forKey:kMallDetailModelSaleCount];
}

- (id)copyWithZone:(NSZone *)zone {
    MallDetailModel *copy = [[MallDetailModel alloc] init];
    
    
    
    if (copy) {

        copy.imageUrls = [self.imageUrls copyWithZone:zone];
        copy.productDescription = [self.productDescription copyWithZone:zone];
        copy.qty = self.qty;
        copy.contactPhoneNumber = [self.contactPhoneNumber copyWithZone:zone];
        copy.productId = self.productId;
        copy.capacity = self.capacity;
        copy.productName = [self.productName copyWithZone:zone];
        copy.productDetailImages = [self.productDetailImages copyWithZone:zone];
        copy.merchantImageUrl = [self.merchantImageUrl copyWithZone:zone];
        copy.merchantId = self.merchantId;
        copy.favoriteInd = self.favoriteInd;
        copy.price = self.price;
        copy.merchantName = [self.merchantName copyWithZone:zone];
        copy.saleCount = self.saleCount;
    }
    
    return copy;
}


@end
