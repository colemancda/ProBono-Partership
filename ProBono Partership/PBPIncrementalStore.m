//
//  PBPIncrementalStore.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPIncrementalStore.h"
#import "PBPAPI.h"
#import "PBPAppDelegate.h"

NSString* const PBPIncrementalStoreType = @"PBPIncrementalStore";

@implementation PBPIncrementalStore (Error)

-(NSError *)invalidPredicateError
{
    static NSError *error;
    
    if (error) {
        
        NSString *description = NSLocalizedString(@"Invalid predicate", @"Invalid predicate");
        
        error = [NSError errorWithDomain:PBPErrorDomain
                                    code:1000
                                userInfo:@{NSLocalizedDescriptionKey : description}];
    }
    
    return error;
}

-(NSError *)invalidResultTypeError
{
    static NSError *error;
    
    if (error) {
        
        NSString *description = NSLocalizedString(@"Invalid resultType", @"Invalid resultType");
        
        error = [NSError errorWithDomain:PBPErrorDomain
                                    code:1001
                                userInfo:@{NSLocalizedDescriptionKey : description}];
    }
    
    return error;
}

-(NSError *)invalidEntityError
{
    static NSError *error;
    
    if (error) {
        
        NSString *description = NSLocalizedString(@"Invalid entity", @"Invalid entity");
        
        error = [NSError errorWithDomain:PBPErrorDomain
                                    code:1002
                                userInfo:@{NSLocalizedDescriptionKey : description}];
    }
    
    return error;
}

@end

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
        
        *error = [NSError errorWithDomain:PBPErrorDomain
                                     code:0
                                 userInfo:@{NSLocalizedDescriptionKey: description}];
        
        return nil;
    }
    
    // fetch request
    
    NSFetchRequest *fetchRequest = (NSFetchRequest *)request;
    
    // fetch categories
    if ([fetchRequest.entityName isEqualToString:@"Category"]) {
        
        NSArray *categories = [self.api getCategories:error];
        
        if (error) {
            return nil;
        }
        
        // return results based on resultType
        
        if (fetchRequest.resultType == NSManagedObjectResultType) {
            
            for ( in categories) {
                
                
            }
            
            
            
            [context objectWithID:<#(NSManagedObjectID *)#>]
            
        }
        
        *error = self.invalidResultTypeError;
        
        return nil;
    }
    
    // invalid enitity
    *error = self.invalidEntityError;
    
    return nil;
    
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
