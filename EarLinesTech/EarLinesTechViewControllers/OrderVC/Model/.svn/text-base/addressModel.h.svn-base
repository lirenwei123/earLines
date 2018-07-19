//
//  addressModel.h
//
//  Created by  RWLi  on 2018/5/27
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface addressModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *markedPhoneNumber;
@property (nonatomic, strong) NSString *addressFullName;
@property (nonatomic, assign) double cityId;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) BOOL defaultAddressInd;
@property (nonatomic, assign) double stateId;
@property (nonatomic, strong) NSString *consigneeName;
@property (nonatomic, assign) double countryId;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *phoneNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
