//
//  ProBonoRequestActivity.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "ProBonoRequestActivity.h"
#import "PBPOpportunity.h"

NSString *const ProBonoRequestActivityType = @"ProBonoRequest";

@implementation ProBonoRequestActivity

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
    return [UIImage imageNamed:@"Squarelogo"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

-(void)prepareWithActivityItems:(NSArray *)activityItems
{
    // create mail VC
    
    _mailVC = [[MFMailComposeViewController alloc] init];
    
}

-(UIViewController *)activityViewController
{
    return _mailVC;
}

#pragma mark

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    [controller dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
}

@end