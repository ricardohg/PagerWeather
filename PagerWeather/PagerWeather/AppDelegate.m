//
//  AppDelegate.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherDetailViewController.h"
#import "UIColor+Weather.h"
#import <AFNetworkActivityIndicatorManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.weatherDetailViewController = [[WeatherDetailViewController alloc] initWithNibName:@"WeatherDetailViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.weatherDetailViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    [self setUpNavigationBar];
    return YES;
}

- (void)setUpNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationBarBarTintColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor navigationBarTintColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor navigationBarTextColor], NSForegroundColorAttributeName,nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

@end
