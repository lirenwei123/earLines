//
//  MessageModel.h
//
//  Created by  RWLi  on 2018/7/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MessageModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createDt;
@property (nonatomic, assign) double messageId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
