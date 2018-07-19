//
//  TrackingItems.m
//
//  Created by  RWLi  on 2018/6/3
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "TrackingItems.h"


NSString *const kTrackingItemsDescription = @"Description";
NSString *const kTrackingItemsExpressInfoInd = @"ExpressInfoInd";
NSString *const kTrackingItemsCreateDt = @"CreateDt";


@interface TrackingItems ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TrackingItems

@synthesize trackingItemsDescription = _trackingItemsDescription;
@synthesize expressInfoInd = _expressInfoInd;
@synthesize createDt = _createDt;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.trackingItemsDescription = [self objectOrNilForKey:kTrackingItemsDescription fromDictionary:dict];
            self.expressInfoInd = [[self objectOrNilForKey:kTrackingItemsExpressInfoInd fromDictionary:dict] boolValue];
            self.createDt = [self objectOrNilForKey:kTrackingItemsCreateDt fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.trackingItemsDescription forKey:kTrackingItemsDescription];
    [mutableDict setValue:[NSNumber numberWithBool:self.expressInfoInd] forKey:kTrackingItemsExpressInfoInd];
    [mutableDict setValue:self.createDt forKey:kTrackingItemsCreateDt];

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

    self.trackingItemsDescription = [aDecoder decodeObjectForKey:kTrackingItemsDescription];
    self.expressInfoInd = [aDecoder decodeBoolForKey:kTrackingItemsExpressInfoInd];
    self.createDt = [aDecoder decodeObjectForKey:kTrackingItemsCreateDt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_trackingItemsDescription forKey:kTrackingItemsDescription];
    [aCoder encodeBool:_expressInfoInd forKey:kTrackingItemsExpressInfoInd];
    [aCoder encodeObject:_createDt forKey:kTrackingItemsCreateDt];
}

- (id)copyWithZone:(NSZone *)zone {
    TrackingItems *copy = [[TrackingItems alloc] init];
    
    
    
    if (copy) {

        copy.trackingItemsDescription = [self.trackingItemsDescription copyWithZone:zone];
        copy.expressInfoInd = self.expressInfoInd;
        copy.createDt = [self.createDt copyWithZone:zone];
    }
    
    return copy;
}


@end
