//
//  Items.h
//
//  Created by  RWLi  on 2018/5/23
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CartItem : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double cartId;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSString *productDescription;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) double qty;
@property (nonatomic, assign) double productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double cartItemId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
