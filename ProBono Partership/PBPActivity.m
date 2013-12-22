//
//  PBPActivity.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 12/1/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPActivity.h"
#import "PBPOpportunity.h"
#import "PBPCategory.h"
#import "PBPState.h"
#import "PBPSettingsViewController.h"

static NSString *PBPRequestInfoEmail = @"information@probonopartner.org";

NSString *const ProBonoRequestActivityType = @"ProBonoRequest";

@implementation PBPActivity

-(NSString *)activityType
{
    return ProBonoRequestActivityType;
}

-(NSString *)activityTitle
{
    static NSString *activityTitle;
    
    if (!activityTitle) {
        
        activityTitle = NSLocalizedString(@"Request More Info",
                                          @"Request More Info");
    }
    
    return activityTitle;
}

-(UIImage *)activityImage
{
    return [UIImage imageNamed:@"PBPActivityImage"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    // verify that the items are PBPOpportunities...
    
    return YES;
}

-(void)prepareWithActivityItems:(NSArray *)activityItems
{
    // create mail VC
    
    _mailVC = [[MFMailComposeViewController alloc] init];
    
    _mailVC.mailComposeDelegate = self;
    
    [_mailVC setToRecipients:@[PBPRequestInfoEmail]];
    
    [_mailVC setSubject:NSLocalizedString(@"Request info for volunteer opportunity",
                                          @"Request info for volunteer opportunity")];
    
    // for right now it only supports one item
    
    PBPOpportunity *opportunity = activityItems.firstObject;
    
    NSString *messageBody = [NSString stringWithFormat:NSLocalizedString(@"I would like to request more infomation about the following volunteer opportunity:<br /><br />Client: %@<br /><br />Work: %@<br /><br />Category: %@<br /><br /> Location: %@, %@<br /><br />Matter Number: %@<br /><br />Mission: %@", @"PBPActivity Request info message body"), opportunity.client, opportunity.work, opportunity.category.name, opportunity.city, opportunity.state.name, opportunity.matterNumber, opportunity.mission];
    
    // append user info
    
    NSString *userInfo = @"";
    
    NSString *firstName = [[NSUserDefaults standardUserDefaults] stringForKey:PBPFirstNamePreferenceKey];
    
    if (firstName && ![firstName isEqualToString:@""]) {
        
        userInfo = [userInfo stringByAppendingFormat:NSLocalizedString(@"First Name: %@", @"First Name: %@"), firstName];
    }
    
    NSString *lastName = [[NSUserDefaults standardUserDefaults] stringForKey:PBPLastNamePreferenceKey];
    
    if (lastName && ![lastName isEqualToString:@""]) {
        
        // include newline character
        if (![userInfo isEqualToString:@""]) {
            
            userInfo = [userInfo stringByAppendingFormat:@"<br /><br />"];
        }
        
        userInfo = [userInfo stringByAppendingFormat:NSLocalizedString(@"Last Name: %@", @"Last Name: %@"), lastName];
    }
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] stringForKey:PBPPhoneNumberPreferenceKey];
    
    if (phoneNumber && ![phoneNumber isEqualToString:@""]) {
        
        // include newline character
        if (![userInfo isEqualToString:@""]) {
            
            userInfo = [userInfo stringByAppendingFormat:@"<br /><br />"];
        }
        
        userInfo = [userInfo stringByAppendingFormat:NSLocalizedString(@"Phone Number: %@", @"Phone Number: %@"), phoneNumber];
    }
    
    NSString *firm = [[NSUserDefaults standardUserDefaults] stringForKey:PBPFirmPreferenceKey];
    
    if (firm && ![firm isEqualToString:@""]) {
        
        // include newline character
        if (![userInfo isEqualToString:@""]) {
            
            userInfo = [userInfo stringByAppendingFormat:@"<br /><br />"];
        }
        
        userInfo = [userInfo stringByAppendingFormat:NSLocalizedString(@"Firm: %@", @"Firm: %@"), firm];
    }
    
    // include user info
    if (![userInfo isEqualToString:@""]) {
        
        messageBody = [messageBody stringByAppendingFormat:NSLocalizedString(@"<br /><br />My Contact Info:<br /><br />%@", @"<br /><br />My Contact Info:<br /><br />%@"), userInfo];
        
    }
    
    [_mailVC setMessageBody:messageBody
                     isHTML:YES];
}

-(UIViewController *)activityViewController
{
    return _mailVC;
}

#pragma mark

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // dismiss mail VC
    
    [self activityDidFinish:(BOOL)error];
}

@end
