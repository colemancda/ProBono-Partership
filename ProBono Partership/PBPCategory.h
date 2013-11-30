//
//  PBPCategory.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/30/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PBPOpportunity;

@interface PBPCategory : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *opportunities;
@end

@interface PBPCategory (CoreDataGeneratedAccessors)

- (void)addOpportunitiesObject:(PBPOpportunity *)value;
- (void)removeOpportunitiesObject:(PBPOpportunity *)value;
- (void)addOpportunities:(NSSet *)values;
- (void)removeOpportunities:(NSSet *)values;

@end
