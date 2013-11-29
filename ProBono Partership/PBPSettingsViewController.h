//
//  PBPSettingsViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/26/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const PBPStatesPreferenceKey;

extern NSString* const PBPCategoryPreferenceKey;

extern NSString* const PBPFirstNamePreferenceKey;

extern NSString* const PBPLastNamePreferenceKey;

extern NSString* const PBPEmailPreferenceKey;

extern NSString* const PBPPreferredStatesPreferenceKey;

extern NSString* const PBPPreferredCategoriesPreferenceKey;

extern NSString* const PBPOpportunitiesSortingPreferenceKey;

@interface PBPSettingsViewController : UITableViewController

#pragma mark - Segue

-(IBAction)unwindToSettingsVC:(UIStoryboardSegue *)segue;

#pragma mark - UI

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UILabel *statesLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingSegmentedControl;

#pragma mark

@end
