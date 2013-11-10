//
//  PBPStore.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PBPStore : NSObject
{
    NSManagedObjectContext *_context;
    
    
}

-(id)executeNetworkFetchRequest:(NSFetchRequest *)fetchRequest;

-(id)executeCacheFetchRequest:(NSFetchRequest *)fetchRequest;

@end
