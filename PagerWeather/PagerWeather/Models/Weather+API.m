//
//  Weather+API.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "Weather+API.h"
#import "OpenWeatherMapHTTPOperationManager.h"
#import "NSDictionary+Defensive.h"

static NSString * const WEATHER_ENDPOINT = @"weather";
static NSString * const FORECAST_ENDPOINT = @"forecast";
static NSString * const APPID = @"c3be8a47d90ecd724d6f15cb400b2c49";

@implementation Weather (API)

+ (void)getWeatherForCityName:(NSString *)cityNameString orLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withWeatherUnitsFormat:(WeatherUnitsFormat)format withCompletionBlock:(void (^)(Weather *weather, NSError *error))completionBlock {
    OpenWeatherMapHTTPOperationManager * openWeatherMapHTTPOperationManager = [OpenWeatherMapHTTPOperationManager sharedManager];
    NSDictionary * params = nil;
    NSString *formatString = nil;
    
    if (format == WeatherUnitsFormatImperial) {
        formatString = @"imperial";
    } else {
        //default
        formatString = @"metric";
    }
    if (cityNameString) {
        params = @{@"q":cityNameString,@"units":formatString,@"APPID":APPID};
    } else if (latitude && longitude) {
        params = @{@"lat":latitude,@"lon":longitude,@"units":formatString,@"APPID":APPID};
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

+ (void)getForecastForCityName:(NSString *)cityNameString orLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withWeatherUnitsFormat:(WeatherUnitsFormat)format withCompletionBlock:(void (^)(NSArray *weatherArray, NSError *error))completionBlock {
    OpenWeatherMapHTTPOperationManager * openWeatherMapHTTPOperationManager = [OpenWeatherMapHTTPOperationManager sharedManager];
    NSDictionary * params = nil;
    NSString *formatString = nil;
    
    if (format == WeatherUnitsFormatImperial) {
        formatString = @"imperial";
    } else {
        //default
        formatString = @"metric";
    }
    if (cityNameString) {
        params = @{@"q":cityNameString,@"units":formatString,@"APPID":APPID};
    } else if (latitude && longitude) {
        params = @{@"lat":latitude,@"lon":longitude,@"units":formatString,@"APPID":APPID};
    } else {
        NSLog(@"you should pass a city name or latitude and longitude");
    }
    
    [openWeatherMapHTTPOperationManager GET:FORECAST_ENDPOINT parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionBlock) {
            NSMutableArray *weatherArray = [NSMutableArray array];
            NSArray *forecastArray = [responseObject arrayValueForKeyPath:@"list" defaultValue:nil];
            if (forecastArray) {
                for (NSDictionary *weatherDictionary in forecastArray) {
                    Weather *weather = [[Weather alloc] initWithDictionary:weatherDictionary];
                    [weatherArray addObject:weather];
                }
                completionBlock([weatherArray copy],nil);
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
