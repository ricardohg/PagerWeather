//
//  City.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, copy) NSString *cityString;
@property (nonatomic, copy) NSString *countryString;
@property (nonatomic, strong) NSURL *imageUrl;

- (id)initWithDictionary:(NSDictionary*)dictionary;

/*
 * Returns an array of City objects
 */

+ (NSArray*)getCities;

@end
