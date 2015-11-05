//
//  RYBackgroudLocationManager.h
//  LocationManager
//
//  Created by xiaerfei on 15/11/3.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface RYBackgroudLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, copy, readonly) CLLocation *locatedLocation;

+ (instancetype)sharedInstance;

- (void)startLocation;

- (void)stopLocation;

- (void)restartLocation;


@end
