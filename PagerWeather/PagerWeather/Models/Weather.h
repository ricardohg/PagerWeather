//
//  Weather.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Temperature;
@interface Weather : NSObject

@property (nonatomic, strong) NSNumber *cityID;
@property (nonatomic, copy) NSString *cityNameString;
@property (nonatomic, copy) NSString *countryCodeString;
@property (nonatomic, strong) NSNumber *dataTimeEpochNumber;
@property (nonatomic, strong) NSNumber *sunriseEpochNumber;
@property (nonatomic, strong) NSNumber *sunsetEpochNUmber;
@property (nonatomic, copy) NSString *weatherMainString;
@property (nonatomic, copy) NSString *weatherDescriptionString;
@property (nonatomic, strong) Temperature *temperature;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
