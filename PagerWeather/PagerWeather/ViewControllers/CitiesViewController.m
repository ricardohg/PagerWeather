//
//  CitiesViewController.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "CitiesViewController.h"
#import "CitiesCollectionViewCell.h"
#import "City.h"

static NSString * const CELL_REUSE_ID = @"CitiesCollectionViewCell";

@interface CitiesViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *citiesCollectionView;
@property (nonatomic, strong) NSArray * citiesArray;
@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.citiesCollectionView.dataSource = self;
    self.citiesCollectionView.delegate = self;
    self.citiesArray = [City getCities];
    [self.citiesCollectionView registerNib:[UINib nibWithNibName:CELL_REUSE_ID bundle:nil] forCellWithReuseIdentifier:CELL_REUSE_ID];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.citiesArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CitiesCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_REUSE_ID forIndexPath:indexPath];
    City *city = self.citiesArray[indexPath.row];
    [cell setCellDataWithCity:city];
    
    return cell;
}

@end
