//
//  Banners.h
//
//  Created by  RWLi  on 2018/5/16
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Banners : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) double productId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
