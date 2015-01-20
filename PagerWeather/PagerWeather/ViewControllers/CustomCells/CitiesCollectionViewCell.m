//
//  CitiesCollectionViewCell.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "CitiesCollectionViewCell.h"
#import "City.h"
#import <UIImageView+AFNetworking.h>

@interface CitiesCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cityImageView;

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@end

@implementation CitiesCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellDataWithCity:(City *)city
{
    [self.cityImageView setImageWithURL:city.imageUrl placeholderImage:nil];
    self.countryLabel.text = city.countryString;
    self.cityLabel.text = city.cityString;
}

@end
