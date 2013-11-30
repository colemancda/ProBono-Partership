//
//  PBPOpportunity+UIActivityItemSource.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPOpportunity+UIActivityItemSource.h"

@implementation PBPOpportunity (UIActivityItemSource)

-(id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return [NSString string];
}

-(id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    return self.work;
}


@end
