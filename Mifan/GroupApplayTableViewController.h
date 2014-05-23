//
//  GroupApplayTableViewController.h
//  Mifan
//
//  Created by ryan on 14-5-20.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "KeychainItemWrapper.h"
#import "User.h"
#import "WaiqinHttpClient.h"
#import "Group.h"

@interface GroupApplayTableViewController : UITableViewController<UITextViewDelegate, WaiqinHttpClientDelegate>

@property (weak, nonatomic) MBProgressHUD *hud;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (retain, nonatomic) User *user;
@property (retain, nonatomic) WaiqinHttpClient *client;
@property (nonatomic, retain) Group *group;

- (IBAction)sendButtonClick:(id)sender;

@end
