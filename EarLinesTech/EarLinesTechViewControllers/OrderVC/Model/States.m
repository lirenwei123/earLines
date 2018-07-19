//
//  States.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "States.h"
#import "Cities.h"


NSString *const kStatesStateId = @"StateId";
NSString *const kStatesCities = @"Cities";
NSString *const kStatesStateName = @"StateName";


@interface States ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation States

@synthesize stateId = _stateId;
@synthesize cities = _cities;
@synthesize stateName = _stateName;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.stateId = [[self objectOrNilForKey:kStatesStateId fromDictionary:dict] doubleValue];
    NSObject *receivedCities = [dict objectForKey:kStatesCities];
    NSMutableArray *parsedCities = [NSMutableArray array];
    
    if ([receivedCities isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCities) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCities addObject:[Cities modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCities isKindOfClass:[NSDictionary class]]) {
       [parsedCities addObject:[Cities modelObjectWithDictionary:(NSDictionary *)receivedCities]];
    }

    self.cities = [NSArray arrayWithArray:parsedCities];
            self.stateName = [self objectOrNilForKey:kStatesStateName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stateId] forKey:kStatesStateId];
    NSMutableArray *tempArrayForCities = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.cities) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCities addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCities addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCities] forKey:kStatesCities];
    [mutableDict setValue:self.stateName forKey:kStatesStateName];

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

    self.stateId = [aDecoder decodeDoubleForKey:kStatesStateId];
    self.cities = [aDecoder decodeObjectForKey:kStatesCities];
    self.stateName = [aDecoder decodeObjectForKey:kStatesStateName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_stateId forKey:kStatesStateId];
    [aCoder encodeObject:_cities forKey:kStatesCities];
    [aCoder encodeObject:_stateName forKey:kStatesStateName];
}

- (id)copyWithZone:(NSZone *)zone {
    States *copy = [[States alloc] init];
    
    
    
    if (copy) {

        copy.stateId = self.stateId;
        copy.cities = [self.cities copyWithZone:zone];
        copy.stateName = [self.stateName copyWithZone:zone];
    }
    
    return copy;
}


@end
