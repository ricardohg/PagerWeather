//
//  testUser.m
//  PagerWeather
//
//  Created by Hernandez Garcia, Ricardo(AWF) on 1/26/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "User.h"

@interface UserTest : XCTestCase

@property (nonatomic, strong) User *testUser;

@end

@implementation UserTest

- (void)setUp {
    [super setUp];
    self.testUser = [User sharedUser];
}

- (void)tearDown {
    [super tearDown];
    self.testUser = nil;
}

- (void)testUserNotNil
{
    XCTAssertNotNil(self.testUser);
}

- (void)testUpdateTemperature
{
    [self.testUser updateTemperatureOption:YES];
    self.testUser = nil;
    self.testUser = [User sharedUser];
    XCTAssertTrue(self.testUser.isFahrenheitSelected);
}

@end
