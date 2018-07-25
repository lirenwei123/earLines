//
//  USERBaseClass.m
//
//  Created by   on 2018/4/26
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "USERBaseClass.h"


NSString *const kUSERBaseClassToken = @"Token";
NSString *const kUSERBaseClassImageUrl = @"ImageUrl";
NSString *const kUSERBaseClassUserId = @"UserId";
NSString *const kUSERBaseClassGender = @"Gender";
NSString *const kUSERBaseClassJobRights = @"JobRights";
NSString *const kUSERBaseClassNickName = @"NickName";
NSString *const kUSERBaseClassAccount = @"Account";
NSString *const kUSERBaseClassUniqueId = @"UniqueId";
NSString *const kUSERBaseClassExpirationDt = @"ExpirationDt";
NSString *const kUSERBaseClasspwd = @"pwd";
NSString *const kUSERBaseClassRealNameAuthenticationInd = @"RealNameAuthenticationInd";


@interface USERBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation USERBaseClass

@synthesize token = _token;
@synthesize imageUrl = _imageUrl;
@synthesize userId = _userId;
@synthesize gender = _gender;
@synthesize jobRights = _jobRights;
@synthesize nickName = _nickName;
@synthesize account = _account;
@synthesize uniqueId = _uniqueId;
@synthesize expirationDt = _expirationDt;
@synthesize pwd = _pwd;
@synthesize RealNameAuthenticationInd = _RealNameAuthenticationInd;



+(instancetype)user{
    static USERBaseClass *user = nil;
    if (user == nil) {
        user = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
    }
    return user;
}

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
     static USERBaseClass *user = nil;
    return user = [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.token = [self objectOrNilForKey:kUSERBaseClassToken fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kUSERBaseClassImageUrl fromDictionary:dict];
            self.userId = [[self objectOrNilForKey:kUSERBaseClassUserId fromDictionary:dict] intValue];
            self.gender = [self objectOrNilForKey:kUSERBaseClassGender fromDictionary:dict];
            self.jobRights = [self objectOrNilForKey:kUSERBaseClassJobRights fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kUSERBaseClassNickName fromDictionary:dict];
            self.account = [self objectOrNilForKey:kUSERBaseClassAccount fromDictionary:dict];
            self.uniqueId = [[self objectOrNilForKey:kUSERBaseClassUniqueId fromDictionary:dict]intValue];
            self.expirationDt = [self objectOrNilForKey:kUSERBaseClassExpirationDt fromDictionary:dict];
        self.RealNameAuthenticationInd = [self objectOrNilForKey:kUSERBaseClassRealNameAuthenticationInd fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.token forKey:kUSERBaseClassToken];
    [mutableDict setValue:self.imageUrl forKey:kUSERBaseClassImageUrl];
    [mutableDict setValue:[NSNumber numberWithInt:self.userId] forKey:kUSERBaseClassUserId];
    [mutableDict setValue:self.gender forKey:kUSERBaseClassGender];
    [mutableDict setValue:self.jobRights forKey:kUSERBaseClassJobRights];
    [mutableDict setValue:self.nickName forKey:kUSERBaseClassNickName];
    [mutableDict setValue:self.account forKey:kUSERBaseClassAccount];
    [mutableDict setValue:[NSNumber numberWithInt:self.uniqueId] forKey:kUSERBaseClassUniqueId];
    [mutableDict setValue:self.expirationDt forKey:kUSERBaseClassExpirationDt];
    
   
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

    self.token = [aDecoder decodeObjectForKey:kUSERBaseClassToken];
    self.imageUrl = [aDecoder decodeObjectForKey:kUSERBaseClassImageUrl];
    self.userId = [aDecoder decodeDoubleForKey:kUSERBaseClassUserId];
    self.gender = [aDecoder decodeObjectForKey:kUSERBaseClassGender];
    self.jobRights = [aDecoder decodeObjectForKey:kUSERBaseClassJobRights];
    self.nickName = [aDecoder decodeObjectForKey:kUSERBaseClassNickName];
    self.account = [aDecoder decodeObjectForKey:kUSERBaseClassAccount];
    self.uniqueId = [aDecoder decodeDoubleForKey:kUSERBaseClassUniqueId];
    self.expirationDt = [aDecoder decodeObjectForKey:kUSERBaseClassExpirationDt];
    self.pwd = [aDecoder decodeObjectForKey:kUSERBaseClasspwd];
    self.RealNameAuthenticationInd = [aDecoder decodeObjectForKey:kUSERBaseClassRealNameAuthenticationInd];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_token forKey:kUSERBaseClassToken];
    [aCoder encodeObject:_imageUrl forKey:kUSERBaseClassImageUrl];
    [aCoder encodeDouble:_userId forKey:kUSERBaseClassUserId];
    [aCoder encodeObject:_gender forKey:kUSERBaseClassGender];
    [aCoder encodeObject:_jobRights forKey:kUSERBaseClassJobRights];
    [aCoder encodeObject:_nickName forKey:kUSERBaseClassNickName];
    [aCoder encodeObject:_account forKey:kUSERBaseClassAccount];
    [aCoder encodeDouble:_uniqueId forKey:kUSERBaseClassUniqueId];
    [aCoder encodeObject:_expirationDt forKey:kUSERBaseClassExpirationDt];
    [aCoder encodeObject:_pwd forKey:kUSERBaseClasspwd];
    [aCoder encodeBool:_RealNameAuthenticationInd forKey:kUSERBaseClassRealNameAuthenticationInd];
}

- (id)copyWithZone:(NSZone *)zone {
    USERBaseClass *copy = [[USERBaseClass alloc] init];
    
    
    
    if (copy) {

        copy.token = [self.token copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.userId = self.userId;
        copy.gender = [self.gender copyWithZone:zone];
        copy.jobRights = self.jobRights;
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.account = [self.account copyWithZone:zone];
        copy.uniqueId = self.uniqueId;
        copy.expirationDt = [self.expirationDt copyWithZone:zone];
        copy.pwd = [self.pwd copyWithZone:zone];
        copy.RealNameAuthenticationInd = self.RealNameAuthenticationInd;
    }
    
    return copy;
}


@end
