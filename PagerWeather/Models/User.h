//
//  User.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,assign) BOOL isFahrenheitSelected;

+ (id)sharedUser;
- (void)updateTemperatureOption:(BOOL)isFahrenheitSelected;

@end
