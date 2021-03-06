//
//  PBPSettingsViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/26/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPSettingsViewController.h"

NSString* const PBPFirstNamePreferenceKey = @"FirstName";

NSString* const PBPLastNamePreferenceKey = @"LastName";

NSString* const PBPPhoneNumberPreferenceKey = @"PhoneNumber";

NSString* const PBPFirmPreferenceKey = @"Firm";

NSString* const PBPPreferredStatesPreferenceKey = @"PreferredStates";

NSString* const PBPPreferredCategoriesPreferenceKey = @"PreferredCategories";

NSString* const PBPOpportunitiesSortingPreferenceKey = @"OpportunitiesSorting";

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

    [self loadUIFromPreferences];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadUIFromPreferences];
    
}

#pragma mark - TextField Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    // save value of text field to NSUserPreferences
    
    NSString *key;
    
    if (textField == self.firstNameTextField) {
        
        key = PBPFirstNamePreferenceKey;
    }
    
    if (textField == self.lastNameTextField) {
        
        key = PBPLastNamePreferenceKey;
    }
    
    if (textField == self.phoneNumberTextField) {
        
        key = PBPPhoneNumberPreferenceKey;
    }
    
    if (textField == self.firmTextField) {
        
        key = PBPFirmPreferenceKey;
    }
    
    assert(key);
    
    [[NSUserDefaults standardUserDefaults] setObject:textField.text
                                              forKey:key];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark

-(void)loadUIFromPreferences
{
    // load user preferences for text fields
    self.firstNameTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:PBPFirstNamePreferenceKey];
    
    self.lastNameTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:PBPLastNamePreferenceKey];
        
    self.phoneNumberTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:PBPPhoneNumberPreferenceKey];
    
    self.firmTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:PBPFirmPreferenceKey];
    
    // load filtering
    
    [self loadOpportunitiesFiltering];
    
    // load sorting
    
    PBPOpportunitiesSorting sorting = [[NSUserDefaults standardUserDefaults] integerForKey:PBPOpportunitiesSortingPreferenceKey];
    
    [self.sortingSegmentedControl setSelectedSegmentIndex:sorting];
    
}

-(void)loadOpportunitiesFiltering
{
    NSArray *preferredCategories = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredCategoriesPreferenceKey];
    
    // change categories label to selected categories
    if (preferredCategories.count) {
        
        self.categoriesLabel.text = NSLocalizedString(@"Selected Categories",
                                                      @"Selected Categories");
        
    }
    else {
        
        self.categoriesLabel.text = NSLocalizedString(@"All Categories",
                                                      @"All Categories");
        
    }
    
    NSArray *preferredStates = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredStatesPreferenceKey];
    
    // change preferred states label
    if (preferredStates.count) {
        
        self.statesLabel.text = NSLocalizedString(@"Selected States",
                                                  @"Selected States");
        
    }
    else {
        
        self.statesLabel.text = NSLocalizedString(@"All States",
                                                  @"All States");
    }
    
}

#pragma mark - Actions

-(void)sortingChanged:(UISegmentedControl *)sender
{
    // save value
    
    [[NSUserDefaults standardUserDefaults] setInteger:sender.selectedSegmentIndex
                                               forKey:PBPOpportunitiesSortingPreferenceKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
