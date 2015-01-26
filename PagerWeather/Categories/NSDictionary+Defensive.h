//
//  NSDictionary+Defensive.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Defensive)

// Type consistency checks
- (id)stringValueForKeyPath:(NSString*)keyPath defaultValue:(id)defaultValue;
- (id)arrayValueForKeyPath:(NSString*)keyPath defaultValue:(id)defaultValue;
- (id)dictionaryValueForKeyPath:(NSString*)keyPath defaultValue:(id)defaultValue;
- (NSInteger)integerValueForKeyPath:(NSString*)keyPath;
- (float) floatValueForKeyPath:(NSString*)keyPath;
- (double) doubleValueForKeyPath:(NSString*)keyPath;
- (bool) boolValueForKeyPath:(NSString*)keyPath;
- (NSNumber *) numberValueForKeyPath:(NSString*)keyPath;

// Missing data check
- (id)valueForKeyPath:(NSString*)keyPath defaultValue:(id)defaultValue;

@end
