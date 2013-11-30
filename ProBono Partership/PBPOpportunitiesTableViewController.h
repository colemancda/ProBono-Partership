//
//  PBPOpportunitiesTableViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/28/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBPSettingsViewController.h"

@interface PBPOpportunitiesTableViewController : UITableViewController <UIWebViewDelegate>
{
    NSMutableArray *_groupedOpportunities;
}

@property (readonly) PBPOpportunitiesSorting sorting;

@property (readonly) NSArray *opportunities;

-(void)loadOpportunities:(NSArray *)opportunities
                 sorting:(PBPOpportunitiesSorting)sorting;

@end
