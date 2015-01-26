//
//  SettingsViewController.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelagete <NSObject>

@optional
- (void)temperatureSettingDidChange;

@end

@interface SettingsViewController : UIViewController
@property (nonatomic, weak) id<SettingsViewControllerDelagete>delegate;
@end
