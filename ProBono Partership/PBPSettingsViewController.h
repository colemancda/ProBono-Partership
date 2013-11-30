//
//  PBPSettingsViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/26/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const PBPFirstNamePreferenceKey;

extern NSString* const PBPLastNamePreferenceKey;

extern NSString* const PBPEmailPreferenceKey;

extern NSString* const PBPPhoneNumberPreferenceKey;

extern NSString* const PBPFirmPreferenceKey;

extern NSString* const PBPPreferredStatesPreferenceKey;

extern NSString* const PBPPreferredCategoriesPreferenceKey;

extern NSString* const PBPOpportunitiesSortingPreferenceKey;

typedef NS_ENUM(NSUInteger, PBPOpportunitiesSorting) {
    
    PBPOpportunitiesSortingByCategory,
    PBPOpportunitiesSortingByLocation
    
};

@interface PBPSettingsViewController : UITableViewController <UITextFieldDelegate>

#pragma mark - UI

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *firmTextField;

@property (weak, nonatomic) IBOutlet UILabel *statesLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingSegmentedControl;

#pragma mark - UI Refreshing

-(void)loadUIFromPreferences;

-(void)loadOpportunitiesFiltering;

#pragma mark - Actions

-(IBAction)sortingChanged:(UISegmentedControl *)sender;

@end
