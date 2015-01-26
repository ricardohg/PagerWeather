//
//  WeatherHeaderView.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/24/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "WeatherHeaderView.h"
#import <UIImageView+AFNetworking.h>
#import "UIColor+Weather.h"

@interface WeatherHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@end

@implementation WeatherHeaderView

- (void)awakeFromNib {
    self.weatherDescriptionLabel.clipsToBounds = YES;
    self.mainTemperatureLabel.textColor = [UIColor headerLabelTextColor];
    self.minMaxTemperatureLabel.textColor = [UIColor headerLabelTextColor];
    self.weatherDescriptionLabel.textColor = [UIColor headerLabelTextColor];
    self.countryCodeLabel.textColor = [UIColor headerLabelTextColor];
    self.cityLabel.textColor = [UIColor headerLabelTextColor];
}

- (void)setImageWithUrl:(NSURL *)url andPlaceHolder:(UIImage *)placeholderImage
{
    [self.weatherImageView setImageWithURL:url placeholderImage:placeholderImage];
}

@end
