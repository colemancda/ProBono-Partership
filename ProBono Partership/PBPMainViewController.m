//
//  PBPMainViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/9/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPMainViewController.h"
#import "PBPOpportunitiesViewController.h"
#import "PBPOpportunitiesTableViewController.h"

@interface PBPMainViewController ()

@end

@implementation PBPMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedOpportunitiesVC"]) {
        
        _opportunitiesVC = segue.destinationViewController;
        
    }
    
}

-(void)unwindToMainVC:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:@"unwindToMainVCFromSettingsVC"]) {
        
        // reload
        
        PBPOpportunitiesSorting sorting = [[NSUserDefaults standardUserDefaults] integerForKey:PBPOpportunitiesSortingPreferenceKey];
        
        [self.opportunitiesVC.tableVC loadOpportunities:self.opportunitiesVC.tableVC.opportunities
                                                sorting:sorting];
        
    }
}

#pragma mark - Actions

-(IBAction)activityAction:(id)sender
{
    
    
}

@end
