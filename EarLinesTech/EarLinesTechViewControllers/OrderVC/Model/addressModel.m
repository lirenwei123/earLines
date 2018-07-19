//
//  addressModel.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "addressModel.h"


NSString *const kaddressModelMarkedPhoneNumber = @"MarkedPhoneNumber";
NSString *const kaddressModelAddressFullName = @"AddressFullName";
NSString *const kaddressModelCityId = @"CityId";
NSString *const kaddressModelId = @"Id";
NSString *const kaddressModelDefaultAddressInd = @"DefaultAddressInd";
NSString *const kaddressModelStateId = @"StateId";
NSString *const kaddressModelConsigneeName = @"ConsigneeName";
NSString *const kaddressModelCountryId = @"CountryId";
NSString *const kaddressModelAddress1 = @"Address1";
NSString *const kaddressModelPhoneNumber = @"PhoneNumber";


@interface addressModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation addressModel

@synthesize markedPhoneNumber = _markedPhoneNumber;
@synthesize addressFullName = _addressFullName;
@synthesize cityId = _cityId;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize defaultAddressInd = _defaultAddressInd;
@synthesize stateId = _stateId;
@synthesize consigneeName = _consigneeName;
@synthesize countryId = _countryId;
@synthesize address1 = _address1;
@synthesize phoneNumber = _phoneNumber;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.markedPhoneNumber = [self objectOrNilForKey:kaddressModelMarkedPhoneNumber fromDictionary:dict];
            self.addressFullName = [self objectOrNilForKey:kaddressModelAddressFullName fromDictionary:dict];
            self.cityId = [[self objectOrNilForKey:kaddressModelCityId fromDictionary:dict] doubleValue];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kaddressModelId fromDictionary:dict] doubleValue];
            self.defaultAddressInd = [[self objectOrNilForKey:kaddressModelDefaultAddressInd fromDictionary:dict] boolValue];
            self.stateId = [[self objectOrNilForKey:kaddressModelStateId fromDictionary:dict] doubleValue];
            self.consigneeName = [self objectOrNilForKey:kaddressModelConsigneeName fromDictionary:dict];
            self.countryId = [[self objectOrNilForKey:kaddressModelCountryId fromDictionary:dict] doubleValue];
            self.address1 = [self objectOrNilForKey:kaddressModelAddress1 fromDictionary:dict];
            self.phoneNumber = [self objectOrNilForKey:kaddressModelPhoneNumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.markedPhoneNumber forKey:kaddressModelMarkedPhoneNumber];
    [mutableDict setValue:self.addressFullName forKey:kaddressModelAddressFullName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kaddressModelCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kaddressModelId];
    [mutableDict setValue:[NSNumber numberWithBool:self.defaultAddressInd] forKey:kaddressModelDefaultAddressInd];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stateId] forKey:kaddressModelStateId];
    [mutableDict setValue:self.consigneeName forKey:kaddressModelConsigneeName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kaddressModelCountryId];
    [mutableDict setValue:self.address1 forKey:kaddressModelAddress1];
    [mutableDict setValue:self.phoneNumber forKey:kaddressModelPhoneNumber];

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

    self.markedPhoneNumber = [aDecoder decodeObjectForKey:kaddressModelMarkedPhoneNumber];
    self.addressFullName = [aDecoder decodeObjectForKey:kaddressModelAddressFullName];
    self.cityId = [aDecoder decodeDoubleForKey:kaddressModelCityId];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kaddressModelId];
    self.defaultAddressInd = [aDecoder decodeBoolForKey:kaddressModelDefaultAddressInd];
    self.stateId = [aDecoder decodeDoubleForKey:kaddressModelStateId];
    self.consigneeName = [aDecoder decodeObjectForKey:kaddressModelConsigneeName];
    self.countryId = [aDecoder decodeDoubleForKey:kaddressModelCountryId];
    self.address1 = [aDecoder decodeObjectForKey:kaddressModelAddress1];
    self.phoneNumber = [aDecoder decodeObjectForKey:kaddressModelPhoneNumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_markedPhoneNumber forKey:kaddressModelMarkedPhoneNumber];
    [aCoder encodeObject:_addressFullName forKey:kaddressModelAddressFullName];
    [aCoder encodeDouble:_cityId forKey:kaddressModelCityId];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kaddressModelId];
    [aCoder encodeBool:_defaultAddressInd forKey:kaddressModelDefaultAddressInd];
    [aCoder encodeDouble:_stateId forKey:kaddressModelStateId];
    [aCoder encodeObject:_consigneeName forKey:kaddressModelConsigneeName];
    [aCoder encodeDouble:_countryId forKey:kaddressModelCountryId];
    [aCoder encodeObject:_address1 forKey:kaddressModelAddress1];
    [aCoder encodeObject:_phoneNumber forKey:kaddressModelPhoneNumber];
}

- (id)copyWithZone:(NSZone *)zone {
    addressModel *copy = [[addressModel alloc] init];
    
    
    
    if (copy) {

        copy.markedPhoneNumber = [self.markedPhoneNumber copyWithZone:zone];
        copy.addressFullName = [self.addressFullName copyWithZone:zone];
        copy.cityId = self.cityId;
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.defaultAddressInd = self.defaultAddressInd;
        copy.stateId = self.stateId;
        copy.consigneeName = [self.consigneeName copyWithZone:zone];
        copy.countryId = self.countryId;
        copy.address1 = [self.address1 copyWithZone:zone];
        copy.phoneNumber = [self.phoneNumber copyWithZone:zone];
    }
    
    return copy;
}


@end
