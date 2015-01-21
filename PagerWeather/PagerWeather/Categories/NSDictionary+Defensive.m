//
//  NSDictionary+Defensive.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "NSDictionary+Defensive.h"

@implementation NSDictionary (Defensive)

- (bool) boolValueForKeyPath:(NSString*)keyPath;
{
    id	value = [self valueForKeyPath:keyPath defaultValue:nil];
    if ([value respondsToSelector:@selector(boolValue)])
        return [value boolValue];
    return false;
}

- (NSInteger) integerValueForKeyPath:(NSString*)keyPath
{
    id	value = [self valueForKeyPath:keyPath defaultValue:nil];
    
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value integerValue];
    }
    
    return 0;
}

- (float) floatValueForKeyPath:(NSString*)keyPath
{
    id	value = [self valueForKeyPath:keyPath defaultValue:nil];
    
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    
    return 0;
}

- (double) doubleValueForKeyPath:(NSString*)keyPath
{
    id	value = [self valueForKeyPath:keyPath defaultValue:nil];
    
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    
    return 0;
}

- (NSNumber *) numberValueForKeyPath:(NSString*)keyPath
{
    id	value = [self valueForKeyPath:keyPath defaultValue:nil];
    
    if ([value isKindOfClass:[NSNumber class]])
    {
        return value;
    }
    
    return nil;
}


- (id)stringValueForKeyPath:(NSString*)keyPath defaultValue:(id)defaultValue
{
    id	value = [self valueForKeyPath:keyPath defaultValue:defaultValue];
    
    // NOTE: This method also returns the default value if the value is an empty string:
    // this provides some consistency in checking for missing or empty values
    
    // Type consistency check: return the default value if the value is not a string
    return [value isKindOfClass:[NSString class]] ? ([value length] > 0 ? value : defaultValue) : defaultValue;
}



- (id)arrayValueForKeyPath:(NSString*)keyPath defaultValue:(id)defaultValue
{
    id	value = [self valueForKeyPath:keyPath defaultValue:defaultValue];
    
    // Type consistency check: return the default value if the value is not an array
    return [value isKindOfClass:[NSArray class]] ? value : defaultValue;
}



- (id)dictionaryValueForKeyPath:(NSString*)keyPath defaultValue:(id)defaultValue
{
    id	value = [self valueForKeyPath:keyPath defaultValue:defaultValue];
    
    // Type consistency check: return the default value if the value is not a dictionary
    return [value isKindOfClass:[NSDictionary class]] ? value : defaultValue;
}



- (id)valueForKeyPath:(NSString*)keyPath defaultValue:(id)defaultValue
{
    id	value = defaultValue;
    
    // Missing data check: return the default value if the value is missing
    
    // This is essentially an implementation of -[valueForUndefinedKey:]
    // for NSDictionary on a selective basis
    @try
    {
        value = [self valueForKeyPath:keyPath];
    }
    //	@catch (NSException* e)
    @catch(id e)
    {
    }
    
    return value;
}

@end
