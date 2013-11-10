//
//  PBPAPI.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPAPI.h"
#import "PBPAppDelegate.h"

@implementation PBPAPI (Errors)

-(NSError *)unknownResponseWithStatusCode:(NSUInteger)statusCode
{
    NSString *description = [NSString stringWithFormat:NSLocalizedString(@"The server returned a unknown response (%d)", @"The server returned a unknown response (%d)"), statusCode];
    
    NSError *error = [NSError errorWithDomain:PBPErrorDomain
                                         code:100
                                     userInfo:@{NSLocalizedDescriptionKey: description}];
    
    return error;
}

@end

@implementation PBPAPI

-(NSArray *)getCategories:(NSError *__autoreleasing *)error
{
    NSString *urlString = [NSString stringWithFormat:@"%@/?getcategories", self.baseURLString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    __block NSArray *categories;
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *urlSessionError) {
        
        if (error) {
            
            *error = urlSessionError;
            
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode != 200) {
            
            *error = [self unknownResponseWithStatusCode:httpResponse.statusCode];
            
            return;
        }
        
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingAllowFragments
                                                                error:nil];
        
        if (!jsonObject || ![jsonObject isKindOfClass:[NSArray class]]) {
            
            *error = [self unknownResponseWithStatusCode:httpResponse.statusCode];
            
            return;
        }
        
        categories = jsonObject;
    }];
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        [dataTask resume];
    }];
    
    [[[NSOperationQueue alloc] init] addOperations:@[blockOperation] waitUntilFinished:YES];
    
    return categories;
}

@end
