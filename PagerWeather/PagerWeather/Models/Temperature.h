//
//  Temperature.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Temperature : NSObject

@property (nonatomic, strong) NSNumber *mainTemparetureNumber;
@property (nonatomic, strong) NSNumber *humidityNumber;
@property (nonatomic, strong) NSNumber *preassureNumber;
@property (nonatomic, strong) NSNumber *minTempratureNumber;
@property (nonatomic, strong) NSNumber *maxTemperatureNumber;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
