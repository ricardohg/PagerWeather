//
//  AppDelegate.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherDetailViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) WeatherDetailViewController *weatherDetailViewController;

@end

