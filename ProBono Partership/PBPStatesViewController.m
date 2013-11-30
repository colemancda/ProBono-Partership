//
//  PBPStatesViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPStatesViewController.h"
#import "PBPStatesTableViewController.h"
#import "PBPStore.h"
#import "NSError+presentError.h"

@interface PBPStatesViewController ()

@end

@implementation PBPStatesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // check if categories are downloaded
    
    self.label.hidden = YES;
    
    NSArray *states = [[PBPStore sharedStore] all:@"PBPState"];
    
    // if categories are downloaded
    if (states.count) {
        
        [self refreshFromCache];
        
    }
    
    else {
        
        self.label.hidden = NO;
        
        self.tableVC.view.hidden = YES;
        
        [[PBPStore sharedStore] getOpportunitiesWithParameters:nil completion:^(NSError *error, NSArray *opportunities) {
            
            if (error) {
                
                [error presentError];
                
                return;
            }
            
            [self refreshFromCache];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                self.label.hidden = YES;
                
                self.tableVC.view.hidden = NO;
                
            }];
            
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    if (sender == self && [segue.identifier isEqualToString:@"embeddedOpportunitiesTableVC"]) {
        
        _tableVC = segue.destinationViewController;
        
        [_tableVC.refreshControl addTarget:self
                                    action:@selector(downloadAndRefresh:)
                          forControlEvents:UIControlEventValueChanged];
        
    }
    
}

#pragma mark

-(void)downloadAndRefresh:(id)sender
{
    [[PBPStore sharedStore] getOpportunitiesWithParameters:nil completion:^(NSError *error, NSArray *opportunities) {
        
        if (error) {
            
            [error presentError];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self.tableVC.refreshControl endRefreshing];
                
            }];
            
            return;
        }
        
        [self refreshFromCache];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            
            [self.tableVC.refreshControl endRefreshing];
            
        }];
        
    }];
}

-(void)refreshFromCache
{
    // get all state objects
    
    NSArray *states = [[PBPStore sharedStore] all:@"PBPState"];
    
    [self.tableVC loadStates:states];
}

@end
