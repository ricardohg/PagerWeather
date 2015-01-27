//
//  testWeatherDetailViewController.m
//  PagerWeather
//
//  Created by Hernandez Garcia, Ricardo(AWF) on 1/26/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "WeatherDetailViewController.h"
#import "SettingsViewController.h"
#import "CitiesViewController.h"

@interface WeatherDetailViewController () <UITableViewDelegate,UITableViewDataSource, UINavigationBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *weatherTableView;
- (void)goToSettings:(id)sel;
- (void)goToCities:(id)sel;

@end

@interface WeatherDetailViewControllerTest : XCTestCase
@property (nonatomic,strong) WeatherDetailViewController *testWeatherDetailViewController;
@end

@implementation WeatherDetailViewControllerTest

- (void)setUp {
    [super setUp];
    self.testWeatherDetailViewController = [[WeatherDetailViewController alloc] init];
    [self.testWeatherDetailViewController loadView];
}

- (void)tearDown {
    self.testWeatherDetailViewController = nil;
    [super tearDown];
}

- (void)testProperties {
    XCTAssertTrue(self.testWeatherDetailViewController.weatherTableView);
}

#pragma mark - Test TableViewData

- (void)testNumberOfSecionsInTableView {
    XCTAssertTrue([self.testWeatherDetailViewController numberOfSectionsInTableView:nil] == 1);
}

#pragma mark - Test TableViewDelegate

- (void)testHeightForRowAtIndexPath {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    XCTAssertTrue([self.testWeatherDetailViewController tableView:nil heightForRowAtIndexPath:indexPath] == 72.0);
}

#pragma mark - Test Show Settings

- (void)testShowSettings {
    
    id mockViewController = [OCMockObject partialMockForObject:self.testWeatherDetailViewController];
    OCMExpect([[mockViewController navigationController] presentViewController:OCMOCK_ANY animated:YES completion:nil]);
    [self.testWeatherDetailViewController goToSettings:nil];
    
    [mockViewController verify];
    
}

#pragma mark - Test Go To Cities

- (void)testGoToCities {
    id mockViewController = [OCMockObject partialMockForObject:self.testWeatherDetailViewController];
    OCMExpect([[mockViewController navigationController] pushViewController:OCMOCK_ANY animated:YES]);
    [self.testWeatherDetailViewController goToSettings:nil];
    
    [mockViewController verify];
    
}

@end
