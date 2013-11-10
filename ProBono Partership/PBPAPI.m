//
//  PBPAPI.m
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import "PBPAPI.h"

@implementation PBPAPI

-(NSURLSessionDataTask *)getCategories:(void (^)(NSError *, NSInteger, NSArray *))completionHandler
{
    NSString *urlString = [NSString stringWithFormat:@"%@/?getcategories", APIURL];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            
            completionHandler(error, 0, nil);
            
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (httpResponse.statusCode != 200) {
            
            completionHandler(nil, httpResponse.statusCode, nil);
            
            return;
        }
        
        NSArray *categories = [NSJSONSerialization JSONObjectWithData:data
                                                              options:NSJSONReadingAllowFragments
                                                                error:nil];
        
        if (!categories && ![categories isKindOfClass:[NSArray class]]) {
            
            completionHandler(nil, httpResponse.statusCode, nil);
            
            return;
        }
        
        
        
        
    }];
    
    [dataTask resume];
    
    return dataTask;
}

@end
