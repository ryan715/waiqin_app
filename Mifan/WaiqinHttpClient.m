//
//  WaiqinHttpClient.m
//  Mifan
//
//  Created by ryan on 14-3-18.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import "WaiqinHttpClient.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

static NSString* const WaiqinOnlineURLString = @"http://72.14.191.249:8080/ExpertSelectSystemV1.1/webservice/";

static NSString* const WaiqinOnlineImageString = @"http://72.14.191.249:8080/ExpertSelectSystemV1.1/";

static int const intPageSize = 15;

//static NSString* const WaiqinOnlineURLString = @"http://192.168.1.143:8080/ExpertSelectSystemV1.1/webservice/";

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


- (void)uploadLocation:(NSString *)userName withBeizhu:(NSString *)beizhu withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Username"] = userName;
    parameters[@"Beizhu"] = beizhu;
    parameters[@"Longitude"] = longitude;
    parameters[@"Latitude"] = latitude;
    
    [self POST:@"GetAddLocationRecord" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:uploadLocation:)]) {
            [self.delegate waiqinHTTPClient:self uploadLocation:responseObject];
        }
    }
        
    failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];

    }];
}

- (void)listLocationAction:(NSString *)userId withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"pageindex"] = pageIndex;
    parameters[@"pagesize"] = pageSize;
    parameters[@"userid"] = userId;
    
    [self POST:@"GetLocationRecordlist" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:listLocation:)]) {
            [self.delegate waiqinHTTPClient:self listLocation:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
        
    }];

}

/* 图片上传 */

- (void)uploadImage:(NSString *)userName withBeizhu:(NSString *)beiZhu withImage:(NSString *)image
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Username"] = userName;
    parameters[@"Beizhu"] = beiZhu;
    parameters[@"Imgstr"] = image;
    parameters[@"Isopen"] = @"1";
    [self POST:@"GetAddPicRecord" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:uploadImage:)
            ]) {
            
            NSLog(@"the upload image is %@",responseObject);
            [self.delegate waiqinHTTPClient:self uploadImage:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
        NSLog(@"the upload image is %@",error);
    }];
}

- (void)listImage:(NSString *)userId withPageIndex:(NSString *)pageIndex withPageSize:(NSString *)pageSize
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userid"] = userId;
    parameters[@"pageindex"] = pageIndex;
    parameters[@"pagesize"] = pageSize;
    
    [self POST:@"GetPicRecordlist" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:listImageDelegate:)]) {
            [self.delegate waiqinHTTPClient:self listImageDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];
}

/* 查看图片详情 */
- (void)imageDetail:(NSString *)idString
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"id"] = idString;
    
    [self POST:@"GetOnePicRecord" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:imageDetailDelegate:)]) {
            [self.delegate waiqinHTTPClient:self imageDetailDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];
    
}

/* 获取群组成员 */
- (void)userList:(NSString *)userId pageIndex:(NSString *)pageindex pageSize:(NSString *)pagesize
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userid"] = userId;
    parameters[@"pageindex"] = pageindex;
    parameters[@"pagesize"] = pagesize;
    
    [self POST:@"GetUserforqunzhulist" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:userListDelegate:)]) {
            [self.delegate waiqinHTTPClient:self userListDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];
    
}


/* 
 用户注册
 */
- (void)registerAction:(NSString *)userName Password:(NSString *)pwdmd5 TrueName:(NSString *)truename Email:(NSString *)email Telephone:(NSString *)telephone
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"Username"] = userName;
    parameters[@"pwdmd5"] = pwdmd5;
    parameters[@"truename"] = truename;
    parameters[@"email"] = email;
    parameters[@"telephone"] = telephone;
    
    [self POST:@"UserRegister" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:registerDelegate:)]) {
            [self.delegate waiqinHTTPClient:self registerDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];
}

/* 会员更换头像 */

- (void)GetUpdatetxUserforqunzhuAction:(NSString *)imgstr UserId:(NSString *)userid
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"imgstr"] = imgstr;
    parameters[@"userid"] = userid;
    
    [self POST:@"GetUpdatetxUserforqunzhu" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:getUpdatetxUserforqunzhuDelegate:)]) {
            [self.delegate waiqinHTTPClient:self getUpdatetxUserforqunzhuDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];

}

/* 获取个人信息 */
- (void)GetOneUserforqunzhuAction:(NSString *)userid
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"imgstr"] = imgstr;
    parameters[@"id"] = userid;
    
    [self POST:@"GetOneUserforqunzhu" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:getOneUserforqunzhuDelegate:)]) {
            [self.delegate waiqinHTTPClient:self getOneUserforqunzhuDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];

}

/* 修改群组 */
- (void)UserUpdateUnitName: (NSString *)userid UnitName:(NSString *)unitname
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userid"] = userid;
    parameters[@"unitname"] = unitname;
    
    [self POST:@"UserUpdateUnitName" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:UserUpdateUnitNameDelegate:)]) {
            [self.delegate waiqinHTTPClient:self UserUpdateUnitNameDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];

}

/* 新建群组 */
- (void)UserAddUnitName: (NSString *)userid UnitName:(NSString *)unitname
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"userid"] = userid;
    parameters[@"unitname"] = unitname;
    
    [self POST:@"UserAddUnitName" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:UserAddUnitNameDelegate:)]) {
            
            //NSLog(@"THE UserAddUnitName %@ ", responseObject);
            [self.delegate waiqinHTTPClient:self UserAddUnitNameDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];
    
}

/* 按群名字查找 */
- (void)GetUnitByName:(NSString *)unitname
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"unitname"] = unitname;
    
    [self POST:@"GetUnitByName" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:GetUnitByNameDelegate:)]) {
            [self.delegate waiqinHTTPClient:self GetUnitByNameDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];

    }];
}

/* 入群申请 */
- (void)AddUserApplytoqz:(NSString *)unitid Userid:(NSString *)userid Beizhu:(NSString *)beizhu
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"unitid"] = unitid;
    parameters[@"userid"] = userid;
    parameters[@"beizhu"] = beizhu;
    
    [self POST:@"AddUserApplytoqz" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:AddUserApplytoqzDelegate:)]) {
            [self.delegate waiqinHTTPClient:self AddUserApplytoqzDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];
}

/* 入群申请信息列表 */
- (void)GetUserApplytoqzlist:(NSString *)pageindex PageSize:(NSString *)pagesize UserID:(NSString *)userid
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"pageindex"] = pageindex;
    parameters[@"pagesize"] = pagesize;
    parameters[@"userid"] = userid;
    
    [self POST:@"GetUserApplytoqzlist" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(waiqinHTTPClient:GetUserApplytoqzlistDelegate:)]) {
            [self.delegate waiqinHTTPClient:self GetUserApplytoqzlistDelegate:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.delegate waiqinHTTPClient:self didFailWithError:error];
    }];
}



- (BOOL) isConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.163.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        
        case ReachableViaWiFi:
            isExistenceNetwork =YES;
            break;
            
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
//        default:
//            break;
    }
    
//    if (!isExistenceNetwork) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.removeFromSuperViewOnHide =YES;
//        hud.mode = MBProgressHUDModeText;
//        hud.labelText = NSLocalizedString(@"网络链接失败", nil);
//        hud.minSize = CGSizeMake(132.f, 108.0f);
//        [hud hide:YES afterDelay:3];
//        return NO;
//    }
    
    return isExistenceNetwork;
}




@end
