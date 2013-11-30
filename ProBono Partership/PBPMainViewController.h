//
//  PBPMainViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/9/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PBPOpportunitiesViewController;

@interface PBPMainViewController : UIViewController

@property (readonly) PBPOpportunitiesViewController *opportunitiesVC;

-(IBAction)unwindToMainVC:(UIStoryboardSegue *)segue;

#pragma mark - Actions

-(IBAction)activityAction:(id)sender;

@end
