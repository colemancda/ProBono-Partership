//
//  PBPStore.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPStore.h"
#import "PBPAPI.h"
#import "PBPCategory.h"
#import "PBPOpportunity.h"

@implementation PBPStore (Cache)

-(NSManagedObject *)entity:(NSString *)entityName
        withIdentifierName:(NSString *)identifierName
                identifier:(id)identifier
{
    // fetch request
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", identifierName, identifier];
    
    __block NSManagedObject *entity;
    
    [self.context performBlockAndWait:^{
        
        NSError *error;
        
        NSArray *results = [self.context executeFetchRequest:fetchRequest
                                                       error:&error];
        
        if (!results) {
            
            [NSException raise:@"Fetch request failed"
                        format:@"%@", error.localizedDescription];
            
            return;
        }
        
        entity = results.firstObject;
        
    }];
    
    // create new entity
    if (!entity) {
        
        entity = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                               inManagedObjectContext:self.context];
        
        [entity setValue:identifier
                  forKey:identifierName];
    }
    
    return entity;
}

@end

@implementation PBPStore

+ (PBPStore *)sharedStore
{
    static PBPStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PBPModel"
                                                  withExtension:@"momd"];
        
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        
        _context.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        _context.undoManager = nil;
        
        // api
        _api = [[PBPAPI alloc] init];
        
                
    }
    return self;
}

#pragma mark - Requests

-(NSURLSessionDataTask *)getCategories:(void (^)(NSError *, NSArray *))completionBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDataTask *dataTask = [self.api getCategories:^(NSError *error, NSArray *jsonResponse) {
        
        if (error) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            completionBlock(error, nil);
            
            return;
        }
        
        // create or replace category objects for category id
        
        NSMutableArray *categories = [[NSMutableArray alloc] init];
        
        for (NSDictionary *jsonObject in jsonResponse) {
            
            NSString *categoryIDString = jsonObject[@"Categoryid"];
            
            PBPCategory *category = (PBPCategory *)[self entity:@"PBPCategory"
                                             withIdentifierName:@"id"
                                                     identifier:[NSNumber numberWithInteger:categoryIDString.integerValue]];
            
            // set category name
            category.name = jsonObject[@"CategoryName"];
            
            [categories addObject:category];
            
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        completionBlock(nil, categories);
        
    }];
    
    return dataTask;
}


@end
