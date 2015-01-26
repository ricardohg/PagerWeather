//
//  testWeather.m
//  PagerWeather
//
//  Created by Hernandez Garcia, Ricardo(AWF) on 1/26/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Weather.h"

@interface testWeather : XCTestCase
@property (nonatomic, strong) Weather *testWeather;
@end

@implementation testWeather

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitWithEmptyDictionary
{
    //should not crash with empty dict
    self.testWeather = [[Weather alloc] initWithDictionary:@{}];
    XCTAssertNotNil(self.testWeather);
}
@end
