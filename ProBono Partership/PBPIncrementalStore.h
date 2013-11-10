//
//  PBPIncrementalStore.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class PBPAPI;

NSString const* PBPIncrementalStoreType = @"PBPIncrementalStore";

@interface PBPIncrementalStore : NSIncrementalStore

@property PBPAPI *api;

@end
