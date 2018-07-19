//
//  BaseClass.h
//
//  Created by  RWLi  on 2018/5/7
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface analyseResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSString *shortDescription;
@property (nonatomic, assign) BOOL isEar;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) double suggestionId;
@property (nonatomic, strong) NSArray *items;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
