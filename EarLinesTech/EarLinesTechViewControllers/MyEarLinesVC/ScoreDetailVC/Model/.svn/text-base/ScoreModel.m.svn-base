//
//  ScoreModel.m
//
//  Created by  RWLi  on 2018/6/10
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "ScoreModel.h"


NSString *const kScoreModelDescription = @"Description";
NSString *const kScoreModelCreateDt = @"CreateDt";
NSString *const kScoreModelType = @"Type";
NSString *const kScoreModelPoints = @"Points";


@interface ScoreModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ScoreModel

@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize createDt = _createDt;
@synthesize type = _type;
@synthesize points = _points;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.internalBaseClassDescription = [self objectOrNilForKey:kScoreModelDescription fromDictionary:dict];
            self.createDt = [self objectOrNilForKey:kScoreModelCreateDt fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kScoreModelType fromDictionary:dict] intValue];
            self.points = [[self objectOrNilForKey:kScoreModelPoints fromDictionary:dict] intValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kScoreModelDescription];
    [mutableDict setValue:self.createDt forKey:kScoreModelCreateDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kScoreModelType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.points] forKey:kScoreModelPoints];

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

    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kScoreModelDescription];
    self.createDt = [aDecoder decodeObjectForKey:kScoreModelCreateDt];
    self.type = [aDecoder decodeDoubleForKey:kScoreModelType];
    self.points = [aDecoder decodeDoubleForKey:kScoreModelPoints];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_internalBaseClassDescription forKey:kScoreModelDescription];
    [aCoder encodeObject:_createDt forKey:kScoreModelCreateDt];
    [aCoder encodeDouble:_type forKey:kScoreModelType];
    [aCoder encodeDouble:_points forKey:kScoreModelPoints];
}

- (id)copyWithZone:(NSZone *)zone {
    ScoreModel *copy = [[ScoreModel alloc] init];
    
    
    
    if (copy) {

        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.createDt = [self.createDt copyWithZone:zone];
        copy.type = self.type;
        copy.points = self.points;
    }
    
    return copy;
}


@end
