//
//  MallCartModel.h
//
//  Created by  RWLi  on 2018/5/23
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MallCartModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) double merchantId;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *merchantName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
