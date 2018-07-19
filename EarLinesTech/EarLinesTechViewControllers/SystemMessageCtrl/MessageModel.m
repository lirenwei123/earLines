//
//  MessageModel.m
//
//  Created by  RWLi  on 2018/7/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "MessageModel.h"


NSString *const kMessageModelCreateDt = @"CreateDt";
NSString *const kMessageModelMessageId = @"MessageId";
NSString *const kMessageModelTitle = @"Title";
NSString *const kMessageModelContent = @"Content";


@interface MessageModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MessageModel

@synthesize createDt = _createDt;
@synthesize messageId = _messageId;
@synthesize title = _title;
@synthesize content = _content;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.createDt = [self objectOrNilForKey:kMessageModelCreateDt fromDictionary:dict];
            self.messageId = [[self objectOrNilForKey:kMessageModelMessageId fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kMessageModelTitle fromDictionary:dict];
            self.content = [self objectOrNilForKey:kMessageModelContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createDt forKey:kMessageModelCreateDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.messageId] forKey:kMessageModelMessageId];
    [mutableDict setValue:self.title forKey:kMessageModelTitle];
    [mutableDict setValue:self.content forKey:kMessageModelContent];

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

    self.createDt = [aDecoder decodeObjectForKey:kMessageModelCreateDt];
    self.messageId = [aDecoder decodeDoubleForKey:kMessageModelMessageId];
    self.title = [aDecoder decodeObjectForKey:kMessageModelTitle];
    self.content = [aDecoder decodeObjectForKey:kMessageModelContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createDt forKey:kMessageModelCreateDt];
    [aCoder encodeDouble:_messageId forKey:kMessageModelMessageId];
    [aCoder encodeObject:_title forKey:kMessageModelTitle];
    [aCoder encodeObject:_content forKey:kMessageModelContent];
}

- (id)copyWithZone:(NSZone *)zone {
    MessageModel *copy = [[MessageModel alloc] init];
    
    
    
    if (copy) {

        copy.createDt = [self.createDt copyWithZone:zone];
        copy.messageId = self.messageId;
        copy.title = [self.title copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
