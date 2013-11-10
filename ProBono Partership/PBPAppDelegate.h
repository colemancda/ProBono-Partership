//
//  PBPAppDelegate.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/9/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PBPAPI;

@interface PBPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property PBPAPI *api;

@end
