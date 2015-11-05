//
//  RYBackgroudLocationManager.m
//  LocationManager
//
//  Created by xiaerfei on 15/11/3.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "RYBackgroudLocationManager.h"


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface RYBackgroudLocationManager ()

@property (nonatomic, strong) CLGeocoder *geoCoder;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy, readwrite) CLLocation *locatedLocation;

@end


@implementation RYBackgroudLocationManager
#pragma mark - Lift Cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t RYBackgroudLocationManagerOnceToken;
    static RYBackgroudLocationManager *sharedInstance = nil;
    dispatch_once(&RYBackgroudLocationManagerOnceToken, ^{
        sharedInstance = [[RYBackgroudLocationManager alloc] init];
    });
    return sharedInstance;
}

- (void)startLocation
{
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startMonitoringSignificantLocationChanges];
}

- (void)stopLocation
{
    [self.locationManager stopMonitoringSignificantLocationChanges];
}

- (void)restartLocation
{
    [self stopLocation];
    [self startLocation];
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (manager.location.coordinate.latitude == self.locatedLocation.coordinate.latitude && manager.location.coordinate.longitude == self.locatedLocation.coordinate.longitude) {
        return;
    }
    [self fetchCityInfoWithLocation:manager.location geocoder:self.geoCoder];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)fetchCityInfoWithLocation:(CLLocation *)location geocoder:(CLGeocoder *)geocoder
{
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks lastObject];
        // 逻辑处理
        if (placemark) {
            NSDictionary *addressDictionary = placemark.addressDictionary;
            NSLog(@"%@",[addressDictionary[@"FormattedAddressLines"] lastObject]);
            self.locatedLocation = location;
        }
    }];
}
#pragma mark - getters and setters
- (CLGeocoder *)geoCoder
{
    if (_geoCoder == nil) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.activityType = CLActivityTypeOtherNavigation;
        _locationManager.distanceFilter = 500;
    }
    return _locationManager;
}

@end
