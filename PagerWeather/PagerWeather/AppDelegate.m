//
//  AppDelegate.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherDetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.homeViewController = [[WeatherDetailViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.window.rootViewController = self.homeViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
