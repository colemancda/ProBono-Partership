//
//  PBPOpportunityViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPOpportunityViewController.h"
#import "PBPOpportunityTableViewController.h"
#import "ProBonoRequestActivity.h"

@interface PBPOpportunityViewController ()

@end

@implementation PBPOpportunityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embeddedOpportunityTableVC"]) {
        
        _tableVC = segue.destinationViewController;
        
        _tableVC.opportunity = self.opportunity;
        
    }
}

#pragma mark - Actions

-(void)actionButton:(id)sender
{
    ProBonoRequestActivity *requestActivity = [[ProBonoRequestActivity alloc] init];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.tableVC.opportunity] applicationActivities:@[requestActivity]];
    
    [self presentViewController:activityVC animated:YES completion:^{
       
        
        
    }];
}

@end
