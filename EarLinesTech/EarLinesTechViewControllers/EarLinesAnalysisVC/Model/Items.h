//
//  Items.h
//
//  Created by  RWLi  on 2018/5/7
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Items : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
