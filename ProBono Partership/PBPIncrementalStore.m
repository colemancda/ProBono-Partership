//
//  PBPIncrementalStore.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPIncrementalStore.h"
#import "PBPAPI.h"

static NSString *Domain = @"com.ColemanCDA.ProBono.ErrorDomain";

NSString* const PBPIncrementalStoreType = @"PBPIncrementalStore";

@implementation PBPIncrementalStore

+(void)initialize
{
    [NSPersistentStoreCoordinator registerStoreClass:[self class]
                                        forStoreType:PBPIncrementalStoreType];
}

-(BOOL)loadMetadata:(NSError *__autoreleasing *)error
{
    // check if url is accessible
    
    NSURL *url = [NSURL URLWithString:self.api.baseURLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:nil
                                      error:error];
    
    if (error) {
        
        return NO;
    }
    
    return YES;
}

-(id)executeRequest:(NSPersistentStoreRequest *)request
        withContext:(NSManagedObjectContext *)context
              error:(NSError *__autoreleasing *)error
{
    if (request.requestType == NSSaveRequestType) {
        
        // cannot save
        
        NSString *description = NSLocalizedString(@"PBPIncrementalStore does not support saving",
                                                  @"Saving request not supported");
        
        *error = [NSError errorWithDomain:Domain
                                     code:0
                                 userInfo:@{NSLocalizedDescriptionKey: description}];
        
        return nil;
    }
    
    // fetch
    
    NSFetchRequest *fetchRequest = (NSFetchRequest *)request;
    
    // fetch categories
    if ([fetchRequest.entityName  isEqualToString:@"Category"]) {
        
        
        
    }
    
}

-(NSIncrementalStoreNode *)newValuesForObjectWithID:(NSManagedObjectID *)objectID
                                        withContext:(NSManagedObjectContext *)context
                                              error:(NSError *__autoreleasing *)error
{
    
    
}

-(id)newValueForRelationship:(NSRelationshipDescription *)relationship
             forObjectWithID:(NSManagedObjectID *)objectID
                 withContext:(NSManagedObjectContext *)context
                       error:(NSError *__autoreleasing *)error
{
    
    
}

-(NSArray *)obtainPermanentIDsForObjects:(NSArray *)array
                                   error:(NSError *__autoreleasing *)error
{
    
    
}

@end
