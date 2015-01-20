//
//  City.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "City.h"

static NSString * const jsonPath = @"countries";

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
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonPath ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *citiesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableArray * citiesMutableArray = [NSMutableArray array];
    
    for (NSDictionary *cityDictionary in citiesDictionary[@"cities"]) {
        [citiesMutableArray addObject:[[City alloc] initWithDictionary:cityDictionary]];
    }
    
    return [citiesMutableArray copy];
}

@end
