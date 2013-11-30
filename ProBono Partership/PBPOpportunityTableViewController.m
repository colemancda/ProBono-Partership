//
//  PBPOpportunityTableViewController.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPOpportunityTableViewController.h"
#import "PBPOpportunity.h"
#import "PBPState.h"
#import "PBPCategory.h"

@interface PBPOpportunityTableViewController ()

@end

@implementation PBPOpportunityTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadUI];
}

-(void)loadUI
{
    self.matterNumberTextField.text = self.opportunity.matterNumber;
    
    self.clientTextField.text = self.opportunity.client;
    
    self.cityTextField.text = self.opportunity.city;
    
    self.stateTextField.text = self.opportunity.state.name;
    
    self.categoryTextField.text = self.opportunity.category.name;
    
    self.workTextField.text = self.opportunity.work;
    
    [self.missionWebView loadHTMLString:self.opportunity.mission baseURL:nil];
}

#pragma mark - WebView

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        [[UIApplication sharedApplication] openURL:request.URL];
        
        return NO;
    }
    
    return YES;
}

@end
