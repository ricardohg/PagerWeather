//
//  Weather+API.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "Weather+API.h"
#import "OpenWeatherMapHTTPOperationManager.h"

static NSString * const WEATHER_ENDPOINT = @"weather";
static NSString * const APPID = @"c3be8a47d90ecd724d6f15cb400b2c49";

@implementation Weather (API)

+(void)getWeatherForCityName:(NSString *)cityNameString orLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withCompletionBlock:(void (^)(Weather *, NSError *))completionBlock {
    OpenWeatherMapHTTPOperationManager * openWeatherMapHTTPOperationManager = [OpenWeatherMapHTTPOperationManager sharedManager];
    NSDictionary * params = nil;
    if (cityNameString) {
        params = @{@"q":cityNameString,@"APPID":APPID};
    } else if (latitude && longitude) {
        params = @{@"lat":latitude,@"lon":longitude,@"APPID":APPID};
    } else {
        NSLog(@"you should pass a city name or latitude and longitude");
    }
    
    [openWeatherMapHTTPOperationManager GET:WEATHER_ENDPOINT parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            if (responseObject) {
                Weather *weather = [[Weather alloc] initWithDictionary:responseObject];
                completionBlock(weather,nil);
            } else {
                completionBlock(nil,nil);
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            completionBlock(nil,error);
        }
    }];
    
}

@end
