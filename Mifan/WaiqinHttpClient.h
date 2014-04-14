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
- (void)uploadLocation:(NSString *)userName withBeizhu:(NSString *)beizhu withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude;

- (void)listLocationAction:(NSString *)userId withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize;

- (void)uploadImage:(NSString *)userName withBeizhu:(NSString *)beiZhu withImage:(NSString *
                                                                                  )image;
- (void)listImage:(NSString *)userId withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize;

- (void)imageDetail:(NSString *)idString;

- (void)userList:(NSString *)userId pageIndex:(NSString *)pageindex pageSize:(NSString *)pagesize;

- (BOOL) isConnectionAvailable;

@end

@protocol WaiqinHttpClientDelegate <NSObject>

@optional
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didSignin:(id)responseData;
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client uploadLocation:(id)response;
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client listLocation:(id)responseData;
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client uploadImage:(id)responseData;
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client didFailWithError:(NSError *)error;
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client listImageDelegate:(id)responseData;
- (void)waiqinHTTPClient:(WaiqinHttpClient *)client imageDetailDelegate:(id)responseData;
- (void)waiqinHTTPClient: (WaiqinHttpClient *)client userListDelegate: (id)responseData;
@end

