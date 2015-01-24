//
//  City.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "City.h"

static NSString * const JSON_PATH = @"countries";

@implementation City

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.cityString = dictionary[@"city"];
        self.countryString = dictionary[@"country"];
        self.imageUrl = [NSURL URLWithString:dictionary[@"imageURL"]];
    }
    return self;
}

+ (NSArray *)getCities {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:JSON_PATH ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *citiesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableArray * citiesMutableArray = [NSMutableArray array];
    
    for (NSDictionary *cityDictionary in citiesDictionary[@"cities"]) {
        [citiesMutableArray addObject:[[City alloc] initWithDictionary:cityDictionary]];
    }
    
    return [citiesMutableArray copy];
}

+ (City *)searchForCityWithString:(NSString *)searchString {
    if (searchString) {
        NSArray *citiesArray = [self getCities];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cityString contains[cd] %@", searchString];
        NSArray *filteredArray = [citiesArray filteredArrayUsingPredicate:predicate];
        
        if (filteredArray && filteredArray.count > 0) {
            return filteredArray[0];
        } else {
            return nil;
        }
        
    }
    return nil;
}

@end
