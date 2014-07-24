//
//  MessageApplyViewController.h
//  Mifan
//
//  Created by ryan on 14-5-27.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "WaiqinHttpClient.h"
#import "KeychainItemWrapper.h"
#import "User.h"

@interface MessageApplyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) Message *message;
@property (nonatomic, strong) WaiqinHttpClient *client;
@property (nonatomic, strong) KeychainItemWrapper *wrapper;
@property (nonatomic, strong) User *user;
@property (nonatomic, weak) NSString *statusString;
@end
