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

@interface WeatherDetailViewController ()

@end

@implementation WeatherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBarButtonItems];
}

#pragma mark - instance methods

- (void)setUpNavigationBarButtonItems
{
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cities", nil) style:UIBarButtonItemStylePlain target:self action:@selector(goToCities:)];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Settings", nil) style:UIBarButtonItemStylePlain target:self action:@selector(goToSettings:)];
    
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
}

- (void)goToCities:(id)sel
{
    CitiesViewController *citiesViewController = [[CitiesViewController alloc] init];
    [self.navigationController pushViewController:citiesViewController animated:YES];
}

- (void)goToSettings:(id)sel
{
    SettingsViewController * settingsViewController = [[SettingsViewController alloc] init];
    UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    [self.navigationController presentViewController:settingsNavigationController animated:YES completion:nil];
    
}

@end
