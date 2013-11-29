//
//  PBPCategoriesTableViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/27/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPCategoriesTableViewController.h"
#import "PBPCategory.h"
#import "PBPSettingsViewController.h"

@interface PBPCategoriesTableViewController ()

@end

@implementation PBPCategoriesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

-(void)loadCategories:(NSArray *)categories
{
    // sort array
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                           ascending:YES];
    
    categories = [categories sortedArrayUsingDescriptors:@[sort]];
    
    _categories = [NSMutableArray arrayWithArray:categories];
    
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
    return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // get model object
    PBPCategory *category = _categories[indexPath.row];
    
    // Configure the cell...
    
    cell.textLabel.text = category.name;
    
    // check if selected
    
    NSArray *preferredCategories = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredCategoriesPreferenceKey];
    
    if ([preferredCategories containsObject:category.id]) {
        
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
    
    PBPCategory *category = _categories[row];
    
    // set selected
    
    NSArray *preferredCategories = [[NSUserDefaults standardUserDefaults] arrayForKey:PBPPreferredCategoriesPreferenceKey];
    
    BOOL selected = YES;
    
    // none saved
    if (!preferredCategories.count) {
        
        preferredCategories = @[category.id];
    }
    
    else {
        
        // already selected
        
        if ([preferredCategories containsObject:category.id]) {
            
            // remove object
            
            NSMutableArray *newArray = [NSMutableArray arrayWithArray:preferredCategories];
            
            [newArray removeObject:category.id];
            
            preferredCategories = (NSArray *)newArray;
            
            selected = NO;
            
        }
        
        // not selected
        else {
            
            preferredCategories = [preferredCategories arrayByAddingObject:category.id];
            
        }
    }
    
    // save preferences
    
    [[NSUserDefaults standardUserDefaults] setObject:preferredCategories
                                              forKey:PBPPreferredCategoriesPreferenceKey];
    
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
