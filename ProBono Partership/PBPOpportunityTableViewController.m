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
    
    [self.tableView reloadData];
}

#pragma mark - Table View

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // work cell
    if (indexPath.row == 6) {
        
        NSUInteger xPadding = 15;
        
        NSUInteger yPadding = 15;
        
        CGSize maxSize = CGSizeMake(self.tableView.frame.size.width - (2 * xPadding),
                                    NSIntegerMax);
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
        
        CGRect rect = [self.opportunity.work boundingRectWithSize:maxSize
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:attributes
                                                          context:nil];
        
        return rect.size.height + (2 * yPadding);
        
    }
    
    return tableView.rowHeight;
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
