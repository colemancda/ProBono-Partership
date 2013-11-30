//
//  PBPOpportunityViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PBPOpportunity, PBPOpportunityTableViewController;

@interface PBPOpportunityViewController : UIViewController

@property (readonly) PBPOpportunityTableViewController *tableVC;

-(IBAction)actionButton:(id)sender;

@end
