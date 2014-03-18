//
//  WaiqinHttpClient.m
//  Mifan
//
//  Created by ryan on 14-3-18.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "WaiqinHttpClient.h"

static NSString* const WaiqinOnlineURLString = @"http://72.14.191.249:8080/ExpertSelectSystemV1.1";

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
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

@end
