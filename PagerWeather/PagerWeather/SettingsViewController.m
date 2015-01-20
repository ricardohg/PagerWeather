//
//  SettingsViewController.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Close", nil) style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
        
        self.navigationItem.leftBarButtonItem = leftButtonItem;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - instance methods

- (void)dismiss:(id)sel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
