//
//  PBPAPI.h
//  ProBono Partership
//
//  Created by Alsey Coleman Miller on 11/10/13.
//  Copyright (c) 2013 CDA. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const PBPAPIOpportunitiesCategoryParameter;

extern NSString *const PBPAPIOpportunitiesStateParameter;

typedef NS_ENUM (NSUInteger, PBPAPIErrorCode) {
    
    PBPAPIInvalidResponseErrorCode
};

@interface PBPAPI : NSObject

@property (readonly) NSURLSession *session;

@property (readonly) NSString *baseURLString;

-(NSURLSessionDataTask *)getCategories:(void (^)(NSError *error, NSArray *categories))completionBlock;

-(NSURLSessionDataTask *)getOpportunitiesWithParameters:(NSDictionary *)parameters
                                             completion:(void (^)(NSError *error, NSArray *opportunities))completionBlock;

@end
