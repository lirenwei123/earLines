//
//  States.h
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface States : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double stateId;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSString *stateName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
