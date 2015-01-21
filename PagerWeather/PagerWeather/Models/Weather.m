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
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.cityID = [dictionary numberValueForKeyPath:@"id"];
        self.cityNameString = [dictionary valueForKeyPath:@"name" defaultValue:nil];
        self.dataTimeEpochNumber = [dictionary numberValueForKeyPath:@"dt"];
        NSDictionary *sys = [dictionary dictionaryValueForKeyPath:@"sys" defaultValue:nil];
        self.countryCodeString = [sys valueForKeyPath:@"country" defaultValue:nil];
        self.sunriseEpochNumber = [sys numberValueForKeyPath:@"sunrise"];
        self.sunsetEpochNUmber = [sys numberValueForKeyPath:@"sunset"];
        
        NSDictionary *weather = [dictionary dictionaryValueForKeyPath:@"weather" defaultValue:nil];
        self.weatherMainString = [weather valueForKeyPath:@"main" defaultValue:nil];
        self.weatherDescriptionString = [weather valueForKeyPath:@"description" defaultValue:nil];
        NSDictionary *main = [dictionary dictionaryValueForKeyPath:@"main" defaultValue:nil];
        self.temperature = [[Temperature alloc] initWithDictionary:main];
    }
    
    return self;
}
@end
