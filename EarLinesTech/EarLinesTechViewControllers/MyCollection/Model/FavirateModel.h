//
//  FavirateModel.h
//
//  Created by  RWLi  on 2018/5/24
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FavirateModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double productId;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) double productPrice;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
