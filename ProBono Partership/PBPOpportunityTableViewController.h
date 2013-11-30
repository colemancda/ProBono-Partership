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

@property PBPOpportunity *opportunity;

#pragma mark - UI

@property (weak, nonatomic) IBOutlet UILabel *matterNumberTextField;

@property (weak, nonatomic) IBOutlet UILabel *clientTextField;

@property (weak, nonatomic) IBOutlet UILabel *cityTextField;

@property (weak, nonatomic) IBOutlet UILabel *stateTextField;

@property (weak, nonatomic) IBOutlet UILabel *categoryTextField;

@property (weak, nonatomic) IBOutlet UILabel *workTextField;

@property (weak, nonatomic) IBOutlet UIWebView *missionWebView;

-(void)loadUI;

@end
