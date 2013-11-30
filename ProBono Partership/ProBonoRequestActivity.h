//
//  ProBonoRequestActivity.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MessageUI;

extern NSString *const ProBonoRequestActivityType;

@interface ProBonoRequestActivity : UIActivity <MFMailComposeViewControllerDelegate>
{
    MFMailComposeViewController *_mailVC;
}

@end
