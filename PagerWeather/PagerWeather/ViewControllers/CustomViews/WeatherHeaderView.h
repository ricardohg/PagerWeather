//
//  WeatherHeaderView.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/24/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *mainTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

- (void)setImageWithUrl:(NSURL*)url andPlaceHolder:(UIImage*)placeholderImage;

@end
