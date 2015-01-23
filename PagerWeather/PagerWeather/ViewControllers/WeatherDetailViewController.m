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
#import "ForecastTableViewCell.h"
#import "User.h"
#import "Temperature.h"

static NSString * const FORECASTCELL_ID = @"ForecastTableViewCell";
static NSString * const HOUR_DATE_FORMATTER_STRING = @"HH:mm:ss";
static NSString * const DAY_DATE_FORMATTER_STRING = @"EEEE";
static NSDateFormatter *hourDateFormatter;
static NSDateFormatter *dayDateFormatter;
static NSNumberFormatter *numberFormatter;

@interface WeatherDetailViewController () <CLLocationManagerDelegate,CitiesViewControllerDelegate,UIViewControllerTransitioningDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) NSArray *weatherArray;
@property (nonatomic, strong) City *currentCity;
@property (nonatomic, strong) User *currentUser;
@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;
@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [User sharedUser];
    self.weatherTableView.delegate = self;
    self.weatherTableView.dataSource = self;
    [self.weatherTableView registerNib:[UINib nibWithNibName:FORECASTCELL_ID bundle:nil] forCellReuseIdentifier:FORECASTCELL_ID];
    [self setUpFormatters];
    [self setUpNavigationBarButtonItems];
    [self startLocationManager];
}

#pragma mark - instance methods

- (void)setUpFormatters
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    hourDateFormatter = [[NSDateFormatter alloc] init];
    [hourDateFormatter setLocale:currentLocale];
    [hourDateFormatter setDateFormat:HOUR_DATE_FORMATTER_STRING];
    
    dayDateFormatter = [[NSDateFormatter alloc] init];
    [dayDateFormatter setLocale:currentLocale];
    [dayDateFormatter setDateFormat:DAY_DATE_FORMATTER_STRING];
    numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [numberFormatter setMaximumFractionDigits:0];

    
}

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
    
    WeatherUnitsFormat format = self.currentUser.isFahrenheitSelected ? WeatherUnitsFormatImperial : WeatherUnitsFormatMetric;
    
    [Weather getForecastForCityName:cityString orLatitude:latitude longitude:longitude AndNumberOfDays:@(5) withWeatherUnitsFormat:format withCompletionBlock:^(NSArray *weatherArray, NSError *error) {
        if (!error) {
            self.weatherArray = weatherArray;
            [self.weatherTableView reloadData];
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
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    settingsNavigationController.modalPresentationStyle = UIModalPresentationCustom;
    settingsNavigationController.transitioningDelegate = self;
    [self.navigationController presentViewController:settingsNavigationController animated:YES completion:nil];
    
}

- (NSString*)getTemperatureSuffixString
{
    return self.currentUser.isFahrenheitSelected ? @"F" : @"º";
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weatherArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FORECASTCELL_ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Weather *weather = self.weatherArray[indexPath.row];
    NSString * suffixString = [self getTemperatureSuffixString];
    cell.temperatureLabel.text = [NSString stringWithFormat:@"%@ %@",[numberFormatter stringFromNumber:weather.temperature.mainTemparetureNumber],suffixString];
    cell.timeLabel.text = [hourDateFormatter stringFromDate:weather.timeDate];
    cell.dateLabel.text = [dayDateFormatter stringFromDate:weather.timeDate];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ForecastTableViewCell heightForCell];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!self.currentLocation) {
        self.currentLocation = locations[0];
        [self.locationManager stopUpdatingLocation];
        [self loadWeatherData];
    }
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

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[AnimationController alloc] initWithAnimationType:AnimationControllerAnimationTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[AnimationController alloc] initWithAnimationType:AnimationControllerAnimationTypeDismiss];
}

@end
