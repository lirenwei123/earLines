
//
//  WXApiManager.h
//  SDKSample
//
//  Created by Jeason on 15/7/14.
//
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"
#import "orderCreatModel.h"

@interface WXApiRequestHandler : NSObject

+ (BOOL)jumpToBizPayWith:(orderCreatModel*)order;

@end
