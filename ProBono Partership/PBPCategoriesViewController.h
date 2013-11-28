//
//  PBPCategoriesViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/26/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PBPCategoriesTableViewController;

@interface PBPCategoriesViewController : UIViewController

@property (readonly) PBPCategoriesTableViewController *categoriesTableVC;

@property IBOutlet UILabel *label;

-(void)refreshFromCache;

-(void)downloadAndRefresh:(id)sender;


@end
