//
//  PBPAPI.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPAPI.h"
#import "PBPAppDelegate.h"

NSString *const PBPAPIOpportunitiesCategoryParameter = @"PBPAPIOpportunitiesCategoryParameter";

NSString *const PBPAPIOpportunitiesStateParameter = @"PBPAPIOpportunitiesStateParameter";

@implementation PBPAPI (Errors)

-(NSError *)invalidResponseWithStatusCode:(NSUInteger)statusCode
{
    NSString *description = [NSString stringWithFormat:NSLocalizedString(@"The server returned a invalid response (%d)", @"The server returned a invalid response (%d)"), statusCode];
    
    NSError *error = [NSError errorWithDomain:PBPErrorDomain
                                         code:PBPAPIInvalidResponseErrorCode
                                     userInfo:@{NSLocalizedDescriptionKey: description}];
    
    return error;
}

@end

@implementation PBPAPI

- (id)init
{
    self = [super init];
    if (self) {
        
        _baseURLString = @"http://probonopartner.org/API";
        
        _session = [NSURLSession sharedSession];
        
    }
    return self;
}

#pragma mark

-(NSURLSessionDataTask *)getCategories:(void (^)(NSError *, NSArray *))completionBlock
{
    NSString *urlString = [NSString stringWithFormat:@"%@/?getcategories", self.baseURLString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            
            completionBlock(error, nil);
            
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode != 200) {
            
            completionBlock([self invalidResponseWithStatusCode:httpResponse.statusCode], nil);
            
            return;
        }
        
        NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingAllowFragments
                                                                error:nil];
        
        if (!jsonObjects || ![jsonObjects isKindOfClass:[NSArray class]]) {
            
            completionBlock([self invalidResponseWithStatusCode:httpResponse.statusCode], nil);
            
            return;
        }
        
        // validate jsonObjects
        
        for (NSDictionary *jsonObject in jsonObjects) {
            
            if (![jsonObject isKindOfClass:[NSDictionary class]]) {
                
                completionBlock([self invalidResponseWithStatusCode:httpResponse.statusCode], nil);
                
                return;
            }
            
            NSString *categoryID = jsonObject[@"Categoryid"];
            
            NSString *categoryName = jsonObject[@"CategoryName"];
            
            if (!categoryID || ![categoryID isKindOfClass:[NSString class]] ||
                !categoryName || ![categoryName isKindOfClass:[NSString class]]) {
                
                completionBlock([self invalidResponseWithStatusCode:httpResponse.statusCode], nil);
                
                return;
            }
        }
        
        
        completionBlock(nil, jsonObjects);
        
    }];
    
    [dataTask resume];
    
    return dataTask;
}

-(NSURLSessionDataTask *)getOpportunitiesWithParameters:(NSDictionary *)parameters
                                             completion:(void (^)(NSError *, NSArray *))completionBlock
{
    NSString *urlString = self.baseURLString;
    
    // build URL with query parameters
    
    if (parameters.count) {
        
        NSString *queryString;
        
        // categories
        
        NSArray *categories = parameters[PBPAPIOpportunitiesCategoryParameter];
        
        if (categories.count) {
            
            queryString = @"Cat=";
            
            for (NSNumber *categoryID in categories) {
                
                NSString *categoryIDString = [NSString stringWithFormat:@"%@", categoryID];
                
                if (categoryID == categories.firstObject) {
                    
                    queryString = [queryString stringByAppendingString:categoryIDString];
                }
                
                else {
                    
                    categoryIDString = [categoryIDString stringByAppendingFormat:@"|%@", categoryIDString];
                }
            }
        }
        
        // states
        
        NSArray *states = parameters[PBPAPIOpportunitiesStateParameter];
        
        if (states.count) {
            
            if (queryString) {
                
                queryString = [queryString stringByAppendingString:@"&"];
            }
            
            else {
                
                queryString = @"";
            }
            
            [queryString stringByAppendingString:@"State="];
            
            for (NSString *state in states) {
                
                if (state == states.firstObject) {
                    
                    [queryString stringByAppendingString:state];
                }
                
                else {
                    
                    [queryString stringByAppendingFormat:@"|%@", state];
                    
                }
            }
        }
        
        urlString = [urlString stringByAppendingFormat:@"?%@", queryString];
        
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [_session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            
            completionBlock(error, nil);
            
            return;
        }
        
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode != 200) {
            
            completionBlock([self invalidResponseWithStatusCode:httpResponse.statusCode], nil);
            
            return;
        }
        
        NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:nil];
        
        if (!jsonObjects || ![jsonObjects isKindOfClass:[NSArray class]]) {
            
            completionBlock([self invalidResponseWithStatusCode:httpResponse.statusCode], nil);
            
            return;
        }
        
        // validate jsonObjects
        
        for (NSDictionary *jsonObject in jsonObjects) {
            
            if (![jsonObject isKindOfClass:[NSDictionary class]]) {
                
                completionBlock([self invalidResponseWithStatusCode:httpResponse.statusCode], nil);
                
                return;
            }
            
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
            
            if (!position ||
                !category ||
                !city ||
                !state ||
                !client ||
                !work ||
                !mission ||
                !matterNumber ||
                !added ||
                !updated) {
                
                completionBlock([self invalidResponseWithStatusCode:httpResponse.statusCode], nil);
                
                return;
            }
        }
        
        completionBlock(nil, jsonObjects);
        
    }];
    
    [dataTask resume];
    
    return dataTask;
}

@end
