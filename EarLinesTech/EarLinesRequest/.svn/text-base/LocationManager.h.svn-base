//
//  LocationManager.h
//  EarLinesTech
//
//  Created by  RWLi on 2018/5/16.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationSuccess) (double lat, double lng);
typedef void(^LocationFailed) (NSError *error);

@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *manager;
    LocationSuccess successCallBack;
    LocationFailed failedCallBack;
}

+ (LocationManager *) sharedGpsManager;

+ (void) getMoLocationWithSuccess:(LocationSuccess)success Failure:(LocationFailed)failure;

+ (void) stop;


@end
