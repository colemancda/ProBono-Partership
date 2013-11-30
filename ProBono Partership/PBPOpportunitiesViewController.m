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
#import "PBPAPI.h"

@interface PBPOpportunitiesViewController ()

@end

@implementation PBPOpportunitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self downloadAndLoad:nil];
}

#pragma mark

-(void)downloadAndRefresh:(id)sender
{
    
    
    
}

-(void)downloadAndLoad:(id)sender
{
    // get sorting
    
    PBPOpportunitiesSorting sorting = [[NSUserDefaults standardUserDefaults] integerForKey:PBPOpportunitiesSortingPreferenceKey];
    
    // parameters
    
    NSArray *preferredCategories = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredCategoriesPreferenceKey];
    
    NSArray *preferredStates = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredStatesPreferenceKey];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    if (preferredCategories.count) {
        
        [parameters addEntriesFromDictionary:@{PBPAPIOpportunitiesCategoryParameter: preferredCategories}];
    }
    
    if (preferredStates.count) {
        
        [parameters addEntriesFromDictionary:@{PBPAPIOpportunitiesStateParameter: preferredStates}];
    }
    
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
        [[PBPStore sharedStore] getOpportunitiesWithParameters:parameters completion:^(NSError *error, NSArray *opportunities) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                self.label.hidden = YES;
                
                self.tableVC.view.hidden = NO;
                
            }];
            
            
            if (error) {
                
                [error presentError];
                
                return;
            }
            
            [self.tableVC loadOpportunities:opportunities
                                    sorting:sorting];
            
        }];
    }];
    
    
}

#pragma mark

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embeddedOpportunitiesTableVC"]) {
        
        _tableVC = segue.destinationViewController;
        
        [_tableVC.refreshControl addTarget:self
                                    action:@selector(downloadAndRefresh:)
                          forControlEvents:UIControlEventValueChanged];
        
    }
    
}

@end
