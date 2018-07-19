//
//  CountryState.m
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "CountryState.h"
#import "States.h"


NSString *const kCountryStateStates = @"States";
NSString *const kCountryStateCountryId = @"CountryId";
NSString *const kCountryStateCountryName = @"CountryName";


@interface CountryState ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CountryState

@synthesize states = _states;
@synthesize countryId = _countryId;
@synthesize countryName = _countryName;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedStates = [dict objectForKey:kCountryStateStates];
    NSMutableArray *parsedStates = [NSMutableArray array];
    
    if ([receivedStates isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedStates) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedStates addObject:[States modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedStates isKindOfClass:[NSDictionary class]]) {
       [parsedStates addObject:[States modelObjectWithDictionary:(NSDictionary *)receivedStates]];
    }

    self.states = [NSArray arrayWithArray:parsedStates];
            self.countryId = [[self objectOrNilForKey:kCountryStateCountryId fromDictionary:dict] doubleValue];
            self.countryName = [self objectOrNilForKey:kCountryStateCountryName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForStates = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.states) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForStates addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForStates addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForStates] forKey:kCountryStateStates];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kCountryStateCountryId];
    [mutableDict setValue:self.countryName forKey:kCountryStateCountryName];

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

    self.states = [aDecoder decodeObjectForKey:kCountryStateStates];
    self.countryId = [aDecoder decodeDoubleForKey:kCountryStateCountryId];
    self.countryName = [aDecoder decodeObjectForKey:kCountryStateCountryName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_states forKey:kCountryStateStates];
    [aCoder encodeDouble:_countryId forKey:kCountryStateCountryId];
    [aCoder encodeObject:_countryName forKey:kCountryStateCountryName];
}

- (id)copyWithZone:(NSZone *)zone {
    CountryState *copy = [[CountryState alloc] init];
    
    
    
    if (copy) {

        copy.states = [self.states copyWithZone:zone];
        copy.countryId = self.countryId;
        copy.countryName = [self.countryName copyWithZone:zone];
    }
    
    return copy;
}


@end
