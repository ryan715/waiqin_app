//
//  WaiqinHttpClient.h
//  Mifan
//
//  Created by ryan on 14-3-18.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol WaiqinHttpClientDelegate;

@interface WaiqinHttpClient : AFHTTPSessionManager

@property (nonatomic, weak) id<WaiqinHttpClientDelegate>delegate;

+ (WaiqinHttpClient *)sharedWaiqinHttpClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)loginActionUser:(NSString *)userName withPassword:(NSString *)userPassword;
@end

@protocol WaiqinHttpClientDelegate <NSObject>

@optional
-(void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)user;
-(void)waiqinHTTPClient:(WaiqinHttpClient *)client didFailWithError:(NSError *)error;

@end

