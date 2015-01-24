//
//  Weather.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "Weather.h"
#import "Temperature.h"
#import "NSDictionary+Defensive.h"

@implementation Weather

+ (id)loadDummyWeather {
    
    Weather * dummyWeather = [[Weather alloc] init];
    dummyWeather.cityNameString = @"--";
    dummyWeather.cityNameString = @"--";
    dummyWeather.weatherDescriptionString = @"--";
    
    return dummyWeather;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.cityID = [dictionary numberValueForKeyPath:@"id"];
        self.cityNameString = [dictionary valueForKeyPath:@"name" defaultValue:nil];
        self.timeDate = [NSDate dateWithTimeIntervalSince1970:[[dictionary numberValueForKeyPath:@"dt"] doubleValue]];
        NSDictionary *sys = [dictionary dictionaryValueForKeyPath:@"sys" defaultValue:nil];
        self.countryCodeString = [sys valueForKeyPath:@"country" defaultValue:nil];
        self.sunriseTimeDate = [NSDate dateWithTimeIntervalSince1970:[[sys numberValueForKeyPath:@"sunrise"] doubleValue]];
        self.sunsetTimeDate = [NSDate dateWithTimeIntervalSince1970:[[sys numberValueForKeyPath:@"sunset"] doubleValue]];
        
        NSDictionary *weather = [dictionary dictionaryValueForKeyPath:@"weather" defaultValue:nil];
        self.weatherMainString = [weather valueForKeyPath:@"main" defaultValue:nil];
        self.weatherDescriptionString = [weather valueForKeyPath:@"description" defaultValue:nil];
        NSDictionary *main = [dictionary dictionaryValueForKeyPath:@"main" defaultValue:nil];
        self.temperature = [[Temperature alloc] initWithDictionary:main];
    }
    
    return self;
}
@end
