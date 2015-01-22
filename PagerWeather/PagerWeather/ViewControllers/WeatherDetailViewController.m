//
//  HomeViewController.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "CitiesViewController.h"
#import "SettingsViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Weather+API.h"
#import "City.h"
#import "AnimationController.h"

@interface WeatherDetailViewController () <CLLocationManagerDelegate,CitiesViewControllerDelegate,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) NSArray *weatherArray;
@property (nonatomic, strong) City *currentCity;
@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self setUpNavigationBarButtonItems];
    [self startLocationManager];
}

#pragma mark - instance methods

- (void)setUpNavigationBarButtonItems
{
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cities", nil) style:UIBarButtonItemStylePlain target:self action:@selector(goToCities:)];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Settings", nil) style:UIBarButtonItemStylePlain target:self action:@selector(goToSettings:)];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
}

- (void)startLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        ) {
        [self.locationManager requestWhenInUseAuthorization];
    } else {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)loadWeatherData
{
    NSString *cityString = @"New York";
    if (self.currentLocation) {
        cityString = nil;
    }
    
    NSNumber *latitude = @(self.currentLocation.coordinate.latitude);
    NSNumber *longitude = @(self.currentLocation.coordinate.longitude);
    
    [Weather getWeatherForCityName:cityString orLatitude:latitude longitude:longitude withCompletionBlock:^(Weather *weather, NSError *error) {
        
        if (!error) {
            self.currentWeather = weather;
        }
        
    }];
    
    [Weather getForecastForCityName:cityString orLatitude:latitude longitude:longitude AndNumberOfDays:@(2) withCompletionBlock:^(NSArray *weatherArray, NSError *error) {
        
        if (!error) {
            self.weatherArray = weatherArray;
        }
        
    }];
    
   
}

- (void)goToCities:(id)sel
{
    CitiesViewController *citiesViewController = [[CitiesViewController alloc] init];
    citiesViewController.delegate = self;
    [self.navigationController pushViewController:citiesViewController animated:YES];
}

- (void)goToSettings:(id)sel
{
    SettingsViewController * settingsViewController = [[SettingsViewController alloc] init];
    UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    settingsNavigationController.modalPresentationStyle = UIModalPresentationCustom;
    settingsNavigationController.transitioningDelegate = self;
    [self.navigationController presentViewController:settingsNavigationController animated:YES completion:nil];
    
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = locations[0];
    [self.locationManager stopUpdatingLocation];
    [self loadWeatherData];
    
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"User still thinking");
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"Not autorized");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [self.locationManager startUpdatingLocation];
        } break;
        default:
            break;
    }
}

#pragma mark - CitiesViewControllerDelegate

- (void)didSelectCity:(City *)city
{
    self.currentCity = city;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{

    AnimationController *animationController = [[AnimationController alloc] initWithAnimationType:AnimationControllerAnimationTypeSimple];
    animationController.options = (  operation == UINavigationControllerOperationPush
                                   ? UIViewAnimationOptionTransitionFlipFromRight
                                   : UIViewAnimationOptionTransitionFlipFromLeft);
    
    return animationController;

}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[AnimationController alloc] initWithAnimationType:AnimationControllerAnimationTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[AnimationController alloc] initWithAnimationType:AnimationControllerAnimationTypeDismiss];
}

@end
