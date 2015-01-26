//
//  ForecastTableViewCell.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/22/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "ForecastTableViewCell.h"
#import "Weather.h"
#import "UIColor+Weather.h"

static CGFloat HEIGHTFORCELL = 72.0f;

@interface ForecastTableViewCell ()

@end

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.dateLabel.textColor = [UIColor cellLabelTextColor];
    self.timeLabel.textColor = [UIColor cellLabelTextColor];
    self.temperatureLabel.textColor = [UIColor cellLabelTextColor];
}

+ (CGFloat)heightForCell
{
    return HEIGHTFORCELL;
}

@end
