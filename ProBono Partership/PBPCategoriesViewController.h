//
//  PBPCategoriesViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/26/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBPCategoriesViewController : UITableViewController
{
    NSMutableArray *_categories;
}

-(void)refreshFromCache;

-(IBAction)downloadAndRefresh:(id)sender;

-(void)loadCategories:(NSArray *)categories;


@end
