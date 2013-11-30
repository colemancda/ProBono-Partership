//
//  PBPOpportunityTableViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PBPOpportunity;

@interface PBPOpportunityTableViewController : UITableViewController

@property (readonly) PBPOpportunity *opportunity;

-(void)loadOpportunity:(PBPOpportunity *)opportunity;

#pragma mark - UI



@end
