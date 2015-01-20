//
//  User.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "User.h"

static NSString * const TEMPERATURE_KEY = @"TEMPERATURE_KEY";

@implementation User

+(id)sharedUser {
    
    static User *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUser = [[User alloc] init];
    });
    return sharedUser;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL isFahrenheitSelected = [defaults boolForKey:TEMPERATURE_KEY];
        self.isFahrenheitSelected = isFahrenheitSelected;
    }
    return self;
}

- (void)updateTemperatureOption:(BOOL)isFahrenheitSelected {
    self.isFahrenheitSelected = isFahrenheitSelected;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isFahrenheitSelected forKey:TEMPERATURE_KEY];
    [defaults synchronize];
    
}


@end
