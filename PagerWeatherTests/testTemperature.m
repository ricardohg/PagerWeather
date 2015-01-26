//
//  testTemperature.m
//  PagerWeather
//
//  Created by Hernandez Garcia, Ricardo(AWF) on 1/26/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Temperature.h"

@interface testTemperature : XCTestCase
@property (nonatomic, strong) Temperature *testTemperature;
@end

@implementation testTemperature

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitWithEmptyDictionary
{
    //should not crash with empty dict
    self.testTemperature = [[Temperature alloc] initWithDictionary:@{}];
    XCTAssertNotNil(self.testTemperature);
}

@end
