//
//  orderModel.h
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface orderModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *merchantImageUrl;
@property (nonatomic, assign) double orderAmount;
@property (nonatomic, strong) NSString *createDt;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *orderStatusName;
@property (nonatomic, assign) double merchantOrderId;
@property (nonatomic, assign) double orderId;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, assign) double orderStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
