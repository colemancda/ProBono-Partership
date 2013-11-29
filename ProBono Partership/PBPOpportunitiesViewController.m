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


@interface PBPOpportunitiesViewController ()

@end

@implementation PBPOpportunitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // get categories
    [[PBPStore sharedStore] getCategories:^(NSError *error, NSArray *categories) {
       
        if (error) {
            
            [error presentError];
            
            return;
        }
        
        // get opportunities
        [[PBPStore sharedStore] getOpportunitiesWithParameters:<#(NSDictionary *)#> completion:^(NSError *error, NSArray *opportunities) {
            
            self.labe
            
            if (error) {
                <#statements#>
            }
            
        }];
    }];
}

#pragma mark

-(void)downloadAndRefresh:(id)sender
{
    
    
}

@end
