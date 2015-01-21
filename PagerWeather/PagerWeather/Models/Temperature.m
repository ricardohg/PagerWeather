//
//  Temperature.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "Temperature.h"
#import "NSDictionary+Defensive.h"

@implementation Temperature

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.mainTemparetureNumber = [dictionary numberValueForKeyPath:@"temp"];
        self.humidityNumber = [dictionary numberValueForKeyPath:@"humidity"];
        self.preassureNumber = [dictionary numberValueForKeyPath:@"preassure"];
        self.minTempratureNumber = [dictionary numberValueForKeyPath:@"temp_min"];
        self.maxTemperatureNumber = [dictionary numberValueForKeyPath:@"temp_max"];
    }
    return self;
}

@end
