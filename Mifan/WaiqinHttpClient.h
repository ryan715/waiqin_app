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

- (void)registerAction:(NSString *)userName Password:(NSString *)pwdmd5 TrueName: (NSString *)truename Email: (NSString *)email Telephone: (NSString *)telephone;

- (void)GetUpdatetxUserforqunzhuAction: (NSString *)imgstr UserId: (NSString *)userid;

- (void) GetOneUserforqunzhuAction: (NSString *)userid;

- (void) UserUpdateUnitName: (NSString *)userid UnitName: (NSString *)unitname;

- (void) UserAddUnitName: (NSString *)userid UnitName: (NSString *)unitname;

- (void) GetUnitByName: (NSString *)unitname;

- (void) AddUserApplytoqz: (NSString *)unitid Userid: (NSString *)userid Beizhu: (NSString *)beizhu;

- (void) GetUserApplytoqzlist: (NSString *)pageindex PageSize: (NSString *)pagesize UserID: (NSString *)userid;

- (void)UpdateUserqzApplytosq: (NSString *)status ApplyID:(NSString *)applyid UserID:(NSString *)userid Jjbeizhu: (NSString *)jjbeizhu;

- (void) AddPicjbRecord: (NSString *)picid Userid: (NSString *)userid Beizhu: (NSString *)beizhu;

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

- (void) waiqinHTTPClient: (WaiqinHttpClient *)client registerDelegate: (id)responseData;

- (void) waiqinHTTPClient: (WaiqinHttpClient *) client getUpdatetxUserforqunzhuDelegate: (id) responseData;

- (void) waiqinHTTPClient: (WaiqinHttpClient *) client getOneUserforqunzhuDelegate: (id) responseData;

- (void) waiqinHTTPClient:(WaiqinHttpClient *)client UserUpdateUnitNameDelegate: (id)responseData;

- (void) waiqinHTTPClient:(WaiqinHttpClient *)client UserAddUnitNameDelegate:(id)responseData;
- (void) waiqinHTTPClient:(WaiqinHttpClient *)client GetUnitByNameDelegate:(id)responseData;

- (void) waiqinHTTPClient:(WaiqinHttpClient *)client AddUserApplytoqzDelegate:(id)responseData;

- (void) waiqinHTTPClient:(WaiqinHttpClient *)client GetUserApplytoqzlistDelegate:(id)responseData;

- (void) waiqinHTTPClient:(WaiqinHttpClient *)client UpdateUserqzApplytosqDelegate:(id)responseData;

- (void) waiqinHTTPClient:(WaiqinHttpClient *)client AddPicjbRecordDelegate:(id)responseData;

@end

