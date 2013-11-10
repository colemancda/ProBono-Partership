//
//  PBPIncrementalStore.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPIncrementalStore.h"
#import "PBPAPI.h"

extern NSString const* PBPIncrementalStoreType;

@implementation PBPIncrementalStore

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



@end
