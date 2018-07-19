//
//  wuliuModel.h
//
//  Created by  RWLi  on 2018/6/3
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackingItems.h"


@interface wuliuModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *expressNumber;
@property (nonatomic, strong) NSArray *trackingItems;
@property (nonatomic, strong) NSString *expressCompanyName;
@property (nonatomic, strong) NSString *expressPhoneNumber;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSString *notes;
@property (nonatomic, strong) NSString *deliveryAddress;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
