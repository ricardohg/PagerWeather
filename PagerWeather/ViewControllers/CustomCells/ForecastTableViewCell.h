//
//  ForecastTableViewCell.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/22/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Weather;

@interface ForecastTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

+ (CGFloat)heightForCell;

@end
