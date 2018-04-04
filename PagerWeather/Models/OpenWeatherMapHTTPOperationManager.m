//
//  OpenWeatherMapAPI.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "OpenWeatherMapHTTPOperationManager.h"

static NSString * const BASE_URL = @"https://api.openweathermap.org/data/2.5/";

@implementation OpenWeatherMapHTTPOperationManager

+ (OpenWeatherMapHTTPOperationManager *)sharedManager
{
    static OpenWeatherMapHTTPOperationManager * sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[OpenWeatherMapHTTPOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    
    return sharedManager;
}

@end
