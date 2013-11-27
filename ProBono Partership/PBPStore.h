//
//  PBPStore.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class PBPAPI;

@interface PBPStore : NSObject

+ (PBPStore *)sharedStore;

#pragma mark

@property (readonly) NSManagedObjectContext *context;

@property (readonly) PBPAPI *api;

#pragma mark - Requests

-(NSURLSessionDataTask *)getCategories:(void (^)(NSError *error, NSArray *categories))completionBlock;


@end
