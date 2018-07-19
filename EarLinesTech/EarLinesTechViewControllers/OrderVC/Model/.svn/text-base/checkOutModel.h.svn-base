//
//  checkOutModel.h
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class addressModel;

@interface checkOutModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) addressModel *address;
@property (nonatomic, strong) NSArray *merchants;
@property (nonatomic, assign) double userPoints;
@property (nonatomic, assign) double expressFee;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
