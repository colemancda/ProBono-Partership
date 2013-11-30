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
    
    // get categories
    [[PBPStore sharedStore] getCategories:^(NSError *error, NSArray *categories) {
        
        if (error) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self.tableVC.refreshControl endRefreshing];
                
            }];
            
            [error presentError];
            
            return;
        }
        
        // get opportunities
        [[PBPStore sharedStore] getOpportunitiesWithParameters:parameters completion:^(NSError *error, NSArray *opportunities) {
            
            
            if (error) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    [self.tableVC.refreshControl endRefreshing];
                    
                }];
                
                [error presentError];
                
                return;
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self.tableVC.refreshControl endRefreshing];
                
            }];
            
            [self.tableVC loadOpportunities:opportunities
                                    sorting:sorting];
            
        }];
    }];

    
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
    
    NSBlockOperation *errorBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        self.label.hidden = YES;
        
        self.tableVC.view.hidden = YES;
        
        self.retryButton.hidden = NO;
        
    }];
    
    // get categories
    [[PBPStore sharedStore] getCategories:^(NSError *error, NSArray *categories) {
        
        if (error) {
            
            [[NSOperationQueue mainQueue] addOperation:errorBlockOperation];
            
            [error presentError];
            
            return;
        }
        
        // get opportunities
        [[PBPStore sharedStore] getOpportunitiesWithParameters:parameters completion:^(NSError *error, NSArray *opportunities) {
            
            
            if (error) {
                
                [[NSOperationQueue mainQueue] addOperation:errorBlockOperation];
                
                [error presentError];
                
                return;
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                self.label.hidden = YES;
                
                self.tableVC.view.hidden = NO;
                
                self.retryButton.hidden = YES;
                
            }];
            
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
