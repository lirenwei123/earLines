//
//  ScoreModel.h
//
//  Created by  RWLi  on 2018/6/10
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ScoreModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSString *createDt;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int points;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
