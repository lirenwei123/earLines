//
//  checkOutModel.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "checkOutModel.h"
#import "addressModel.h"
#import "Merchants.h"


NSString *const kcheckOutModelAddress = @"Address";
NSString *const kcheckOutModelMerchants = @"Merchants";
NSString *const kcheckOutModelUserPoints = @"UserPoints";
NSString *const kcheckOutModelExpressFee = @"ExpressFee";


@interface checkOutModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation checkOutModel

@synthesize address = _address;
@synthesize merchants = _merchants;
@synthesize userPoints = _userPoints;
@synthesize expressFee = _expressFee;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.address = [addressModel modelObjectWithDictionary:[dict objectForKey:kcheckOutModelAddress]];
    NSObject *receivedMerchants = [dict objectForKey:kcheckOutModelMerchants];
    NSMutableArray *parsedMerchants = [NSMutableArray array];
    
    if ([receivedMerchants isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMerchants) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMerchants addObject:[Merchants modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMerchants isKindOfClass:[NSDictionary class]]) {
       [parsedMerchants addObject:[Merchants modelObjectWithDictionary:(NSDictionary *)receivedMerchants]];
    }

    self.merchants = [NSArray arrayWithArray:parsedMerchants];
            self.userPoints = [[self objectOrNilForKey:kcheckOutModelUserPoints fromDictionary:dict] doubleValue];
            self.expressFee = [[self objectOrNilForKey:kcheckOutModelExpressFee fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.address dictionaryRepresentation] forKey:kcheckOutModelAddress];
    NSMutableArray *tempArrayForMerchants = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.merchants) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMerchants addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMerchants addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMerchants] forKey:kcheckOutModelMerchants];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userPoints] forKey:kcheckOutModelUserPoints];
    [mutableDict setValue:[NSNumber numberWithDouble:self.expressFee] forKey:kcheckOutModelExpressFee];

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

    self.address = [aDecoder decodeObjectForKey:kcheckOutModelAddress];
    self.merchants = [aDecoder decodeObjectForKey:kcheckOutModelMerchants];
    self.userPoints = [aDecoder decodeDoubleForKey:kcheckOutModelUserPoints];
    self.expressFee = [aDecoder decodeDoubleForKey:kcheckOutModelExpressFee];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_address forKey:kcheckOutModelAddress];
    [aCoder encodeObject:_merchants forKey:kcheckOutModelMerchants];
    [aCoder encodeDouble:_userPoints forKey:kcheckOutModelUserPoints];
    [aCoder encodeDouble:_expressFee forKey:kcheckOutModelExpressFee];
}

- (id)copyWithZone:(NSZone *)zone {
    checkOutModel *copy = [[checkOutModel alloc] init];
    
    
    
    if (copy) {

        copy.address = [self.address copyWithZone:zone];
        copy.merchants = [self.merchants copyWithZone:zone];
        copy.userPoints = self.userPoints;
        copy.expressFee = self.expressFee;
    }
    
    return copy;
}


@end
