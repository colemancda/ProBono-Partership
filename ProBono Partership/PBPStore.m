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
#import "PBPState.h"

@implementation PBPStore (Cache)

-(NSManagedObject *)entity:(NSString *)entityName
        withIdentifierName:(NSString *)identifierName
                identifier:(id)identifier
{
    // fetch request
    
    assert(identifier);
    
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

#pragma mark - Cache

-(NSArray *)all:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    __block NSArray *results;
    
    [_context performBlockAndWait:^{
        
        NSError *error;
        
        results = [_context executeFetchRequest:fetchRequest
                                          error:&error];
        
        if (!results) {
            
            [NSException raise:@"Error executing fetch request"
                        format:@"%@", error.localizedDescription];
            
            return;
        }
        
    }];
    
    return results;
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


-(NSURLSessionDataTask *)getOpportunitiesWithParameters:(NSDictionary *)parameters
                                             completion:(void (^)(NSError *, NSArray *))completionBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDataTask *dataTask = [self.api getOpportunitiesWithParameters:parameters completion:^(NSError *error, NSArray *jsonResponse) {
        
        if (error) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            completionBlock(error, nil);
            
            return;
        }
        
        NSMutableArray *opportunities = [[NSMutableArray alloc] init];
        
        for (NSDictionary *jsonObject in jsonResponse) {
            
            NSString *position = jsonObject[@"Position"];
            
            NSString *category = jsonObject[@"Category"];
            
            NSString *city = jsonObject[@"City"];
            
            NSString *state = jsonObject[@"State"];
            
            NSString *client = jsonObject[@"Client"];
            
            NSString *work = jsonObject[@"Legal Work Required"];
            
            NSString *mission = jsonObject[@"Mission"];
            
            NSString *matterNumber = jsonObject[@"Matter No.:"];
            
            NSString *added = jsonObject[@"Added:"];
            
            NSString *updated = jsonObject[@"Updated:"];
            
            PBPOpportunity *opportunity = (PBPOpportunity *)[self entity:@"PBPOpportunity"
                                                      withIdentifierName:@"matterNumber"
                                                              identifier:matterNumber];
            
            // relationships
            
            opportunity.category = (PBPCategory *)[self entity:@"PBPCategory"
                                            withIdentifierName:@"id"
                                                    identifier:[NSNumber numberWithInteger:category.integerValue]];
            
            
            opportunity.state = (PBPState *)[self entity:@"PBPState"
                                      withIdentifierName:@"name"
                                              identifier:state];
            
            if (!opportunity.category) {
                
                [NSException raise:NSInternalInconsistencyException
                            format:@"nil PBPCategory"];
                
                return;
                
            }
            
            // set values
            
            opportunity.position = position;
            
            opportunity.city = city;
            
            opportunity.client = client;
            
            opportunity.work = work;
            
            opportunity.mission = mission;
            
            static NSDateFormatter *dateFormatter;
            
            if (!dateFormatter) {
                
                dateFormatter = [[NSDateFormatter alloc] init];
                
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            }
            
            opportunity.added = [dateFormatter dateFromString:added];
            
            opportunity.updated = [dateFormatter dateFromString:updated];
            
            
            [opportunities addObject:opportunity];
        }
        
        completionBlock(nil, opportunities);
        
    }];
    
    return dataTask;
}


@end
