//
//  CitiesCollectionViewCell.h
//  PagerWeather
//
//  Created by ricardo hernandez on 1/20/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class City;

@interface CitiesCollectionViewCell : UICollectionViewCell

- (void)setCellDataWithCity:(City*)city;

@end
