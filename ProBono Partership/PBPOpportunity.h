//
//  PBPOpportunity.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/28/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PBPCategory;

@interface PBPOpportunity : NSManagedObject

@property (nonatomic, retain) NSDate * added;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * client;
@property (nonatomic, retain) NSString * matterNumber;
@property (nonatomic, retain) NSString * mission;
@property (nonatomic, retain) NSString * position;
@property (nonatomic, retain) NSDate * updated;
@property (nonatomic, retain) NSString * work;
@property (nonatomic, retain) PBPCategory *category;
@property (nonatomic, retain) NSManagedObject *state;

@end
