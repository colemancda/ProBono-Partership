//
//  PBPAPI.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBPAPI : NSObject

@property NSURLSession *session;

@property NSString *baseURLString;

-(NSURLSessionDataTask *)getCategories:(void (^)(NSError *error, NSArray *categories))completionHandler;

@end
