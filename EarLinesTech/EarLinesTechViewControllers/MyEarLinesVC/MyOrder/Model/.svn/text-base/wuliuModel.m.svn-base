//
//  wuliuModel.m
//
//  Created by  RWLi  on 2018/6/3
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "wuliuModel.h"



NSString *const kwuliuModelExpressNumber = @"ExpressNumber";
NSString *const kwuliuModelTrackingItems = @"TrackingItems";
NSString *const kwuliuModelExpressCompanyName = @"ExpressCompanyName";
NSString *const kwuliuModelExpressPhoneNumber = @"ExpressPhoneNumber";
NSString *const kwuliuModelStatus = @"Status";
NSString *const kwuliuModelNotes = @"Notes";
NSString *const kwuliuModelDeliveryAddress = @"DeliveryAddress";


@interface wuliuModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation wuliuModel

@synthesize expressNumber = _expressNumber;
@synthesize trackingItems = _trackingItems;
@synthesize expressCompanyName = _expressCompanyName;
@synthesize status = _status;
@synthesize notes = _notes;
@synthesize deliveryAddress = _deliveryAddress;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.expressNumber = [self objectOrNilForKey:kwuliuModelExpressNumber fromDictionary:dict];
    NSObject *receivedTrackingItems = [dict objectForKey:kwuliuModelTrackingItems];
    NSMutableArray *parsedTrackingItems = [NSMutableArray array];
    
    if ([receivedTrackingItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTrackingItems) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTrackingItems addObject:[TrackingItems modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTrackingItems isKindOfClass:[NSDictionary class]]) {
       [parsedTrackingItems addObject:[TrackingItems modelObjectWithDictionary:(NSDictionary *)receivedTrackingItems]];
    }

    self.trackingItems = [NSArray arrayWithArray:parsedTrackingItems];
        self.expressCompanyName = [self objectOrNilForKey:kwuliuModelExpressCompanyName fromDictionary:dict];
        self.expressPhoneNumber = [self objectOrNilForKey:kwuliuModelExpressPhoneNumber fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kwuliuModelStatus fromDictionary:dict] doubleValue];
            self.notes = [self objectOrNilForKey:kwuliuModelNotes fromDictionary:dict];
            self.deliveryAddress = [self objectOrNilForKey:kwuliuModelDeliveryAddress fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.expressNumber forKey:kwuliuModelExpressNumber];
    NSMutableArray *tempArrayForTrackingItems = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.trackingItems) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTrackingItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTrackingItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTrackingItems] forKey:kwuliuModelTrackingItems];
    [mutableDict setValue:self.expressCompanyName forKey:kwuliuModelExpressCompanyName];
    [mutableDict setValue:self.expressPhoneNumber forKey:kwuliuModelExpressPhoneNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kwuliuModelStatus];
    [mutableDict setValue:self.notes forKey:kwuliuModelNotes];
    [mutableDict setValue:self.deliveryAddress forKey:kwuliuModelDeliveryAddress];

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

    self.expressNumber = [aDecoder decodeObjectForKey:kwuliuModelExpressNumber];
    self.trackingItems = [aDecoder decodeObjectForKey:kwuliuModelTrackingItems];
    self.expressCompanyName = [aDecoder decodeObjectForKey:kwuliuModelExpressCompanyName];
    self.expressPhoneNumber = [aDecoder decodeObjectForKey:kwuliuModelExpressPhoneNumber];
    self.status = [aDecoder decodeDoubleForKey:kwuliuModelStatus];
    self.notes = [aDecoder decodeObjectForKey:kwuliuModelNotes];
    self.deliveryAddress = [aDecoder decodeObjectForKey:kwuliuModelDeliveryAddress];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_expressNumber forKey:kwuliuModelExpressNumber];
    [aCoder encodeObject:_trackingItems forKey:kwuliuModelTrackingItems];
    [aCoder encodeObject:_expressCompanyName forKey:kwuliuModelExpressCompanyName];
    [aCoder encodeObject:_expressPhoneNumber forKey:kwuliuModelExpressPhoneNumber];
    [aCoder encodeDouble:_status forKey:kwuliuModelStatus];
    [aCoder encodeObject:_notes forKey:kwuliuModelNotes];
    [aCoder encodeObject:_deliveryAddress forKey:kwuliuModelDeliveryAddress];
}

- (id)copyWithZone:(NSZone *)zone {
    wuliuModel *copy = [[wuliuModel alloc] init];
    
    
    
    if (copy) {

        copy.expressNumber = [self.expressNumber copyWithZone:zone];
        copy.trackingItems = [self.trackingItems copyWithZone:zone];
        copy.expressCompanyName = [self.expressCompanyName copyWithZone:zone];
        copy.status = self.status;
        copy.notes = [self.notes copyWithZone:zone];
        copy.deliveryAddress = [self.deliveryAddress copyWithZone:zone];
    }
    
    return copy;
}


@end
