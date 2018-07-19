//
//  MallDetailModel.h
//
//  Created by  RWLi  on 2018/5/21
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MallDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, assign) double qty;
@property (nonatomic, strong) NSString *contactPhoneNumber;
@property (nonatomic, assign) double productId;
@property (nonatomic, assign) double capacity;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSArray *productDetailImages;
@property (nonatomic, strong) NSString *merchantImageUrl;
@property (nonatomic, assign) double merchantId;
@property (nonatomic, assign) BOOL favoriteInd;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, assign) double saleCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
