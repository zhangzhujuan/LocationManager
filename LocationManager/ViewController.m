//
//  ViewController.m
//  LocationManager
//
//  Created by xiaerfei on 15/11/2.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "ViewController.h"
#import "RYLocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationManagerDidSuccessedLocateNotification:) name:RYLocationManagerDidSuccessedLocateNotification object:nil];
    
//    RYLocationManager *locationManager = [RYLocationManager sharedInstance];
//    [locationManager startLocation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManagerDidSuccessedLocateNotification:(NSNotification*)notification
{
    RYLocationManager *locationManager = notification.object;
    NSLog(@"%@",locationManager.formattedAddressLines);
}


@end
