//
//  TrackingItems.h
//
//  Created by  RWLi  on 2018/6/3
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TrackingItems : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *trackingItemsDescription;
@property (nonatomic, assign) BOOL expressInfoInd;
@property (nonatomic, strong) NSString *createDt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
