//
//  Weather+API.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "Weather.h"

@interface Weather (API)

/*
 * Get the current weather
 */

+ (void)getWeatherForCityName:(NSString*)cityNameString
                   orLatitude:(NSNumber*)latitude longitude:(NSNumber*)longitude
          withCompletionBlock:(void (^)(Weather *weather,NSError *error))completionBlock;
/*
 * Get an array of weather objects for the forecast
 */

+ (void)getForecastForCityName:(NSString*)cityNameString
                    orLatitude:(NSNumber*)latitude longitude:(NSNumber*)longitude
               AndNumberOfDays:(NSNumber*)days
          withCompletionBlock:(void (^)(NSArray *weatherArray,NSError *error))completionBlock;
@end
