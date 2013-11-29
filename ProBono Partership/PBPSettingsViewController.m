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

NSString* const PBPEmailPreferenceKey = @"Email";

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

#pragma mark - Segue

-(void)unwindToSettingsVC:(UIStoryboardSegue *)segue
{
    
    
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
    
    if (textField == self.emailTextField) {
        
        key = PBPEmailPreferenceKey;
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
    
    self.emailTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:PBPEmailPreferenceKey];
    
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
        
        
        
    }
    
    NSArray *preferredStates = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredStatesPreferenceKey];
    
    // change preferred states label
    if (preferredStates.count) {
        
        
        
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
