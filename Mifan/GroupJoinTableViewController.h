//
//  GroupJoinTableViewController.h
//  Mifan
//
//  Created by ryan on 14-4-24.
//  Copyright (c) 2014年 ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "KeychainItemWrapper.h"
#import "User.h"
#import "WaiqinHttpClient.h"
#import "Group.h"

@interface GroupJoinTableViewController : UITableViewController

@property (weak, nonatomic) MBProgressHUD *hud;
@property (retain, nonatomic) KeychainItemWrapper *wrapper;
@property (retain, nonatomic) User *user;
@property (retain, nonatomic) WaiqinHttpClient *client;
@property (nonatomic, retain) Group *group;

- (IBAction)searchButtonClick:(id)sender;

@end
