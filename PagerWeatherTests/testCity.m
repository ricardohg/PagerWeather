//
//  testCity.m
//  PagerWeather
//
//  Created by Hernandez Garcia, Ricardo(AWF) on 1/26/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "City.h"

@interface testCity : XCTestCase
@property (nonatomic, strong) City *testCity;
@end

@implementation testCity

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitWithEmptyDictionary
{
    //should not crash with empty dict
    self.testCity = [[City alloc] initWithDictionary:@{}];
    XCTAssertNotNil(self.testCity);
}

- (void)testGetCities
{
    NSArray *array = [City getCities];
    XCTAssertTrue([array isKindOfClass:[NSArray class]]);
}

- (void) testSearchForCityWithString
{
    NSString *searchString = @"Paris";
    City *resultCity= [City searchForCityWithString:searchString];
    if (resultCity) {
        XCTAssertTrue([searchString isEqualToString:resultCity.cityString]);
    } else {
        XCTAssertNil(resultCity);
    }
}
@end
