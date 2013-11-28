//
//  PBPCategoriesTableViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/27/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBPCategoriesTableViewController : UITableViewController

{
    NSMutableArray *_categories;
}

-(void)loadCategories:(NSArray *)categories;

@end
