//
//  CountryState.h
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CountryState : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *states;
@property (nonatomic, assign) double countryId;
@property (nonatomic, strong) NSString *countryName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
