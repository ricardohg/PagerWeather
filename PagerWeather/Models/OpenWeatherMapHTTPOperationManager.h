//
//  OpenWeatherMapAPI.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <AFNetworking.h>

@interface OpenWeatherMapHTTPOperationManager : AFHTTPRequestOperationManager

+ (OpenWeatherMapHTTPOperationManager*)sharedManager;

@end
