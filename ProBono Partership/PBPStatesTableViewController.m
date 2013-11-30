//
//  PBPStatesTableViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPStatesTableViewController.h"
#import "PBPState.h"
#import "PBPSettingsViewController.h"

@interface PBPStatesTableViewController ()

@end

@implementation PBPStatesTableViewController

#pragma mark

-(void)loadStates:(NSArray *)states
{
    // sort array
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                           ascending:YES];
    
    states = [states sortedArrayUsingDescriptors:@[sort]];
    
    _states = [NSMutableArray arrayWithArray:states];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [self.tableView reloadData];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _states.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // get model object
    PBPState *state = _states[indexPath.row];
    
    // Configure the cell...
    
    cell.textLabel.text = state.name;
    
    // check if selected
    
    NSArray *preferredCategories = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredStatesPreferenceKey];
    
    if ([preferredCategories containsObject:state.name]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = self.tableView.indexPathForSelectedRow.row;
    
    // get model object
    
    PBPState *state = _states[row];
    
    // set selected
    
    NSArray *preferredStates = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredStatesPreferenceKey];
    
    BOOL selected = YES;
    
    // none saved
    if (!preferredStates.count) {
        
        preferredStates = @[state.name];
    }
    
    else {
        
        // already selected
        
        if ([preferredStates containsObject:state.name]) {
            
            // remove object
            
            NSMutableArray *newArray = [NSMutableArray arrayWithArray:preferredStates];
            
            [newArray removeObject:state.name];
            
            preferredStates = (NSArray *)newArray;
            
            selected = NO;
            
        }
        
        // not selected
        else {
            
            preferredStates = [preferredStates arrayByAddingObject:state.name];
            
        }
    }
    
    // save preferences
    
    [[NSUserDefaults standardUserDefaults] setObject:preferredStates
                                              forKey:PBPPreferredStatesPreferenceKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // reload UI
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (selected) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // deselect cell with animation
    [cell setSelected:NO animated:YES];
}

@end
