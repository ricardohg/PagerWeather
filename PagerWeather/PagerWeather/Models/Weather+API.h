//
//  Weather+API.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "Weather.h"

@interface Weather (API)

+ (void)getWeatherForCityName:(NSString*)cityNameString
                   orLatitude:(NSNumber*)latitude longitude:(NSNumber*)longitude
          withCompletionBlock:(void (^)(Weather *weather,NSError *error))completionBlock;

@end
