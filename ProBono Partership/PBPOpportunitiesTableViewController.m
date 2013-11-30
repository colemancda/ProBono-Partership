//
//  PBPOpportunitiesTableViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/28/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPOpportunitiesTableViewController.h"
#import "PBPOpportunity.h"
#import "PBPCategory.h"
#import "PBPState.h"
#import "PBPOpportunityViewController.h"
#import "PBPOpportunityTableViewController.h"

@interface PBPOpportunitiesTableViewController ()

@end

@implementation PBPOpportunitiesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

-(void)loadOpportunities:(NSArray *)opportunities
                 sorting:(PBPOpportunitiesSorting)sorting
{
    _sorting = sorting;
    
    _opportunities = opportunities;
    
    // create nsarray for each category
    
    NSMutableArray *root = [[NSMutableArray alloc] init];
    
    if (self.sorting == PBPOpportunitiesSortingByCategory) {
        
        NSMutableArray *categories = [[NSMutableArray alloc] init];
        
        for (PBPOpportunity *opportunity in opportunities) {
            
            if (![categories containsObject:opportunity.category]) {
                
                [categories addObject:opportunity.category];
            }
        }
        
        // sort categories
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                               ascending:YES];
        
        [categories sortUsingDescriptors:@[sort]];
        
        // for each category, create nsarray
        
        for (PBPCategory *category in categories) {
            
            NSMutableArray *opportunitesUnderCategory = [[NSMutableArray alloc] init];
            
            for (PBPOpportunity *opportunity in opportunities) {
                
                if (opportunity.category == category) {
                    
                    [opportunitesUnderCategory addObject:opportunity];
                }
            }
            
            // sort opportunities
            
            sort = [NSSortDescriptor sortDescriptorWithKey:@"added"
                                                 ascending:NO];
            
            [opportunitesUnderCategory sortUsingDescriptors:@[sort]];
            
            [root addObject:opportunitesUnderCategory];
        }
    }
    
    if (self.sorting == PBPOpportunitiesSortingByLocation) {
        
        NSMutableArray *states = [[NSMutableArray alloc] init];
        
        for (PBPOpportunity *opportunity in opportunities) {
            
            if (![states containsObject:opportunity.state]) {
                
                [states addObject:opportunity.state];
            }
        }
        
        // sort categories
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                               ascending:YES];
        
        [states sortUsingDescriptors:@[sort]];
        
        // for each category, create nsarray
        
        for (PBPState *state in states) {
            
            NSMutableArray *opportunitesUnderState = [[NSMutableArray alloc] init];
            
            for (PBPOpportunity *opportunity in opportunities) {
                
                if (opportunity.state == state) {
                    
                    [opportunitesUnderState addObject:opportunity];
                }
            }
            
            // sort opportunities
            
            sort = [NSSortDescriptor sortDescriptorWithKey:@"city"
                                                 ascending:YES];
            
            [opportunitesUnderState sortUsingDescriptors:@[sort]];
            
            [root addObject:opportunitesUnderState];
        }
        
    }
    
    _groupedOpportunities = root;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       
        [self.tableView reloadData];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return _groupedOpportunities.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    NSArray *opportunitiesUnderSection = _groupedOpportunities[section];
    
    return opportunitiesUnderSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // get model object
    NSArray *subOpportunities = _groupedOpportunities[indexPath.section];
    
    PBPOpportunity *opportunity = subOpportunities[indexPath.row];
    
    // Configure the cell...
    
    cell.textLabel.text = opportunity.work;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *subOpportunities = _groupedOpportunities[section];
    
    // just get header from first opportunity
    PBPOpportunity *firstOpportunity = subOpportunities.firstObject;
    
    if (self.sorting == PBPOpportunitiesSortingByCategory) {
        
        return firstOpportunity.category.name;
    }
    
    if (self.sorting == PBPOpportunitiesSortingByLocation) {
        
        return firstOpportunity.state.name;
    }
    
    return nil;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"PushOpportunityVC"]) {
        
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        // get model object
        NSArray *subOpportunities = _groupedOpportunities[indexPath.section];
        
        PBPOpportunity *opportunity = subOpportunities[indexPath.row];
        
        PBPOpportunityViewController *opportunityVC = segue.destinationViewController;
        
        opportunityVC.opportunity = opportunity;
    }
}

@end
