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
#import "WeatherHeaderView.h"
#import "OpenWeatherMapHTTPOperationManager.h"

static NSString * const FORECASTCELL_ID = @"ForecastTableViewCell";
static NSString * const HOUR_DATE_FORMATTER_STRING = @"HH:mm";
static NSString * const DAY_DATE_FORMATTER_STRING = @"EEEE";
static NSString * const WEATHER_HEADER_VIEW_PATH = @"WeatherHeaderView";
static NSString * const DEFAULT_CITY_STRING = @"New York";
static NSString * const CITY_PLACEHOLDER_IMAGE_PATH = @"cityplaceholder";
static NSDateFormatter *hourDateFormatter;
static NSDateFormatter *dayDateFormatter;
static NSNumberFormatter *numberFormatter;

typedef NS_ENUM(NSInteger, WeatherTableViewSection) {
    WeatherTableViewSectionForecast
};

@interface WeatherDetailViewController () <CLLocationManagerDelegate,CitiesViewControllerDelegate,UIViewControllerTransitioningDelegate,UITableViewDelegate,UITableViewDataSource,SettingsViewControllerDelagete>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) NSArray *weatherArray;
@property (nonatomic, strong) City *currentCity;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, weak) IBOutlet UITableView *weatherTableView;
@property (nonatomic, strong) WeatherHeaderView * weatherHeaderView;
@end

@implementation WeatherDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentUser = [User sharedUser];
    self.currentCity = [City searchForCityWithString:DEFAULT_CITY_STRING];
    self.weatherTableView.delegate = self;
    self.weatherTableView.dataSource = self;
    self.weatherTableView.tableFooterView = [[UIView alloc] init];
    [self.weatherTableView registerNib:[UINib nibWithNibName:FORECASTCELL_ID bundle:nil] forCellReuseIdentifier:FORECASTCELL_ID];
    self.weatherHeaderView = [[[NSBundle mainBundle] loadNibNamed:WEATHER_HEADER_VIEW_PATH owner:self options:nil] objectAtIndex:0];
    [self setUpFormatters];
    [self setUpNavigationBarButtonItems];
    [self startLocationManager];
    [self loadWeatherData];
}

- (void)viewDidLayoutSubviews
{
    self.weatherHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.weatherTableView.frame), CGRectGetWidth(self.weatherTableView.frame));
    self.weatherTableView.tableHeaderView = self.weatherHeaderView;
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
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStylePlain target:self action:@selector(goToSettings:)];
    
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

- (void)setUpHeader
{
    Weather *weather = self.currentWeather;
    NSString *suffixString = [self getTemperatureSuffixString];
    self.weatherHeaderView.mainTemperatureLabel.text = [NSString stringWithFormat:@"%@ %@",[numberFormatter stringFromNumber:weather.temperature.mainTemparetureNumber],suffixString];
    NSString *minTempString = [NSString stringWithFormat:@"%@ %@",[numberFormatter stringFromNumber:weather.temperature.minTempratureNumber],suffixString];
    NSString *maxTempString = [NSString stringWithFormat:@"%@ %@",[numberFormatter stringFromNumber:weather.temperature.maxTemperatureNumber],suffixString];
    self.weatherHeaderView.minMaxTemperatureLabel.text = [NSString stringWithFormat:@"%@ / %@",minTempString,maxTempString];
    self.weatherHeaderView.countryCodeLabel.text = weather.countryCodeString;
    self.weatherHeaderView.cityLabel.text = weather.cityNameString;
    self.weatherHeaderView.weatherDescriptionLabel.text = weather.weatherDescriptionString;
    
    [self.weatherHeaderView setImageWithUrl:self.currentCity.imageUrl andPlaceHolder:[UIImage imageNamed:CITY_PLACEHOLDER_IMAGE_PATH]];
    
}

- (void)loadWeatherData
{
    
    NSString *cityString = nil;
    
    if (self.currentCity) {
        cityString = self.currentCity.cityString;
    } else if (self.currentLocation) {
        cityString = nil;
    }
    
    NSNumber *latitude = @(self.currentLocation.coordinate.latitude);
    NSNumber *longitude = @(self.currentLocation.coordinate.longitude);
    
    WeatherUnitsFormat format = self.currentUser.isFahrenheitSelected ? WeatherUnitsFormatImperial : WeatherUnitsFormatMetric;
    
    [Weather getWeatherForCityName:cityString orLatitude:latitude longitude:longitude withWeatherUnitsFormat:format withCompletionBlock:^(Weather *weather, NSError *error) {
        if (!error) {
            if (weather) {
                self.currentWeather = weather;
                [self setUpHeader];
            } else {
                UIAlertController * alertController = [UIAlertController
                                                       alertControllerWithTitle:@"Weather"
                                                       message:NSLocalizedString(@"Sorry, can't find weather for that city",nil)
                                                       preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alertController animated:YES completion:nil];
                
                UIAlertAction* okAction = [UIAlertAction
                                     actionWithTitle:NSLocalizedString(@"OK", nil)
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alertController dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                [alertController addAction:okAction];
            }
           
        } else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    
    [Weather getForecastForCityName:cityString orLatitude:latitude longitude:longitude withWeatherUnitsFormat:format withCompletionBlock:^(NSArray *weatherArray, NSError *error) {
        if (!error) {
            if (weatherArray) {
                if (weatherArray.count > 0) {
                    NSMutableArray * weatherMutableArray = [weatherArray mutableCopy];
                    [weatherMutableArray removeObjectAtIndex:0];
                    self.weatherArray = [weatherArray copy];
                } else {
                    self.weatherArray = nil;
                }
                [self.weatherTableView reloadData];
            }
        } else {
            NSLog(@"%@",error.localizedDescription);
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
    settingsViewController.delegate = self;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == WeatherTableViewSectionForecast && self.weatherArray.count) {
        return NSLocalizedString(@"Forecast for next hours", nil);
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == WeatherTableViewSectionForecast) {
            return [ForecastTableViewCell heightForCell];
    } else {
        return 0;
    }
    
    return 0;
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (!self.currentLocation) {
        [[[OpenWeatherMapHTTPOperationManager sharedManager] operationQueue] cancelAllOperations];
        self.currentLocation = locations[0];
        self.currentCity = nil;
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
    [self loadWeatherData];
}

#pragma mark - SettingsViewControllerDelagete

-(void)temperatureSettingDidChange {
    [self loadWeatherData];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[AnimationController alloc] initWithAnimationType:AnimationControllerAnimationTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[AnimationController alloc] initWithAnimationType:AnimationControllerAnimationTypeDismiss];
}

@end
