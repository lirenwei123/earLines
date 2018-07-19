//
//  BaseClass.m
//
//  Created by  RWLi  on 2018/5/7
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "analyseResult.h"
#import "Items.h"


NSString *const kBaseClassIsNotUserEar = @"IsNotUserEar";
NSString *const kBaseClassUserNickName = @"UserNickName";
NSString *const kBaseClassScore = @"Score";
NSString *const kBaseClassShortDescription = @"ShortDescription";
NSString *const kBaseClassShareContent = @"ShareContent";
NSString *const kBaseClassIsEar = @"IsEar";
NSString *const kBaseClassShareLogo = @"ShareLogo";
NSString *const kBaseClassShareLink = @"ShareLink";
NSString *const kBaseClassDescription = @"Description";
NSString *const kBaseClassSuggestionId = @"SuggestionId";
NSString *const kBaseClassUserAccount = @"UserAccount";
NSString *const kBaseClassShareTitle = @"ShareTitle";
NSString *const kBaseClassItems = @"Items";
NSString *const kanalyseResultUserLeftEarImageUrl = @"UserLeftEarImageUrl";
NSString *const kanalyseResultUserRightEarImageUrl = @"UserRightEarImageUrl";


@interface analyseResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation analyseResult

@synthesize isNotUserEar = _isNotUserEar;
@synthesize userNickName = _userNickName;
@synthesize score = _score;
@synthesize shortDescription = _shortDescription;
@synthesize shareContent = _shareContent;
@synthesize isEar = _isEar;
@synthesize shareLogo = _shareLogo;
@synthesize shareLink = _shareLink;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize suggestionId = _suggestionId;
@synthesize userAccount = _userAccount;
@synthesize shareTitle = _shareTitle;
@synthesize items = _items;
@synthesize userLeftEarImageUrl = _userLeftEarImageUrl;
@synthesize userRightEarImageUrl = _userRightEarImageUrl;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.isNotUserEar = [[self objectOrNilForKey:kBaseClassIsNotUserEar fromDictionary:dict] boolValue];
        self.userNickName = [self objectOrNilForKey:kBaseClassUserNickName fromDictionary:dict];
        self.score = [[self objectOrNilForKey:kBaseClassScore fromDictionary:dict] doubleValue];
        self.shortDescription = [self objectOrNilForKey:kBaseClassShortDescription fromDictionary:dict];
        self.shareContent = [self objectOrNilForKey:kBaseClassShareContent fromDictionary:dict];
        self.isEar = [[self objectOrNilForKey:kBaseClassIsEar fromDictionary:dict] boolValue];
        self.shareLogo = [self objectOrNilForKey:kBaseClassShareLogo fromDictionary:dict];
        self.shareLink = [self objectOrNilForKey:kBaseClassShareLink fromDictionary:dict];
        self.internalBaseClassDescription = [self objectOrNilForKey:kBaseClassDescription fromDictionary:dict];
        self.suggestionId = [[self objectOrNilForKey:kBaseClassSuggestionId fromDictionary:dict] doubleValue];
        self.userAccount = [self objectOrNilForKey:kBaseClassUserAccount fromDictionary:dict];
        self.shareTitle = [self objectOrNilForKey:kBaseClassShareTitle fromDictionary:dict];
        self.userLeftEarImageUrl = [self objectOrNilForKey:kanalyseResultUserLeftEarImageUrl fromDictionary:dict];
        self.userRightEarImageUrl = [self objectOrNilForKey:kanalyseResultUserRightEarImageUrl fromDictionary:dict];
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
    [mutableDict setValue:[NSNumber numberWithBool:self.isNotUserEar] forKey:kBaseClassIsNotUserEar];
    [mutableDict setValue:self.userNickName forKey:kBaseClassUserNickName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kBaseClassScore];
    [mutableDict setValue:self.shortDescription forKey:kBaseClassShortDescription];
    [mutableDict setValue:self.shareContent forKey:kBaseClassShareContent];
    [mutableDict setValue:[NSNumber numberWithBool:self.isEar] forKey:kBaseClassIsEar];
    [mutableDict setValue:self.shareLogo forKey:kBaseClassShareLogo];
    [mutableDict setValue:self.shareLink forKey:kBaseClassShareLink];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kBaseClassDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.suggestionId] forKey:kBaseClassSuggestionId];
    [mutableDict setValue:self.userAccount forKey:kBaseClassUserAccount];
    [mutableDict setValue:self.shareTitle forKey:kBaseClassShareTitle];
    [mutableDict setValue:self.userLeftEarImageUrl forKey:kanalyseResultUserLeftEarImageUrl];
    [mutableDict setValue:self.userRightEarImageUrl forKey:kanalyseResultUserRightEarImageUrl];
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

    self.isNotUserEar = [aDecoder decodeBoolForKey:kBaseClassIsNotUserEar];
    self.userNickName = [aDecoder decodeObjectForKey:kBaseClassUserNickName];
    self.score = [aDecoder decodeDoubleForKey:kBaseClassScore];
    self.shortDescription = [aDecoder decodeObjectForKey:kBaseClassShortDescription];
    self.shareContent = [aDecoder decodeObjectForKey:kBaseClassShareContent];
    self.isEar = [aDecoder decodeBoolForKey:kBaseClassIsEar];
    self.shareLogo = [aDecoder decodeObjectForKey:kBaseClassShareLogo];
    self.shareLink = [aDecoder decodeObjectForKey:kBaseClassShareLink];
    self.internalBaseClassDescription = [aDecoder decodeObjectForKey:kBaseClassDescription];
    self.suggestionId = [aDecoder decodeDoubleForKey:kBaseClassSuggestionId];
    self.userAccount = [aDecoder decodeObjectForKey:kBaseClassUserAccount];
    self.shareTitle = [aDecoder decodeObjectForKey:kBaseClassShareTitle];
    self.items = [aDecoder decodeObjectForKey:kBaseClassItems];
    self.userLeftEarImageUrl = [aDecoder decodeObjectForKey:kanalyseResultUserLeftEarImageUrl];
    self.userRightEarImageUrl = [aDecoder decodeObjectForKey:kanalyseResultUserRightEarImageUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_isNotUserEar forKey:kBaseClassIsNotUserEar];
    [aCoder encodeObject:_userNickName forKey:kBaseClassUserNickName];
    [aCoder encodeDouble:_score forKey:kBaseClassScore];
    [aCoder encodeObject:_shortDescription forKey:kBaseClassShortDescription];
    [aCoder encodeObject:_shareContent forKey:kBaseClassShareContent];
    [aCoder encodeBool:_isEar forKey:kBaseClassIsEar];
    [aCoder encodeObject:_shareLogo forKey:kBaseClassShareLogo];
    [aCoder encodeObject:_shareLink forKey:kBaseClassShareLink];
    [aCoder encodeObject:_internalBaseClassDescription forKey:kBaseClassDescription];
    [aCoder encodeDouble:_suggestionId forKey:kBaseClassSuggestionId];
    [aCoder encodeObject:_userAccount forKey:kBaseClassUserAccount];
    [aCoder encodeObject:_shareTitle forKey:kBaseClassShareTitle];
    [aCoder encodeObject:_items forKey:kBaseClassItems];
    [aCoder encodeObject:_userLeftEarImageUrl forKey:kanalyseResultUserLeftEarImageUrl];
    [aCoder encodeObject:_userRightEarImageUrl forKey:kanalyseResultUserRightEarImageUrl];
}

- (id)copyWithZone:(NSZone *)zone {
    analyseResult *copy = [[analyseResult alloc] init];
    
    
    
    if (copy) {

        copy.isNotUserEar = self.isNotUserEar;
        copy.userNickName = [self.userNickName copyWithZone:zone];
        copy.score = self.score;
        copy.shortDescription = [self.shortDescription copyWithZone:zone];
        copy.shareContent = [self.shareContent copyWithZone:zone];
        copy.isEar = self.isEar;
        copy.shareLogo = [self.shareLogo copyWithZone:zone];
        copy.shareLink = [self.shareLink copyWithZone:zone];
        copy.internalBaseClassDescription = [self.internalBaseClassDescription copyWithZone:zone];
        copy.suggestionId = self.suggestionId;
        copy.userAccount = [self.userAccount copyWithZone:zone];
        copy.shareTitle = [self.shareTitle copyWithZone:zone];
        copy.items = [self.items copyWithZone:zone];
        copy.userLeftEarImageUrl = [self.userLeftEarImageUrl copyWithZone:zone];
        copy.userRightEarImageUrl = [self.userRightEarImageUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
