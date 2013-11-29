//
//  PBPSettingsViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/26/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPSettingsViewController.h"

NSString* const PBPStatesPreferenceKey = @"PBPStatesPreferenceKey";

NSString* const PBPCategoryPreferenceKey = @"PBPCategoryPreferenceKey";

NSString* const PBPFirstNamePreferenceKey = @"PBPFirstNamePreferenceKey";

NSString* const PBPLastNamePreferenceKey = @"PBPLastNamePreferenceKey";

NSString* const PBPEmailPreferenceKey = @"PBPEmailPreferenceKey";

NSString* const PBPPreferredStatesPreferenceKey = @"PBPPreferredStatesPreferenceKey";

NSString* const PBPPreferredCategoriesPreferenceKey = @"PBPPreferredCategoriesPreferenceKey";

NSString* const PBPOpportunitiesSortingPreferenceKey = @"PBPOpportunitiesSortingPreferenceKey";

@interface PBPSettingsViewController ()

@end

@implementation PBPSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
