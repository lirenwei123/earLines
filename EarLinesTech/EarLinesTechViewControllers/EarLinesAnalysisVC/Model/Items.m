//
//  Items.m
//
//  Created by  RWLi  on 2018/5/7
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "Items.h"


NSString *const kItemsSubject = @"Subject";
NSString *const kItemsBody = @"Body";


@interface Items ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Items

@synthesize subject = _subject;
@synthesize body = _body;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.subject = [self objectOrNilForKey:kItemsSubject fromDictionary:dict];
            self.body = [self objectOrNilForKey:kItemsBody fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.subject forKey:kItemsSubject];
    [mutableDict setValue:self.body forKey:kItemsBody];

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

    self.subject = [aDecoder decodeObjectForKey:kItemsSubject];
    self.body = [aDecoder decodeObjectForKey:kItemsBody];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_subject forKey:kItemsSubject];
    [aCoder encodeObject:_body forKey:kItemsBody];
}

- (id)copyWithZone:(NSZone *)zone {
    Items *copy = [[Items alloc] init];
    
    
    
    if (copy) {

        copy.subject = [self.subject copyWithZone:zone];
        copy.body = [self.body copyWithZone:zone];
    }
    
    return copy;
}


@end
