//
//  BaseClass.h
//
//  Created by  RWLi  on 2018/5/7
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface analyseResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL isNotUserEar;
@property (nonatomic, strong) NSString *userNickName;
@property (nonatomic, assign) double score;
@property (nonatomic, strong) NSString *shortDescription;
@property (nonatomic, strong) NSString *shareContent;
@property (nonatomic, assign) BOOL isEar;
@property (nonatomic, strong) NSString *shareLogo;
@property (nonatomic, strong) NSString *shareLink;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, assign) double suggestionId;
@property (nonatomic, strong) NSString *userAccount;
@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *userLeftEarImageUrl;
@property (nonatomic, strong) NSString *userRightEarImageUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
