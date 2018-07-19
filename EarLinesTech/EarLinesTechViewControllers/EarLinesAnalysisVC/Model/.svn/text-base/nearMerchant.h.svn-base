//
//  nearMerchant.h
//
//  Created by  RWLi  on 2018/5/26
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface nearMerchant : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) double merchantId;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *streetName;
@property (nonatomic, strong) NSString *merchantName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
