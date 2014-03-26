//
//  WaiqinHttpClient.m
//  Mifan
//
//  Created by ryan on 14-3-18.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "WaiqinHttpClient.h"

static NSString* const WaiqinOnlineURLString = @"http://72.14.191.249:8080/ExpertSelectSystemV1.1/webservice/";

@implementation WaiqinHttpClient

+ (WaiqinHttpClient *)sharedWaiqinHttpClient
{
    static WaiqinHttpClient *_sharedWaiqinHttpClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWaiqinHttpClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:WaiqinOnlineURLString]];
    });
    return _sharedWaiqinHttpClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",/*@"text/plain",*/ nil];
        
        
        //self.responseSerializer = [AFJSONResponseSerializer serializer];
        //self.requestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    
    return self;
}

- (void)loginActionUser:(NSString *)userName withPassword:(NSString *)userPassword
{
    NSMutableDictionary *parameters =[NSMutableDictionary dictionary];
    parameters[@"username"] = userName;
    parameters[@"pwdmd5"] = userPassword;
    //NSLog(@"THE POST IS BEGIN");
    [self POST:@"loginws" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
      //  NSLog(@"THE POST IS %@",responseObject);
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:didSignin:)]) {
            
            [self.delegate waiqinHTTPClient: self didSignin:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"the error is %@",error);
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:didFailWithError:)]) {
           
            [self.delegate waiqinHTTPClient: self didFailWithError:error];
        }
    }];
}

@end