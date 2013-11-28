//
//  PBPCategory.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/28/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PBPOpportunity;

@interface PBPCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) PBPOpportunity *opportunities;

@end
