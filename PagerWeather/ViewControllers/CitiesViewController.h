//
//  CitiesViewController.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class City;
@protocol CitiesViewControllerDelegate <NSObject>

- (void)didSelectCity:(City*)city;

@end

@interface CitiesViewController : UIViewController
@property (nonatomic, weak) id<CitiesViewControllerDelegate>delegate;
@end
