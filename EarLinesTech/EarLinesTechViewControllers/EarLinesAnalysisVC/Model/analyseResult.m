//
//  BaseClass.m
//
//  Created by  RWLi  on 2018/5/7
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "analyseResult.h"
#import "Items.h"


NSString *const kBaseClassDescription = @"Description";
NSString *const kBaseClassShortDescription = @"ShortDescription";
NSString *const kBaseClassIsEar = @"IsEar";
NSString *const kBaseClassScore = @"Score";
NSString *const kBaseClassSuggestionId = @"SuggestionId";
NSString *const kBaseClassItems = @"Items";


@interface analyseResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation analyseResult

@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize shortDescription = _shortDescription;
@synthesize isEar = _isEar;
@synthesize score = _score;
@synthesize suggestionId = _suggestionId;
@synthesize items = _items;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.internalBaseClassDescription = [self objectOrNilForKey:kBaseClassDescription fromDictionary:dict];
            self.shortDescription = [self objectOrNilForKey:kBaseClassShortDescription fromDictionary:dict];
            self.isEar = [[self objectOrNilForKey:kBaseClassIsEar fromDictionary:dict] boolValue];
            self.score = [[self objectOrNilForKey:kBaseClassScore fromDictionary:dict] doubleValue];
            self.suggestionId = [[self objectOrNilForKey:kBaseClassSuggestionId fromDictionary:dict] doubleValue];
    NSObject *receivedItems = [dict objectForKey:kBaseClassItems];
    NSMutableArray *parsedItems = [NSMutableArray array];
    
    if ([receivedItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedItems) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedItems addObject:[Items modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedItems isKindOfClass:[NSDictionary class]]) {
       [parsedItems addObject:[Items modelObjectWithDictionary:(NSDictionary *)receivedItems]];
    }

    self.items = [NSArray arrayWithArray:parsedItems];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kBaseClassDescription];
    [mutableDict setValue:self.shortDescription forKey:kBaseClassShortDescription];
    [mutableDict setValue:[NSNumber numberWithBool:self.isEar] forKey:kBaseClassIsEar];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kBaseClassScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.suggestionId] forKey:kBaseClassSuggestionId];
    NSMutableArray *tempArrayForItems = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.items) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:kBaseClassItems];

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

    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kBaseClassDescription];
    self.shortDescription = [aDecoder decodeObjectForKey:kBaseClassShortDescription];
    self.isEar = [aDecoder decodeBoolForKey:kBaseClassIsEar];
    self.score = [aDecoder decodeDoubleForKey:kBaseClassScore];
    self.suggestionId = [aDecoder decodeDoubleForKey:kBaseClassSuggestionId];
    self.items = [aDecoder decodeObjectForKey:kBaseClassItems];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_internalBaseClassDescription forKey:kBaseClassDescription];
    [aCoder encodeObject:_shortDescription forKey:kBaseClassShortDescription];
    [aCoder encodeBool:_isEar forKey:kBaseClassIsEar];
    [aCoder encodeDouble:_score forKey:kBaseClassScore];
    [aCoder encodeDouble:_suggestionId forKey:kBaseClassSuggestionId];
    [aCoder encodeObject:_items forKey:kBaseClassItems];
}

- (id)copyWithZone:(NSZone *)zone {
    analyseResult *copy = [[analyseResult alloc] init];
    
    
    
    if (copy) {

        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.shortDescription = [self.shortDescription copyWithZone:zone];
        copy.isEar = self.isEar;
        copy.score = self.score;
        copy.suggestionId = self.suggestionId;
        copy.items = [self.items copyWithZone:zone];
    }
    
    return copy;
}


@end
