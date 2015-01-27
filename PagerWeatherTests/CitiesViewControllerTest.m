//
//  CitiesViewControllerTest.m
//  PagerWeather
//
//  Created by Hernandez Garcia, Ricardo(AWF) on 1/26/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock.h>
#import "CitiesViewController.h"

@interface CitiesViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *citiesCollectionView;
@end

@interface CitiesViewControllerTest : XCTestCase
@property (nonatomic, strong) CitiesViewController *testCitiesViewController;
@end

@implementation CitiesViewControllerTest

- (void)setUp {
    [super setUp];
    self.testCitiesViewController = [[CitiesViewController alloc] init];
    [self.testCitiesViewController loadView];
}

- (void)tearDown {
    self.testCitiesViewController = nil;
    [super tearDown];
}

- (void)testProperties {
    XCTAssertNotNil(self.testCitiesViewController.citiesCollectionView);
}

#pragma mark - Test UICollectionViewDelegate

- (void)testDidSelectSelectAtIndexPath {
    
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(CitiesViewControllerDelegate)];
    self.testCitiesViewController.delegate = mockDelegate;
    
    OCMExpect([mockDelegate didSelectCity:nil]);
    
       NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.testCitiesViewController collectionView:nil didSelectItemAtIndexPath:indexPath];
    [mockDelegate verify];
}

@end
