//
//  WechatPaymentData.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "WechatPaymentData.h"


NSString *const kWechatPaymentDataSign = @"sign";
NSString *const kWechatPaymentDataPartnerid = @"partnerid";
NSString *const kWechatPaymentDataWechatPayPackage = @"wechatPayPackage";
NSString *const kWechatPaymentDataNoncestr = @"noncestr";
NSString *const kWechatPaymentDataTimestamp = @"timestamp";
NSString *const kWechatPaymentDataAppid = @"appid";
NSString *const kWechatPaymentDataPrepayid = @"prepayid";


@interface WechatPaymentData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WechatPaymentData

@synthesize sign = _sign;
@synthesize partnerid = _partnerid;
@synthesize wechatPayPackage = _wechatPayPackage;
@synthesize noncestr = _noncestr;
@synthesize timestamp = _timestamp;
@synthesize appid = _appid;
@synthesize prepayid = _prepayid;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.sign = [self objectOrNilForKey:kWechatPaymentDataSign fromDictionary:dict];
            self.partnerid = [self objectOrNilForKey:kWechatPaymentDataPartnerid fromDictionary:dict];
            self.wechatPayPackage = [self objectOrNilForKey:kWechatPaymentDataWechatPayPackage fromDictionary:dict];
            self.noncestr = [self objectOrNilForKey:kWechatPaymentDataNoncestr fromDictionary:dict];
            self.timestamp = [[self objectOrNilForKey:kWechatPaymentDataTimestamp fromDictionary:dict] doubleValue];
            self.appid = [self objectOrNilForKey:kWechatPaymentDataAppid fromDictionary:dict];
            self.prepayid = [self objectOrNilForKey:kWechatPaymentDataPrepayid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.sign forKey:kWechatPaymentDataSign];
    [mutableDict setValue:self.partnerid forKey:kWechatPaymentDataPartnerid];
    [mutableDict setValue:self.wechatPayPackage forKey:kWechatPaymentDataWechatPayPackage];
    [mutableDict setValue:self.noncestr forKey:kWechatPaymentDataNoncestr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.timestamp] forKey:kWechatPaymentDataTimestamp];
    [mutableDict setValue:self.appid forKey:kWechatPaymentDataAppid];
    [mutableDict setValue:self.prepayid forKey:kWechatPaymentDataPrepayid];

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

    self.sign = [aDecoder decodeObjectForKey:kWechatPaymentDataSign];
    self.partnerid = [aDecoder decodeObjectForKey:kWechatPaymentDataPartnerid];
    self.wechatPayPackage = [aDecoder decodeObjectForKey:kWechatPaymentDataWechatPayPackage];
    self.noncestr = [aDecoder decodeObjectForKey:kWechatPaymentDataNoncestr];
    self.timestamp = [aDecoder decodeDoubleForKey:kWechatPaymentDataTimestamp];
    self.appid = [aDecoder decodeObjectForKey:kWechatPaymentDataAppid];
    self.prepayid = [aDecoder decodeObjectForKey:kWechatPaymentDataPrepayid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sign forKey:kWechatPaymentDataSign];
    [aCoder encodeObject:_partnerid forKey:kWechatPaymentDataPartnerid];
    [aCoder encodeObject:_wechatPayPackage forKey:kWechatPaymentDataWechatPayPackage];
    [aCoder encodeObject:_noncestr forKey:kWechatPaymentDataNoncestr];
    [aCoder encodeDouble:_timestamp forKey:kWechatPaymentDataTimestamp];
    [aCoder encodeObject:_appid forKey:kWechatPaymentDataAppid];
    [aCoder encodeObject:_prepayid forKey:kWechatPaymentDataPrepayid];
}

- (id)copyWithZone:(NSZone *)zone {
    WechatPaymentData *copy = [[WechatPaymentData alloc] init];
    
    
    
    if (copy) {

        copy.sign = [self.sign copyWithZone:zone];
        copy.partnerid = [self.partnerid copyWithZone:zone];
        copy.wechatPayPackage = [self.wechatPayPackage copyWithZone:zone];
        copy.noncestr = [self.noncestr copyWithZone:zone];
        copy.timestamp = self.timestamp;
        copy.appid = [self.appid copyWithZone:zone];
        copy.prepayid = [self.prepayid copyWithZone:zone];
    }
    
    return copy;
}


@end
