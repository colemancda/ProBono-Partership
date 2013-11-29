//
//  PBPOpportunitiesTableViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/28/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBPSettingsViewController.h"

@interface PBPOpportunitiesTableViewController : UITableViewController
{
    NSMutableArray *_opportunities;
}

@property PBPOpportunitiesSorting sorting;

-(void)loadOpportunities:(NSArray *)opportunities;

@end
