//
//  orderDetail.h
//
//  Created by  RWLi  on 2018/6/1
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface orderDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *paymentDt;
@property (nonatomic, assign) double orderAmount;
@property (nonatomic, assign) double expressFee;
@property (nonatomic, strong) NSString *createDt;
@property (nonatomic, strong) NSString *merchantImageUrl;
@property (nonatomic, strong) NSString *orderStatusName;
@property (nonatomic, strong) NSString *contacterName;
@property (nonatomic, assign) double orderId;
@property (nonatomic, strong) NSString *deliveryAddress;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, assign) double merchantOrderId;
@property (nonatomic, assign) double orderStatus;
@property (nonatomic, strong) NSString *orderNumber;
@property (nonatomic, strong) NSString *phoneNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
