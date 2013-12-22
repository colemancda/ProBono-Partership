//
//  PBPOpportunity+UIActivityItemSource.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPOpportunity+UIActivityItemSource.h"
#import "PBPState.h"
#import "PBPCategory.h"
#import "PBPActivity.h"
#import "NSString+HTML.h"

@implementation PBPOpportunity (UIActivityItemSource)

-(id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return [NSString string];
}

-(id)activityViewController:(UIActivityViewController *)activityViewController
        itemForActivityType:(NSString *)activityType
{
    // defualt
    
    NSString *text = self.work;
    
    if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
        
        text = [NSString stringWithFormat:@"%@ @PBPartnership", self.work];
        
        return text;
        
    }
    
    if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
        
        text = [NSString stringWithFormat:NSLocalizedString(@"%@\n%@, %@", @"Facebook representation of PBPOpportuntity"), self.work, self.city, self.state.name];
        
        return text;
    }
    
    if ([activityType isEqualToString:ProBonoRequestActivityType]) {
        
        return self;
    }
    
    // for all others
    
    text = [NSString stringWithFormat:NSLocalizedString(@"Client: %@\nWork: %@\nCategory: %@\n Location: %@, %@\nMatter Number: %@\nMission: %@", @"Default representation of PBPOpportunity"), self.client, self.work, self.category.name, self.city, self.state.name, self.matterNumber, [self.mission stringByConvertingHTMLToPlainText]];
    
    return text;
}

-(NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType
{
    NSString *text = [NSString stringWithFormat:NSLocalizedString(@"ProBono Partnership Volunteer Opportunity with %@",@"ProBono Partnership Volunteer Opportunity <Client Name>"), self.client];
    
    return text;
}


@end
