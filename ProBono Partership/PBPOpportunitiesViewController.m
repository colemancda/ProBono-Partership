//
//  PBPOpportunitiesViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/26/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPOpportunitiesViewController.h"
#import "PBPStore.h"
#import "NSError+presentError.h"
#import "PBPOpportunitiesTableViewController.h"


@interface PBPOpportunitiesViewController ()

@end

@implementation PBPOpportunitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableVC.view.hidden = YES;
    
    // get categories
    [[PBPStore sharedStore] getCategories:^(NSError *error, NSArray *categories) {
       
        if (error) {
            
            self.label.hidden = YES;
            
            self.tableVC.view.hidden = NO;
            
            [error presentError];
            
            return;
        }
        
        // get opportunities
        [[PBPStore sharedStore] getOpportunitiesWithParameters:@{} completion:^(NSError *error, NSArray *opportunities) {
            
            self.label.hidden = YES;
            
            self.tableVC.view.hidden = NO;
            
            if (error) {
                
                [error presentError];
                
                return;
            }
            
            [self.tableVC loadOpportunities:opportunities];
            
        }];
    }];
}

#pragma mark

-(void)downloadAndRefresh:(id)sender
{
    
    
    
}

#pragma mark - Actions

-(void)activityAction:(id)sender
{
    
    
    
}

#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embeddedOpportunitiesTableVC"]) {
        
        _tableVC = segue.destinationViewController;
        
    }
    
}

@end
