//
//  PBPCategoriesViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/26/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPCategoriesViewController.h"
#import "PBPStore.h"
#import "NSError+presentError.h"
#import "PBPCategory.h"
#import "PBPCategoriesTableViewController.h"

@interface PBPCategoriesViewController ()

@end

@implementation PBPCategoriesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // check if categories are downloaded
    
    self.label.hidden = YES;
    
    NSArray *categories = [[PBPStore sharedStore] all:@"PBPCategory"];
    
    // if categories are downloaded
    if (categories.count) {
        
        [self.categoriesTableVC loadCategories:categories];
        
    }
    
    else {
        
        self.label.hidden = NO;
        
        self.categoriesTableVC.view.hidden = YES;
        
        [[PBPStore sharedStore] getCategories:^(NSError *error, NSArray *categories) {
            
            if (error) {
                
                [error presentError];
                
                return;
            }
            
            [self.categoriesTableVC loadCategories:categories];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                self.label.hidden = YES;
                
                self.categoriesTableVC.view.hidden = NO;
                
            }];
            
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender
{
    if (sender == self && [segue.identifier isEqualToString:@"embeddedCategoryTableVC"]) {
        
        _categoriesTableVC = segue.destinationViewController;
        
        [_categoriesTableVC.refreshControl addTarget:self
                                              action:@selector(downloadAndRefresh:)
                                    forControlEvents:UIControlEventValueChanged];
        
    }
    
}

#pragma mark

-(void)downloadAndRefresh:(id)sender
{
    [[PBPStore sharedStore] getCategories:^(NSError *error, NSArray *categories) {
        
        if (error) {
            
            [error presentError];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self.categoriesTableVC.refreshControl endRefreshing];
                
            }];
            
            return;
        }
        
        [self.categoriesTableVC loadCategories:categories];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [self.categoriesTableVC.refreshControl endRefreshing];
            
        }];
        
    }];
}

-(void)refreshFromCache
{
    // get all category objects
    
    NSArray *categories = [[PBPStore sharedStore] all:@"PBPCategory"];
    
    [self.categoriesTableVC loadCategories:categories];
}



@end
