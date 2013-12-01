//
//  PBPActivity.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 12/1/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MessageUI;

extern NSString *const ProBonoRequestActivityType;

@interface PBPActivity : UIActivity <MFMailComposeViewControllerDelegate>
{
    MFMailComposeViewController *_mailVC;
}

@end
