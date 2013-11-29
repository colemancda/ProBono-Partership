//
//  PBPCategoriesTableViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/27/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPCategoriesTableViewController.h"
#import "PBPCategory.h"

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
    
    return cell;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}

@end
