//
//  Items.m
//
//  Created by  RWLi  on 2018/5/23
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "CartItem.h"


NSString *const kItemsCartId = @"CartId";
NSString *const kItemsSelected = @"Selected";
NSString *const kItemsProductDescription = @"ProductDescription";
NSString *const kItemsImageUrl = @"ImageUrl";
NSString *const kItemsQty = @"Qty";
NSString *const kItemsProductId = @"ProductId";
NSString *const kItemsProductName = @"ProductName";
NSString *const kItemsPrice = @"Price";
NSString *const kItemsCartItemId = @"CartItemId";


@interface CartItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CartItem

@synthesize cartId = _cartId;
@synthesize selected = _selected;
@synthesize productDescription = _productDescription;
@synthesize imageUrl = _imageUrl;
@synthesize qty = _qty;
@synthesize productId = _productId;
@synthesize productName = _productName;
@synthesize price = _price;
@synthesize cartItemId = _cartItemId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.cartId = [[self objectOrNilForKey:kItemsCartId fromDictionary:dict] doubleValue];
            self.selected = [[self objectOrNilForKey:kItemsSelected fromDictionary:dict] boolValue];
            self.productDescription = [self objectOrNilForKey:kItemsProductDescription fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kItemsImageUrl fromDictionary:dict];
            self.qty = [[self objectOrNilForKey:kItemsQty fromDictionary:dict] doubleValue];
            self.productId = [[self objectOrNilForKey:kItemsProductId fromDictionary:dict] doubleValue];
            self.productName = [self objectOrNilForKey:kItemsProductName fromDictionary:dict];
            self.price = [[self objectOrNilForKey:kItemsPrice fromDictionary:dict] doubleValue];
            self.cartItemId = [[self objectOrNilForKey:kItemsCartItemId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cartId] forKey:kItemsCartId];
    [mutableDict setValue:[NSNumber numberWithBool:self.selected] forKey:kItemsSelected];
    [mutableDict setValue:self.productDescription forKey:kItemsProductDescription];
    [mutableDict setValue:self.imageUrl forKey:kItemsImageUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qty] forKey:kItemsQty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productId] forKey:kItemsProductId];
    [mutableDict setValue:self.productName forKey:kItemsProductName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kItemsPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cartItemId] forKey:kItemsCartItemId];

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

    self.cartId = [aDecoder decodeDoubleForKey:kItemsCartId];
    self.selected = [aDecoder decodeBoolForKey:kItemsSelected];
    self.productDescription = [aDecoder decodeObjectForKey:kItemsProductDescription];
    self.imageUrl = [aDecoder decodeObjectForKey:kItemsImageUrl];
    self.qty = [aDecoder decodeDoubleForKey:kItemsQty];
    self.productId = [aDecoder decodeDoubleForKey:kItemsProductId];
    self.productName = [aDecoder decodeObjectForKey:kItemsProductName];
    self.price = [aDecoder decodeDoubleForKey:kItemsPrice];
    self.cartItemId = [aDecoder decodeDoubleForKey:kItemsCartItemId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_cartId forKey:kItemsCartId];
    [aCoder encodeBool:_selected forKey:kItemsSelected];
    [aCoder encodeObject:_productDescription forKey:kItemsProductDescription];
    [aCoder encodeObject:_imageUrl forKey:kItemsImageUrl];
    [aCoder encodeDouble:_qty forKey:kItemsQty];
    [aCoder encodeDouble:_productId forKey:kItemsProductId];
    [aCoder encodeObject:_productName forKey:kItemsProductName];
    [aCoder encodeDouble:_price forKey:kItemsPrice];
    [aCoder encodeDouble:_cartItemId forKey:kItemsCartItemId];
}

- (id)copyWithZone:(NSZone *)zone {
    CartItem *copy = [[CartItem alloc] init];
    
    
    
    if (copy) {

        copy.cartId = self.cartId;
        copy.selected = self.selected;
        copy.productDescription = [self.productDescription copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.qty = self.qty;
        copy.productId = self.productId;
        copy.productName = [self.productName copyWithZone:zone];
        copy.price = self.price;
        copy.cartItemId = self.cartItemId;
    }
    
    return copy;
}


@end
