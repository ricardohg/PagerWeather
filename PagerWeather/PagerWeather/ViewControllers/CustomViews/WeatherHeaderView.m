//
//  WeatherHeaderView.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/24/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "WeatherHeaderView.h"
#import <UIImageView+AFNetworking.h>

@interface WeatherHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@end

@implementation WeatherHeaderView

- (void)setImageWithUrl:(NSURL *)url andPlaceHolder:(UIImage *)placeholderImage
{
    [self.weatherImageView setImageWithURL:url placeholderImage:placeholderImage];
}

@end
