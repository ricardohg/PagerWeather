//
//  SettingsViewController.m
//  PagerWeather
//
//  Created by ricardo hernandez on 1/19/15.
//  Copyright (c) 2015 ricardo. All rights reserved.
//

#import "SettingsViewController.h"
#import "User.h"

typedef NS_ENUM(NSInteger, SettingsTableViewSection) {
    SettingsTableViewSectionTemperature,
    SettingsTableViewSectionCount
};

typedef NS_ENUM(NSInteger, SettingsTableViewTemperatureRow) {
    SettingsTableViewTemperatureRowFahrenheit,
    SettingsTableViewTemperatureRowCount
};

@interface SettingsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *settingsTableView;
@property (nonatomic, assign) BOOL temperatureCurrentSetting;
@property (nonatomic, strong) User *currentUser;
@end

@implementation SettingsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Close", nil) style:UIBarButtonItemStylePlain target:self action:@selector(dismissMe:)];
        self.navigationItem.leftBarButtonItem = leftButtonItem;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Settings", nil);
    self.settingsTableView.dataSource = self;
    self.settingsTableView.delegate = self;
    self.currentUser = [User sharedUser];
    self.temperatureCurrentSetting = self.currentUser.isFahrenheitSelected;
    //hack to remove extra tableview lines
    self.settingsTableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - instance methods

- (void)dismissMe:(id)sel
{
    if (self.currentUser.isFahrenheitSelected != self.temperatureCurrentSetting) {
        if ([self.delegate respondsToSelector:@selector(temperatureSettingDidChange)]) {
            [self. delegate temperatureSettingDidChange];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SettingsTableViewSectionCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case SettingsTableViewSectionTemperature: {
            return SettingsTableViewTemperatureRowCount;
        }
        break;
            
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case SettingsTableViewSectionTemperature: {
            
            switch (indexPath.row) {
                case SettingsTableViewTemperatureRowFahrenheit: {
                    
                    static NSString *cellIdentifier = @"Cell";
                    
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                        //add a switch
                        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
                        switchview.tag = indexPath.row;
                        switchview.on = self.currentUser.isFahrenheitSelected;
                        [switchview addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventTouchUpInside];
                        cell.accessoryView = switchview;
                    }
                    
                    cell.textLabel.text = NSLocalizedString(@"Show Temperature in Fahrenheit?", nil);
                    return cell;
                    
                }
                    
                    break;
                    
                default:
                    break;
            }
           
            
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)updateSwitch:(UISwitch*)aSwitch
{
    switch (aSwitch.tag) {
        case SettingsTableViewTemperatureRowFahrenheit: {
         
            BOOL isFahrenheitSelected = aSwitch.isOn;
            [self.currentUser updateTemperatureOption:isFahrenheitSelected];
        }
            
            break;
            
        default:
            break;
    }
    
}

@end
