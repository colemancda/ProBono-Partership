//
//  PBPStatesViewController.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PBPStatesTableViewController;

@interface PBPStatesViewController : UIViewController

@property (readonly) PBPStatesTableViewController *tableVC;

@property IBOutlet UILabel *label;

-(void)refreshFromCache;

-(void)downloadAndRefresh:(id)sender;

@end
