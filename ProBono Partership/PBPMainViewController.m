//
//  PBPMainViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/9/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPMainViewController.h"

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

#pragma mark

-(void)unwindToMainVC:(UIStoryboardSegue *)segue
{
    
    
}

#pragma mark - Actions

-(IBAction)activityAction:(id)sender
{
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] init];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
